#!/bin/bash

# Get today's date in YYYYMMDD format
DATE=$(date +"%Y%m%d")

# Prompt for day number
read -p "Enter the day number of the trip: " DAY_NUM

# Prompt for surf spots
read -p "Enter the surf spots visited (separated by spaces): " SURF_SPOTS

# Create the folder name
FOLDER_NAME="${DATE} Day ${DAY_NUM} ${SURF_SPOTS}"

# Create the main folder
mkdir -p "$FOLDER_NAME"

# Copy the template structure
cp -r template/* "$FOLDER_NAME/"

echo "Created folder structure: $FOLDER_NAME"
echo "Template folders have been copied successfully." 