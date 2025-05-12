#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0"
    echo "This script will organize all photos and videos from day folders into a Collated folder, organized by person."
    exit 1
}

# Create Collated folder
collated_folder="Collated"
mkdir -p "$collated_folder"

# Process each day folder
for day_folder in *"Day"*; do
    if [ -d "$day_folder" ]; then
        echo "Processing $day_folder..."
        
        # Process all person folders in this day folder
        for person_folder in "$day_folder"/*/; do
            if [ -d "$person_folder" ]; then
                person_name=$(basename "$person_folder")
                
                # Check if there are any files to move
                if [ "$(ls -A "$person_folder")" ]; then
                    echo "  Moving $person_name's content..."
                    
                    # Create person's folder if it doesn't exist
                    mkdir -p "$collated_folder/$person_name"
                    
                    # Create day folder under person's folder and move content
                    mkdir -p "$collated_folder/$person_name/$day_folder"
                    mv "$person_folder"/* "$collated_folder/$person_name/$day_folder/" 2>/dev/null || true
                else
                    echo "  Removing empty folder for $person_name..."
                fi
                
                # Remove the person folder whether it had content or not
                rmdir "$person_folder" 2>/dev/null || true
            fi
        done
        
        rmdir "$day_folder" 2>/dev/null || true
    fi
done

echo "Organization complete! All content has been moved to $collated_folder" 