#!/bin/bash

# Load dependencies
source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

# Display task status
echo "Current Task: $ASSIGNMENT"
echo "Deadline: $DAYS_REMAINING days remaining"
echo "----------------------------------------"

check_submissions $submissions_file
