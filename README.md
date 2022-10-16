# Instructions

I enjoy setting up trunk-recorder / trunk-player servers and have multiple instances deployed across the state of Michigan. Below are step by step instructions we use as a reference when deploying sites.

- [Trunk-Player (latest) on Ubuntu 22.04 w/Airspy Mini](https://github.com/gopher2/Trunk-Player-Legacy-Instructions/blob/main/README-Legacy.md)

- [Trunk-Player (2021 build) on Ubuntu 20.04 w/Airspy Mini](https://github.com/gopher2/Trunk-Player-Legacy-Instructions/blob/main/README-Legacy2020.md)


# Tips and Tricks

Trunk Recorder
- Stop: ```sudo systemctl stop trunk-recorder```
- Start: ```sudo systemctl start trunk-recorder```
- Restart ```sudo systemctl restart trunk-recorder```
- Live Logs ```sudo journalctl -f -u trunk-recorder.service```

Nginx (webserver/proxy)
- Stop: ```sudo systemctl stop nginx.service```
- Start: ```sudo systemctl start nginx.service```
- Restart: ```sudo systemctl restart nginx.service```
- Live Logs: ```sudo tail -f /var/log/nginx/*```

Supervisor (Application Server)
- Stop: ```sudo supervisorctl stop trunkplayer:```
- Start: ```sudo supervisorctl start trunkplayer:```
- Restart: ```sudo supervisorctl reop trunkplayer:```

Postgres Database
- Delete database and user: 
```
sudo -i -u postgres psql -U postgres -c "DROP DATABASE trunk_player"
sudo -i -u postgres psql -U postgres -c "DROP USER trunk_player_user"
```


