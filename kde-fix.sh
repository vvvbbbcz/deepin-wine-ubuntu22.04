#!/bin/bash
cd `dirname $0`; pwd
echo '===准备加入KDE启动支持==='
sudo apt install gnome-settings-daemon
echo '===添加gsd-xsettings启动项==='
mkdir -p $HOME/.config/autostart-scripts
echo '#!/bin/bash' > $HOME/.config/autostart-scripts/gsd-xsettings.sh
echo '/usr/libexec/gsd-xsettings' >> $HOME/.config/autostart-scripts/gsd-xsettings.sh
chmod +x $HOME/.config/autostart-scripts/gsd-xsettings.sh
echo '===执行完成，重启生效==='
