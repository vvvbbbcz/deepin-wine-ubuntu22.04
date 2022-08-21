#!/bin/bash
echo '正在准备卸载...'
sudo apt purge ./*deepin*wine*.deb udis86:i386
sudo apt autoremove --purge
echo '卸载完成...'
