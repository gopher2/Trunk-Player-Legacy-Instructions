## Trunk-Recorder and Trunk-Player (Legacy) Instructions

This will guide you on the process of installing Trunk-Recorder and Trunk-Player. It is specific to setting up a Airspy device on the on the MPSCS but can be customize for other radio / systems. 

## Install the OS

- Start with a fresh install of Ubuntu 22.04.1 LTS x64
- Add a user 'radio' during the OS install

## Update the system

```
sudo apt-get update
sudo apt-get upgrade
```

## Setup udev rules for the Airspy
```
sudo usermod -a -G plugdev radio
sudo bash -c 'echo SUBSYSTEM=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="60a1", GROUP="plugdev", MODE="0666", SYMLINK+="airspy-%K", MODE="660", GROUP="plugdev" > /etc/udev/rules.d/airspy.rules'
sudo chmod u=rw,g=r,o=r /etc/udev/rules.d/airspy.rules
sudo udevadm control --reload-rules
```
