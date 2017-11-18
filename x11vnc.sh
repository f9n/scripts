#!/usr/bin/env bash

MY_X11VNC_PASS=123456

sudo mkdir /etc/x11vnc
sudo x11vnc --storepasswd ${MY_X11VNC_PASS} /etc/x11vnc/passwd

cat << EOF > /lib/systemd/system/x11vnc.service
[Unit]
Description=Start x11vnc at startup.
After=multi-user.target
[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -auth guess -forever -noxdamage -repeat -rfbauth /etc/x11vnc/passwd -rfbport 5900 -shared
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable x11vnc.service
sudo systemctl start x11vnc.service
