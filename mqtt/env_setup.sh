#!/bin/bash

#To use the new repository you should first import the repository package signing key:  
wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key  
sudo apt-key add mosquitto-repo.gpg.key  
   
#Then make the repository available to apt:  
cd /etc/apt/sources.list.d/  
   
#Then one of the following, depending on which version of debian you are using:  
sudo wget http://repo.mosquitto.org/debian/mosquitto-wheezy.list  
    
#Then update apt information:  
sudo apt-get update  
   
#And discover what mosquitto packages are available:  
sudo apt-cache search mosquitto  
   
##Or just install:
#安装服务端
sudo apt-get install mosquitto
#安装客户端 （订阅sub  与 发布pub）
sudo apt-get install mosqutitto-client
#安装调试器
sudo apt-get install mosquitto-dbg
