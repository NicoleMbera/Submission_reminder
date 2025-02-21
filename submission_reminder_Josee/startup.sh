#!/bin/bash

# Verify system integrity
if [ ! -f "./config/config.env" ]; then
    echo "Error: Missing configuration file"
    exit 1
fi

if [ ! -f "./modules/functions.sh" ]; then
    echo "Error: Missing core functions"
    exit 1
fi

if [ ! -f "./reminder.sh" ]; then
    echo "Error: Missing main script"
    exit 1
fi

if [ ! -f "./assets/submissions.txt" ]; then
    echo "Error: Missing submission records"
    exit 1
fi

# Set permissions
if [ ! -x "./reminder.sh" ]; then
    chmod +x ./reminder.sh
    echo "Permissions updated for main script"
fi

# Launch application
echo "-----------------------------------"
./reminder.sh

