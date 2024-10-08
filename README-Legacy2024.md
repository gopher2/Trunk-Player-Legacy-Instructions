## Trunk-Recorder and Trunk-Player (Legacy) Instructions

This will guide you on the process of installing Trunk-Recorder and Trunk-Player. It is specific to setting up a Airspy device on the on the MPSCS but can be customized for other radio / systems. It depends on the specific version of Ubuntu listed, other versions will not work.

## Install the OS

- Start with a fresh install of Ubuntu 20.04.5 LTS x64
- Add a user 'radio' during the OS install

## Update the system

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install fdkaac vim bc build-essential cmake git gnuradio-dev gr-osmosdr lame liborc-0.4-dev libffi-dev libboost-all-dev libcurl4-openssl-dev libhackrf-dev libsndfile1-dev libncurses-dev libpq-dev libssl-dev libuhd-dev libusb-1.0-0-dev nginx postgresql postgresql-client postgresql-client-common python3-dev python3-pip redis-server sox supervisor virtualenv

```

## Setup udev rules for the Airspy
```
sudo usermod -a -G plugdev radio
sudo bash -c 'echo "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"1d50\", ATTRS{idProduct}==\"60a1\", GROUP=\"plugdev\", MODE=\"0660\", SYMLINK+=\"airspy-%k\"" > /etc/udev/rules.d/airspy.rules'
sudo chmod u=rw,g=r,o=r /etc/udev/rules.d/airspy.rules
sudo udevadm control --reload-rules
```

## Download and install Trunk-Recorder
```
cd ~
mkdir trunk-recorder-build
git clone https://github.com/robotastic/trunk-recorder.git
cd ~/trunk-recorder-build
cmake ../trunk-recorder
make -j$(nproc)
curl https://raw.githubusercontent.com/gopher2/Trunk-Player-Legacy-Instructions/main/config-airspymini.json -o config.json
cp /home/radio/trunk-recorder/examples/auto-restart.sh /home/radio/trunk-recorder-build/
chmod +x /home/radio/trunk-recorder-build/auto-restart.sh
curl https://raw.githubusercontent.com/gopher2/Trunk-Player-Legacy-Instructions/main/trunk-recorder.service -o trunk-recorder.service
sudo mv trunk-recorder.service /etc/systemd/system/trunk-recorder.service
sudo systemctl daemon-reload
sudo systemctl enable trunk-recorder.service
```

## Download and install Trunk-Player
```
cd ~
git clone https://github.com/gopher2/trunk-player.git
cd trunk-player
virtualenv -p python3 env --prompt='(Trunk Player)'
source env/bin/activate
pip install -r requirements.txt
cp trunk_player/settings_local.py.sample trunk_player/settings_local.py
djpass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#+' | fold -w 64 | head -n 1)
ip4=`ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}'`
sed -i "s/^SECRET_KEY = .*/SECRET_KEY = '$djpass'/" trunk_player/settings_local.py
sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['$ip4'\]/g" trunk_player/settings_local.py
sed -i "s/SITE_TITLE = 'Trunk-Player'/SITE_TITLE = 'MPSCS'/g" trunk_player/settings_local.py
sed -i "s/AUDIO_URL_BASE = '\/\/s3.amazonaws.com\/SET-TO-MY-BUCKET\/'/AUDIO_URL_BASE = '\/audio_files\/'/g" trunk_player/settings_local.py
echo TIME_ZONE = \'America/Detroit\' >> trunk_player/settings_local.py
unset djpass
curl https://raw.githubusercontent.com/gopher2/Trunk-Player-Legacy-Instructions/main/postgres_setup.sql -o postgres_setup.sql
dbpass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#+' | fold -w 12 | head -n 1)
sed -i "s/'PASSWORD': 'fake_password',/'PASSWORD': '$dbpass',/" trunk_player/settings_local.py
sed -i "s/__DB_PASS__/$dbpass/g" postgres_setup.sql
sudo chown postgres postgres_setup.sql
sudo -u postgres psql < postgres_setup.sql
rm -rf postgres_setup.sql
unset dbpass
```

## Import Talkgroups, run Database Migrations, add a user
```
curl https://raw.githubusercontent.com/gopher2/Trunk-Player-Legacy-Instructions/main/talkgroups_mpscs_old.csv -o talkgroups.csv
./manage.py migrate
./manage.py import_talkgroups --system 0 --truncate talkgroups.csv 
./manage.py collectstatic --noinput
./manage.py createsuperuser
```

## Setup Nginx and Supervisor, start the recorder
```
sudo mkdir /var/log/trunk-player
sudo chown radio:radio /var/log/trunk-player
cp trunk_player/trunk_player.nginx.sample trunk_player/trunk_player.nginx
sudo ln -s /home/radio/trunk-player/trunk_player/trunk_player.nginx /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
cp trunk_player/supervisor.conf.sample trunk_player/supervisor.conf
sudo ln -f -s /home/radio/trunk-player/trunk_player/supervisor.conf /etc/supervisor/conf.d/trunk_player.conf
sudo supervisorctl reread
sudo supervisorctl update
cp /home/radio/trunk-player/utility/trunk-recoder/encode-local-sys-0.sh  /home/radio/trunk-recorder-build/encode-local-sys-0.sh
sudo supervisorctl start trunkplayer:
sudo systemctl start trunk-recorder.service
```

