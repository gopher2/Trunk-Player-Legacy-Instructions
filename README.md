# Various Instructions

Me and my friends enjoy setting up trunk-recorder / trunk-player servers and have multiple instances deployed across the state of Michigan. Below are step by step instructions on how to deploy a working site. 

- [Ubuntu 22.04, Airspy Mini, Latest version of Trunk-Player](https://github.com/gopher2/Trunk-Player-Legacy-Instructions/blob/main/README-Legacy.md)

- [Ubuntu 20.04, Airspy Mini, older 2021 version Trunk-Player](https://github.com/gopher2/Trunk-Player-Legacy-Instructions/blob/main/README-Legacy2020.md)


# Tips and Tricks

-Trunk Recorder
- Stop
```sudo systemctl stop trunk-recorder```
- Start
```sudo systemctl start trunk-recorder```
- Restart 
```sudo systemctl restart trunk-recorder```

-Nginx (webserver)
- Stop
```sudo systemctl stop nginx.service```
- Start
```sudo systemctl start nginx.service```
- Restart
```sudo systemctl restart nginx.service```

Stop the  (Web Server)
```sudo systemctl stop nginx.service```
Start the trunk-recorder service
```sudo systemctl start nginx.service```
Restart the trunk-recorder service
```sudo systemctl restart nginx.service```
