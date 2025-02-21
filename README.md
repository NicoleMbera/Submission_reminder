Submission Reminder Application

Overview

This script is designed to help track assignment submissions and provide reminders about upcoming deadlines. It reads a list of submissions and checks the status for each student.

Prerequisites

Ensure you have the following installed:

A Linux-based system (or WSL on Windows)

Bash (version 4.0 or higher)

Git (optional, for version control)

Directory Structure

submission_reminder/
│-- config/
│   ├── config.env
│-- modules/
│   ├── functions.sh
│-- assets/
│   ├── submissions.txt
│-- startup.sh

Installation & Setup

1. Clone the Repository

If using Git, clone the repository:

git clone https://github.com/NicoleMbera/submission_reminder_app.git
cd submission_reminder

If not using Git, download and extract the repository manually.

2. Make Scripts Executable

Ensure the necessary scripts have execution permissions:

chmod +x startup.sh
chmod +x modules/functions.sh

3. Configure Environment Variables

Edit the config.env file inside the config/ folder to set your assignment details:

nano config/config.env

Example configuration:

ASSIGNMENT="Final Project Report"
DAYS_REMAINING=5

Save and exit (CTRL + X, then Y to confirm changes).

Running the Application

To execute the script and check submissions, run:

./startup.sh

This will:

Load environment variables and functions.

Display the assignment name and remaining days.

Check the submissions.txt file for submitted assignments.

Expected Output

If everything runs correctly, the output should look like this:

======== Submission Reminder System ========
Reminder for Assignment: Final Project Report
Deadline Approaching: 5 days left
--------------------------------------------
Checking submission status...

Troubleshooting

If you get a permission denied error, run:

chmod +x startup.sh

If submissions.txt is missing, create it inside assets/ and add student names.

License

This project is released under the MIT License.

Author

Nicole Mbera Umurerwa

