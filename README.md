# Various Instructions

Me and my friends enjoy setting up trunk-recorder / trunk-player servers and have multiple instances deployed across the state of Michigan. Below are step by step instructions on how to deploy a working site. 

- [Ubuntu 22.04, Airspy Mini, Latest version of Trunk-Player](https://github.com/gopher2/Trunk-Player-Legacy-Instructions/blob/main/README-Legacy.md)

- [Ubuntu 20.04, Airspy Mini, older 2021 version Trunk-Player](https://github.com/gopher2/Trunk-Player-Legacy-Instructions/blob/main/README-Legacy2020.md)


# Tips and Tricks
- Stop the trunk-recorder service
```sudo systemctl stop trunk-recorder```
- Start the trunk-recorder service
```sudo systemctl start trunk-recorder```
- Restart the trunk-recorder service
```sudo systemctl restart trunk-recorder```

Stop the nginx service (Web Server)
```sudo systemctl stop nginx.service```
Start the nginx service 
```sudo systemctl start nginx.service```
Restart the nginx service
```sudo systemctl restart nginx.service```

Stop the  (Web Server)
```sudo systemctl stop nginx.service```
Start the trunk-recorder service
```sudo systemctl start nginx.service```
Restart the trunk-recorder service
```sudo systemctl restart nginx.service```
