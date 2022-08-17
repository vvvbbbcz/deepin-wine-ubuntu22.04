#!/bin/bash
echo '正在准备卸载...'
sudo apt purge ./*deepin*wine* udis86
sudo apt autoremove
echo '卸载完成...'
