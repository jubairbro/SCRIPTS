#!/bin/bash

# Restart all listed services
sudo systemctl restart ssh
sudo systemctl restart nginx
sudo systemctl restart dropbear
sudo systemctl restart haproxy
sudo systemctl restart fail2ban
sudo systemctl restart cron
sudo systemctl restart vnstat
sudo systemctl restart xray

# Restart WebSocket services
sudo systemctl restart ws-nontls.service
sudo systemctl restart ws-stunnel.service

echo "All services have been restarted."
