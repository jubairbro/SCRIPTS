#!/bin/bash

# Define the script content
RESTART_SCRIPT="/usr/local/bin/restart.sh"
CRON_JOB="0 4 * * * /usr/local/bin/restart.sh"

# Create the restart script
echo "#!/bin/bash" | sudo tee $RESTART_SCRIPT > /dev/null
echo "/sbin/reboot" | sudo tee -a $RESTART_SCRIPT > /dev/null

# Make the restart script executable
sudo chmod +x $RESTART_SCRIPT

# Add the cron job
# Check if the cron job already exists
CRON_EXISTS=$(sudo crontab -l 2>/dev/null | grep -F "$CRON_JOB" || true)
if [ -z "$CRON_EXISTS" ]; then
    # If the cron job does not exist, add it
    (sudo crontab -l 2>/dev/null; echo "$CRON_JOB") | sudo crontab -
    echo "Cron job added to restart system every day at 4 AM."
else
    echo "Cron job already exists."
fi

echo "Setup complete."
