#!/bin/bash

script_dir="$(dirname "$0")"
webhook_url="https://discord.com/api/webhooks/1310304175661387877/PbZwMD80C-00Tjyy3PN1gt9jpKTGfPjFCOK05bXEDWCYWADpGJRsxuy6nVRtloXHuNIX"

# Function to send Discord webhook
send_webhook() {
    local message="$1"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\":\"$message\"}" "$webhook_url" 2>/dev/null
}

# Kill the main daemon process
if [ -f "$script_dir/bomber.pid" ]; then
    pid=$(cat "$script_dir/bomber.pid")
    kill $pid 2>/dev/null
    rm "$script_dir/bomber.pid"
    send_webhook "🛑 Main bomber daemon (PID: $pid) stopped"
fi

# Kill all bombing processes for each number
while IFS= read -r number; do
    if [ -d "$script_dir/temp_$number" ]; then
        # Kill processes for this number
        pkill -f "temp_$number"
        # Remove temp directory
        rm -rf "$script_dir/temp_$number"
        send_webhook "🛑 Stopped all bombing processes for number: $number"
    fi
done < "$script_dir/active_numbers.txt"

send_webhook "✅ All bombing processes have been terminated"

echo "SMS Bomber stopped successfully!"
