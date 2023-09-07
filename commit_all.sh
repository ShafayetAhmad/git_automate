#!/bin/bash

# Define the root folder to search for subfolders with .git folders
root_folder="/path/to/your/root/folder"

# Function to check if a folder contains a .git folder
function has_git_folder() {
  if [ -d "$1/.git" ]; then
    return 0  # Return success (0) if .git folder found
  else
    return 1  # Return failure (1) if .git folder not found
  fi
}

# Loop through all subfolders in the root folder
for folder in "$root_folder"/*; do
  if [ -d "$folder" ] && has_git_folder "$folder"; then
    echo "Found .git folder in $folder"
    cd "$folder"
    
    # Perform Git actions
    git pull
    git add .
    git commit -m "add all"
    git push
    
    cd "$root_folder"  # Return to the root folder
  fi
done

echo "Finished processing all subfolders."
