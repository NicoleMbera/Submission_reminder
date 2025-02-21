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
