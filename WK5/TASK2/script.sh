#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <log_file_path> <date>"
    exit 1
fi

log_file="$1"
date_to_process="$2"


# Function to analyze errors
analyze_errors() {
    errors=$(awk -v date="$date_to_process" '$4 ~ date && $9 >= 500 { print $9 }' "$log_file")
    if [[ -z "$errors" ]]; then
        echo "No errors found on $date_to_process."
    else
        echo "Errors found on $date_to_process:"
        echo "$errors" | sort | uniq -c | sort -nr
    fi
}


# Function to analyze high-traffic periods
analyze_traffic() {
    traffic=$(awk -v date="$date_to_process" '$4 ~ date { print $4 }' "$log_file")
    if [[ -z "$traffic" ]]; then
        echo "No traffic data found for $date_to_process."
    else
        echo "High-traffic periods on $date_to_process:"
        echo "$traffic" | uniq -c | sort -nr
    fi
}


# Generate JSON report
generate_report() {
    report=$(jq -n \
        --arg date "$date_to_process" \
        --argjson errors "$(analyze_errors)" \
        --argjson traffic "$(analyze_traffic)" \
        '{ date: $date, errors: $errors, traffic: $traffic }')
    echo "$report"
}


# Main execution
main() {
    echo "Processing logs for $date_to_process..."
    report=$(generate_report)
    echo "$report"
}

main
