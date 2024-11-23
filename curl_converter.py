def convert_curl_command(curl_command):
    # Split the command into lines and remove empty lines
    lines = [line.strip() for line in curl_command.split('\n') if line.strip()]
    
    # Get the base URL from the first line
    url = lines[0].split("'")[1]
    
    # Initialize headers list
    headers = []
    data_raw = ""
    
    # Process each line
    for line in lines[1:]:
        line = line.strip()
        if line.startswith('-H'):
            # Extract header
            header = line.split("'")[1]
            headers.append(header)
        elif line.startswith('--data-raw'):
            # Extract data
            data_raw = line.split("'")[1]
            # Replace any phone number with €tor
            import re
            # Phone number patterns
            data_raw = re.sub(r'"phone":"[0-9]+"', '"phone":"€tor"', data_raw)
            data_raw = re.sub(r'"mobile":"[0-9]+"', '"mobile":"€tor"', data_raw)
            data_raw = re.sub(r'"mobileNumber":"[0-9]+"', '"mobileNumber":"€tor"', data_raw)
            data_raw = re.sub(r'mobile=[0-9]+', 'mobile=€tor', data_raw)
            data_raw = re.sub(r'"verifiedPhone":"[0-9]+"', '"verifiedPhone":"€tor"', data_raw)
            data_raw = re.sub(r'"user_id":"[0-9]+"', '"user_id":"€tor"', data_raw)
            data_raw = re.sub(r'"param":"[0-9]+"', '"param":"€tor"', data_raw)
            data_raw = re.sub(r'loginOTP=[0-9]+', 'loginOTP=€tor', data_raw)
            
            # Email patterns
            data_raw = re.sub(r'"email":"[^"]+@[^"]+\.[^"]+"', '"email":"xboaa@gmail.com"', data_raw)
            data_raw = re.sub(r'"login":"[^"]+@[^"]+\.[^"]+"', '"login":"xboaa@gmail.com"', data_raw)
            
            # Name patterns
            data_raw = re.sub(r'"firstName":"[^"]+"', '"firstName":"Huusa"', data_raw)
            data_raw = re.sub(r'"firstname":"[^"]+"', '"firstname":"aditya"', data_raw)
            data_raw = re.sub(r'"lastname":"[^"]+"', '"lastname":"singh"', data_raw)
            
            # Gender pattern
            data_raw = re.sub(r'"genderType":"[^"]+"', '"genderType":"Male"', data_raw)
    
    # Construct the single line curl command
    result = f"curl '{url}' --compressed"
    
    # Add headers
    for header in headers:
        result += f" -H '{header}'"
    
    # Add data if present
    if data_raw:
        result += f" --data-raw '{data_raw}'"
    
    # Add output redirection
    result += " > /dev/null 2>&1"
    
    return result

def process_file():
    # Read input.txt
    with open('input.txt', 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Split into individual curl commands
    curl_commands = content.split('\n\n')
    
    # Process each command
    with open('new_api.sh', 'w', encoding='utf-8') as f:
        for cmd in curl_commands:
            if cmd.strip().startswith('curl'):
                converted = convert_curl_command(cmd.strip())
                f.write(converted + '\n')
    
    print("All curl commands have been converted and saved to new_api.sh")

if __name__ == "__main__":
    process_file()
