# Mac-Changer Start-up Service 

## How to install 
cp mac-changer /usr/bin/mac-changer
cp my-startup.service /etc/systemd/system/my-startup.service

## Enable the service
systemctl enable my-startup.service

## Initializing the service
systemctl start my-startup.service

## Monitoring 
tail -f /var/log/syslog

