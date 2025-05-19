#!/bin/bash

# Define the script content
RESTART_SCRIPT="/usr/local/bin/restart.sh"
CRON_JOB="0 4 * * * /usr/local/bin/restart.sh"

# Remove the restart script
if [ -f $RESTART_SCRIPT ]; then
    sudo rm $RESTART_SCRIPT
    echo "Restart script removed."
else
    echo "Restart script not found."
fi

# Remove the cron job
# Check if the cron job exists
CRON_EXISTS=$(sudo crontab -l 2>/dev/null | grep -F "$CRON_JOB" || true)
if [ -n "$CRON_EXISTS" ]; then
    # If the cron job exists, remove it
    (sudo crontab -l 2>/dev/null | grep -vF "$CRON_JOB") | sudo crontab -
    echo "Cron job removed."
else
    echo "Cron job not found."
fi

echo "Turn off setup complete."
