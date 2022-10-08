## Trunk-Recorder and Trunk-Player (Legacy) Instructions

This will guide you on the process of installing Trunk-Recorder and Trunk-Player. It is specific to setting up a Airspy device on the on the MPSCS but can be customized for other radio / systems. 

## Install the OS

- Start with a fresh install of Ubuntu 22.04.1 LTS x64
- Add a user 'radio' during the OS install

## Update the system

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install vim bc build-essential cmake git gnuradio-dev gr-osmosdr lame libffi-dev libboost-all-dev libcurl4-nss-dev libhackrf-dev libsndfile-dev libncurses-dev libpq-dev libssl-dev libuhd-dev libusb-1.0-0.dev nginx postgresql postgresql-client postgresql-client-common python3-dev python3-pip redis-server sox supervisor virtualenv
```

## Setup udev rules for the Airspy
```
sudo usermod -a -G plugdev radio
sudo bash -c 'echo SUBSYSTEM=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="60a1", GROUP="plugdev", MODE="0666", SYMLINK+="airspy-%K", MODE="660", GROUP="plugdev" > /etc/udev/rules.d/airspy.rules'
sudo chmod u=rw,g=r,o=r /etc/udev/rules.d/airspy.rules
sudo udevadm control --reload-rules
```

## Download and install Trunk-Recorder
```
cd ~
mkdir trunk-recorder-build
git clone https://github.com/robotastic/trunk-recorder.git
cd trunk-recorder-build
cmake ../trunk-recorder
make -j$(nproc)
curl https://github.com/gopher2/Trunk-Player-Legacy-Instructions/blob/main/config-airspymini.json -o config.json
cp /home/radio/trunk-recorder/examples/auto-restart.sh /home/radio/trunk-recorder-build/
chmod +x /home/radio/trunk-recorder-build/auto-restart.sh
curl https://raw.githubusercontent.com/gopher2/Trunk-Player-Legacy-Instructions/main/trunk-recorder.service -o trunk-recorder.service
sudo mv trunk-recorder.service /etc/systemd/system/trunk-recorder.service
sudo systemctl daemon-reload
sudo systemctl enable trunk-recorder.service
```

## Download and install Trunk-Player
```
git clone https://github.com/gopher2/trunk-player.git
cd trunk-player
virtualenv -p python3 env --prompt='(Trunk Player)'
source env/bin/activate
pip install -r requirements.txt
cp trunk_player/settings_local.py.sample trunk_player/settings_local.py
djpass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#+' | fold -w 64 | head -n 1)
sed -i "s/^SECRET_KEY = .*/SECRET_KEY = '$djpass'/" trunk_player/settings_local.py
sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['10.1.10.108'\]/g" trunk_player/settings_local.py
sed -i "s/SITE_TITLE = 'Trunk-Player'/SITE_TITLE = 'MPSCS'/g" trunk_player/settings_local.py
sed -i "s/AUDIO_URL_BASE = '\/\/s3.amazonaws.com\/SET-TO-MY-BUCKET\/'/AUDIO_URL_BASE = '\/audio_files\/'/g" trunk_player/settings_local.py
echo TIME_ZONE = \'America/Detroit\' >> trunk_player/settings_local.py
unset djpass
```

## Import Talkgroups
```
curl https://raw.githubusercontent.com/gopher2/Trunk-Player-Legacy-Instructions/main/talkgroups_mpscs.csv -o talkgroups.csv
./manage.py migrate
./manage.py import_talkgroups --system 0 --truncate talkgroups.csv
./manage.py collectstatic --noinput
./manage.py createsuperuser
```
