#!/bin/bash

print_centered() {
    local text="$1"
    local width=$(tput cols)
    local padding=$(( (width - ${#text}) / 2 ))
    printf "%${padding}s%s\n" "" "$text"
}

banner(){
    clear
    echo -e "\e[96m╔════════════════════════════════════════════════════════════════╗"
    echo -e "║                                                                ║"
    echo -e "║   \e[91m █████╗ ██╗  ██╗    \e[93m██████╗  ██████╗ ███╗   ███╗\e[96m      ║"
    echo -e "║   \e[91m██╔══██╗██║ ██╔╝    \e[93m██╔══██╗██╔═══██╗████╗ ████║\e[96m      ║"
    echo -e "║   \e[91m███████║█████╔╝     \e[93m██████╔╝██║   ██║██╔████╔██║\e[96m      ║"
    echo -e "║   \e[91m██╔══██║██╔═██╗     \e[93m██╔══██╗██║   ██║██║╚██╔╝██║\e[96m      ║"
    echo -e "║   \e[91m██║  ██║██║  ██╗    \e[93m██████╔╝╚██████╔╝██║ ╚═╝ ██║\e[96m      ║"
    echo -e "║   \e[91m╚═╝  ╚═╝╚═╝  ╚═╝    \e[93m╚═════╝  ╚═════╝ ╚═╝     ╚═╝\e[96m      ║"
    echo -e "║                                                                ║"
    echo -e "║   \e[92m██████╗  ██████╗ ███╗   ███╗██████╗ ███████╗██████╗ \e[96m   ║"
    echo -e "║   \e[92m██╔══██╗██╔═══██╗████╗ ████║██╔══██╗██╔════╝██╔══██╗\e[96m   ║"
    echo -e "║   \e[92m██████╔╝██║   ██║██╔████╔██║██████╔╝█████╗  ██████╔╝\e[96m   ║"
    echo -e "║   \e[92m██╔══██╗██║   ██║██║╚██╔╝██║██╔══██╗██╔══╝  ██╔══██╗\e[96m   ║"
    echo -e "║   \e[92m██████╔╝╚██████╔╝██║ ╚═╝ ██║██████╔╝███████╗██║  ██║\e[96m   ║"
    echo -e "║   \e[92m╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝\e[96m   ║"
    echo -e "║                                                                ║"
    echo -e "╠════════════════════════════════════════════════════════════════╣"
    echo -e "║             \e[95m✧ SMS & CALL BOMBER - CREATED BY AK ✧\e[96m            ║"
    echo -e "╚════════════════════════════════════════════════════════════════╝\e[0m"
    echo ""
}

generate_random_name() {
    local names=("John" "Alex" "Mike" "David" "James" "Robert" "William" "Richard" "Joseph" "Thomas")
    echo "${names[$RANDOM % ${#names[@]}]}"
}

generate_random_email() {
    local domains=("gmail.com" "yahoo.com" "hotmail.com" "outlook.com")
    local random_string=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)
    echo "${random_string}@${domains[$RANDOM % ${#domains[@]}]}"
}

firstname=$(generate_random_name)
lastname=$(generate_random_name)
email=$(generate_random_email)
gender=$((RANDOM % 2))
gender_type=("Male" "Female")
selected_gender=${gender_type[$gender]}

show_menu() {
    echo -e "\e[96m┌────────────────────────────────────────┐"
    echo -e "│           \e[93mSELECT SERVER\e[96m                │"
    echo -e "├────────────────────────────────────────┤"
    echo -e "│  \e[92m[\e[91m1\e[92m] \e[97mPRIMARY SERVER  \e[92m[\e[91mFAST\e[92m]\e[96m        │"
    echo -e "│  \e[92m[\e[91m2\e[92m] \e[97mBACKUP SERVER   \e[92m[\e[91mSTABLE\e[92m]\e[96m      │"
    echo -e "│  \e[92m[\e[91m3\e[92m] \e[97mNEW SERVER      \e[92m[\e[91mEXTRA\e[92m]\e[96m       │"
    echo -e "│  \e[92m[\e[91m4\e[92m] \e[97mAUTO MODE       \e[92m[\e[91mALL\e[92m]\e[96m         │"
    echo -e "└────────────────────────────────────────┘\e[0m"
    echo ""
    echo -ne "\e[92m[\e[91m*\e[92m] Select Option: \e[0m"
}

show_main_menu() {
    echo ""
    echo -e "\e[96m┌────────────────────────────────────────┐"
    echo -e "│              \e[93mMAIN MENU\e[96m                │"
    echo -e "├────────────────────────────────────────┤"
    echo -e "│  \e[92m[\e[91m1\e[92m] \e[97mRE-BOMB NUMBER\e[96m                │"
    echo -e "│  \e[92m[\e[91m2\e[92m] \e[97mBOMB NEW NUMBER\e[96m               │"
    echo -e "│  \e[92m[\e[91m3\e[92m] \e[97mEXIT BOMBER\e[96m                   │"
    echo -e "└────────────────────────────────────────┘\e[0m"
    echo ""
    echo -ne "\e[92m[\e[91m*\e[92m] Select Option: \e[0m"
}

kp(){
    show_menu
    read ch
    if [ $ch -eq 1 ];then
        sp
    elif [ $ch -eq 2 ]; then
        sp1
    elif [ $ch -eq 3 ]; then
        sp2
    elif [ $ch -eq 4 ]; then
        auto_bomb
    else
        echo -e "\e[91m[!] Invalid Option Selected!\e[0m"
        sleep 1
        clear
        banner
        kp
    fi
}

sp(){
clear
banner
echo -e "Start up Server"
sleep 2.0
echo -e "\e[95m bombing on number :-$num"
sleep 2.0
echo -e "\e[91m bombing start"
cp api1.sh app1.sh
sed -i 's/\r$//' app1.sh
sed -i "s/€tor/$num/g" app1.sh
bash app1.sh
rm app1.sh
}

sp1(){
clear
banner
echo -e "Start up Server"
sleep 2.0
echo -e "\e[95m bombing on number :-$num"
sleep 2.0
echo -e "\e[91m bombing start"
cp api.sh app.sh
sed -i 's/\r$//' app.sh
sed -i "s/€tor/$num/g" app.sh
bash app.sh
rm app.sh
}

sp2(){
clear
banner
echo -e "Start up Server"
sleep 2.0
echo -e "\e[95m bombing on number :-$num"
sleep 2.0
echo -e "\e[91m bombing start"
cp new_api.sh app2.sh
sed -i 's/\r$//' app2.sh
sed -i "s/€tor/$num/g" app2.sh
sed -i "s/xboaa@gmail.com/$email/g" app2.sh
sed -i "s/Huusa/$firstname/g" app2.sh
sed -i "s/\"Male\"/$selected_gender/g" app2.sh
sed -i "s/022adityakara@gmail.com/$email/g" app2.sh
sed -i "s/aditya/$firstname/g" app2.sh
sed -i "s/singh/$lastname/g" app2.sh
bash app2.sh
rm app2.sh
}

auto_bomb() {
    clear
    banner
    echo -e "Starting Auto Bombing Mode..."
    echo -e "\e[95m bombing on number: $num"
    echo -e "\e[91m Auto bombing sequence initiated"
    
    while true; do
        echo -e "\n\e[93m[*] Running Primary Server...\e[0m"
        sp
        sleep 2
        
        echo -e "\n\e[93m[*] Running Backup Server...\e[0m"
        sp1
        sleep 2
        
        echo -e "\n\e[93m[*] Running New Server...\e[0m"
        sp2
        sleep 2
        
        echo -e "\n\e[92m[✓] Completed one cycle. Starting next cycle...\e[0m"
        sleep 3
    done
}

con(){
    show_main_menu
    read opt
    if [ $opt -eq 1 ];then  
        bomb
        con
    elif [ $opt -eq 2 ]; then
        clear
        banner
        echo -ne "\e[92m[\e[91m*\e[92m] Enter New Number: \e[0m"
        read num
        bomb
        con
    elif [ $opt -eq 3 ]; then
        clear
        banner
        echo -e "\e[92m[\e[91m✓\e[92m] Thanks for using SMS Bomber!\e[0m"
        echo -e "\e[92m[\e[91m✓\e[92m] Created by AK\e[0m"
        exit 0
    else 
        echo -e "\e[91m[!] Invalid Option Selected!\e[0m"
        sleep 1
        clear
        banner
        con
    fi
}

bomb(){
clear 
banner 
sleep 2.0
if [ "$method" == "true" ];then
    kp
    method="false"
    echo ""
else
    sp1
    echo
fi
con
}

method="true"
banner
echo -e "\e[92m[\e[91m*\e[92m] SMS Bomber Initialized...\e[0m"
sleep 1
echo -ne "\e[92m[\e[91m*\e[92m] Enter Target Number: \e[0m"
read num
bomb
