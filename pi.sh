#!/bin/bash

#Raspberry Pi Headless Deployment Script 
printf "Hello to the Raspberry Pi Setup Script \n please insert the SDcard you wish to use"

echo "Downloading the Latest Raspbian image "  
wget  https://downloads.raspberrypi.org/raspbian_latest -O pi.img  & #Downloads Raspbian iamge with the wget Script 
echo "Downloading..."

### Flashing SDCard ### 
echo "If asked please enter your user password"
sudo fdisk -l | grep "Disk /dev/s"
echo "Please Enter the sdcard in which you would like to use:  ex:""/dev/sda"""
read disk
echo "This will take sometime, grab a coffee  ... "
dd bs=4M if=pi.img of=$disk


# mount the sdcard 
sudo mkdir -p /mnt/pi
sudo mount $disk"2" /mnt/pi

clear
echo "Please Enter Your Network SSID:"
read ssid
echo "Please Enter Your Network Password: (Your Password will not appear in the console ) "
read -s pass
sudo echo "network={" >> /mnt/pietc/wpa_supplicant/wpa_supplicant.conf
sudo echo "ssid=$ssid" >> /mnt/pietc/wpa_supplicant/wpa_supplicant.conf
sudo echo "psk=$pass" >> /mnt/pietc/wpa_supplicant/wpa_supplicant.conf
sudo echo "}" >> /mnt/pietc/wpa_supplicant/wpa_supplicant.conf

sudo umount $disk

echo "Done! You may now remove your SDCard"
