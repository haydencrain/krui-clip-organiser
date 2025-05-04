#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0"
    echo "This script will prompt for a person's name and organize their photos and videos"
    echo "from all day folders into a master folder."
    exit 1
}

# Check if rsync is installed
if ! command -v rsync &> /dev/null; then
    echo "Error: rsync is not installed. Please install it first."
    echo "On macOS, you can install it using: brew install rsync"
    exit 1
fi

# Prompt for person's name
read -p "Enter the person's name (e.g., Felipe, Hayden, etc.): " person_name

# Create master folder for the person
master_folder="${person_name}_Master"
mkdir -p "$master_folder"

# Find all day folders (matching pattern YYYYMMDD Day X)
for day_folder in *"Day"*; do
    if [ -d "$day_folder" ]; then
        echo "Processing $day_folder..."
        
        # Create corresponding folder in master directory
        mkdir -p "$master_folder/$day_folder"
        
        # Copy person's specific content if it exists
        if [ -d "$day_folder/$person_name" ]; then
            echo "  Copying $person_name's content..."
            rsync -av --progress "$day_folder/$person_name/" "$master_folder/$day_folder/"
        fi
        
        # Copy Shared content
        if [ -d "$day_folder/Shared" ]; then
            echo "  Copying Shared content..."
            rsync -av --progress "$day_folder/Shared/" "$master_folder/$day_folder/"
        fi
    fi
done

echo "Organization complete! All content has been copied to $master_folder" 