#!/bin/bash

# Function to validate input (no special characters or spaces)
validate_input() {
    if [[ "$1" =~ [^a-zA-Z0-9_] ]]; then
        echo "Invalid format: Username must contain only letters, numbers and underscores."
        return 1
    fi
    return 0
}

# Initialize interface
clear
echo ""
echo "    Task Tracker Setup Utility    "
echo ""
echo

# Get username input
while true; do
    echo -n "Enter username (alphanumeric + underscore only): "
    read user_name
    
    if validate_input "$user_name"; then
        break
    fi
done

# Initialize workspace
main_dir="submission_reminder_${user_name}"
echo -e "\nInitializing workspace in $main_dir..."

if [ -d "$main_dir" ]; then
    echo "Notice: Workspace $main_dir exists."
    echo -n "Proceed with reset? (y/n): "
    read response
    if [ "$response" != "y" ] && [ "$response" != "Y" ]; then
        echo "Operation cancelled."
        exit 1
    fi
    rm -rf "$main_dir"
    echo "Previous workspace cleared."
fi

# Create directory structure
mkdir -p "$main_dir"/{assets,config,modules}
echo "✓ Directory structure initialized"

# Generate config file
cat > "$main_dir/config/config.env" << 'EOF'
# Configuration settings
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
echo "✓ Configuration file generated"

# Generate core functions
cat > "$main_dir/modules/functions.sh" << 'EOF'
#!/bin/bash

# Process submission records and identify pending tasks
function check_submissions {
    local submissions_file=$1
    echo "Processing submission records from $submissions_file"

    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Alert: $student needs to submit $ASSIGNMENT!"
        fi
    done < <(tail -n +2 "$submissions_file")
}
EOF
echo "✓ Core functions implemented"

# Generate main script
cat > "$main_dir/reminder.sh" << 'EOF'
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
EOF
echo "✓ Main script generated"

# Generate submission records
cat > "$main_dir/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Alex, Shell Navigation, not submitted
Morgan, Git Basics, submitted
Jordan, Shell Navigation, not submitted
Taylor, Shell Basics, submitted
Casey, Shell Navigation, not submitted
EOF
echo "✓ Submission records initialized"

# Generate launcher script
cat > "$main_dir/startup.sh" << 'EOF'
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

EOF
echo "✓ Launcher script generated"

# Set execution permissions
chmod +x "$main_dir/reminder.sh" "$main_dir/modules/functions.sh" "$main_dir/startup.sh"
echo "✓ Execution permissions set"

echo -e "\nSetup complete! Workspace ready in '$main_dir'"
echo -e "To launch the system, run:\n"
echo "cd $main_dir && ./startup.sh"