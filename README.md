# Various Instructions

Me and my friends enjoy setting up trunk-recorder / trunk-player servers and have multiple instances deployed across the state of Michigan. Below are step by step instructions on how to deploy a working site. 

- [Ubuntu 22.04, Airspy Mini, Latest version of Trunk-Player](https://github.com/gopher2/Trunk-Player-Legacy-Instructions/blob/main/README-Legacy.md)

- [Ubuntu 20.04, Airspy Mini, older 2021 version Trunk-Player](https://github.com/gopher2/Trunk-Player-Legacy-Instructions/blob/main/README-Legacy2020.md)


# Tips and Tricks

Trunk Recorder
- Stop: ```sudo systemctl stop trunk-recorder```
- Start: ```sudo systemctl start trunk-recorder```
- Restart ```sudo systemctl restart trunk-recorder```

Nginx (webserver/proxy)
- Stop: ```sudo systemctl stop nginx.service```
- Start: ```sudo systemctl start nginx.service```
- Restart: ```sudo systemctl restart nginx.service```

Supervisor (Application Server)
- Stop: ```sudo supervisorctl stop trunkplayer:```
- Start: ```sudo supervisorctl start trunkplayer:```
- Restart: ```sudo supervisorctl reop trunkplayer:```

Postgres Database
- Delete database and user: 
sudo -i -u postgres psql -U postgres -c "DROP USER trunk_player_user"
sudo -i -u postgres psql -U postgres -c "DROP DATABASE trunk_player"

