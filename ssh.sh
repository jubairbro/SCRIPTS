#!/bin/bash

# Function to download and execute script
download_and_execute() {
    local url="$1"
    local filename="$2"

    wget -q -O "$filename" "$url"  # Download script quietly
    if [ $? -ne 0 ]; then
        echo "Failed to download $filename script."
        return 1
    fi

    chmod +x "$filename"  # Make script executable
    "./$filename"  # Execute script
    if [ $? -ne 0 ]; then
        echo "Failed to execute $filename script."
        return 1
    fi
}

# URLs and filenames
declare -a urls=(
    "https://github.com/jubairbro/SCRIPTS/raw/main/sshe.x"
    "https://github.com/jubairbro/SCRIPTS/raw/main/sshc.x"
    "https://github.com/jubairbro/SCRIPTS/raw/main/sshd.x"
)

declare -a filenames=(
    "sshe.x"
    "sshc.x"
    "sshd.x"
)

# Loop through each URL and filename
for (( i=0; i<${#urls[@]}; i++ )); do
    url="${urls[i]}"
    filename="${filenames[i]}"
    
    echo "Downloading and executing $filename script..."
    download_and_execute "$url" "$filename"
    
    if [ $? -ne 0 ]; then
        echo "Continuing with next script..."
    else
        echo "$filename script executed successfully."
    fi
done

echo "All scripts executed."
