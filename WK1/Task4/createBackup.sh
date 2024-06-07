#!/bin/bash

# my source and destination directories
source_dir="../Task1/Assets"
backup_dir="../Task4"

# Create a timestamp of when the backup creation was made 

timestamp=$(date +"%Y%m%d%H%M%S")
echo "timestamp: $timestamp"
backup_file="backup-$timestamp.tar.gz"


# Create the backup 
tar -czf "$backup_dir/$backup_file" "$source_dir"

echo "Backup created: $backup_dir/$backup_file"
