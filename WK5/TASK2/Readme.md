

# Log Analysis and Reporting Tool

## Overview

This Bash script processes web server log files to extract relevant information about errors and high-traffic periods, generating a daily report. It accepts command-line arguments for customization and uses various Bash features and command-line utilities to provide insights into web server performance and issues.

## Usage

### Command-Line Arguments

The script requires two command-line arguments:
1. The path to the log file.
2. The date for which the log should be processed (in `YYYY-MM-DD` format).


## Script functions

1. Analyze Errors
The analyze_errors function extracts and analyzes errors (status codes 500 and above) from the log file for the specified date. It provides a summary of the error counts.

2. Analyze High-Traffic Periods
The analyze_traffic function identifies high-traffic periods from the log file for the specified date, providing a summary of traffic counts by period.

3. Generate JSON Report
The generate_report function creates a JSON-formatted report that includes the date, errors, and traffic information. It uses the jq utility to format the report.

4. Main Execution
The main function orchestrates the execution of the script, calling the necessary functions to process the logs and generate the report.


### Running the Script

To run the script, use the following command:

```bash
./script.sh <log_file_path> <date>



