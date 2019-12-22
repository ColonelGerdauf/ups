#!/bin/bash

os=$(uname -o);
declare -u os;

wget -nd https://raw.githubusercontent.com/buyapi/ups/master/scripts/ups;
wget -nd https://raw.githubusercontent.com/buyapi/ups/master/scripts/ups.service;

chmod 0510 ups;
chmod 0510 ups.service;

chown -f root:root ups;
chown -f root:root ups.service;

if [ "$os" = "LIBREELEC" ] || [ "$os" = "OPENELEC" ]
then
        # these will run as normal, as the default user account is root
        mkdir -p /storage/.kodi/addons/ups_power/bin;
        mv -f ups /storage/.kodi/addons/ups_power/bin;
        chmod 0555 /storage/.kodi/addons/ups_power/;
  
        sed -e "s:ExecStart=\/bin\/ups\/:ExecStart=\/storage\/.kodi\/addons\/ups_power\/bin:" ups.service
        mv -f ups.service /storage/.config/system.d/;
else
        mv -f ups /bin/;
        mv -f ups.service /etc/systemd/system/;
fi
