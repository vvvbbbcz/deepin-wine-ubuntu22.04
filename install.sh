#!/bin/bash
cd `dirname $0`; pwd
echo '准备添加32位支持'
sudo dpkg --add-architecture i386
echo '添加成功，准备刷新apt缓存信息...'
sudo apt update
echo '安装gcc依赖...'
sudo apt install gcc
echo '即将开始安装...'
sudo dpkg -i *.deb
echo '安装完成，正在自动安装依赖...'
sudo apt install -f


