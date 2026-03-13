#!/bin/bash

# Configuration
KEY_PATH="C:\\Users\\Pratik\\Desktop\\your-key.pem"

# Convert Windows path to Unix-style (for Git Bash/WSL compatibility)
KEY_PATH=$(echo "$KEY_PATH" | sed 's/\\/\//g' | sed 's/^\([A-Za-z]\):/\/\L\1/')

# Function: Arrow-key selection menu
select_user() {
    local options=("ubuntu" "ec2-user")
    local selected=0
    local key
    
    # Hide cursor for cleaner UI
    tput civis 2>/dev/null || echo -en "\033[?25l"
    
    echo "Choose the username:"
    echo "(Use ↑/↓ arrows to navigate, Space to select)"
    echo ""
    
    while true; do
        # Render menu
        for i in "${!options[@]}"; do
            if [ $i -eq $selected ]; then
                printf "\033[32m  ► %s\033[0m\n" "${options[$i]}"   # Green cursor
            else
                printf "    %s\n" "${options[$i]}"
            fi
        done
        
        # Read key (supporting escape sequences)
        IFS= read -rs -n1 key
        [[ "$key" == $'\x1b' ]] && read -rs -n2 key
        
        case "$key" in
            '[A') # Up arrow
                ((selected--))
                [ $selected -lt 0 ] && selected=$((${#options[@]} - 1))
                ;;
            '[B') # Down arrow
                ((selected++))
                [ $selected -ge ${#options[@]} ] && selected=0
                ;;
            ' '|$'\n') # Space or Enter
                break
                ;;
        esac
        
        # Move cursor up to redraw (2 lines)
        printf "\033[%dA" "${#options[@]}"
    done
    
    # Cleanup display
    tput cnorm 2>/dev/null || echo -en "\033[?25h"  # Show cursor
    printf "\033[%dA\033[J" "$((${#options[@]} + 2))"  # Clear menu
    
    USER="${options[$selected]}"
    echo "Selected user: $USER"
}

# Execute
select_user

echo ""
read -p "Enter the IP address: " SERVER_IP

echo ""
echo "Connecting to $USER@$SERVER_IP..."
ssh -i "$KEY_PATH" "$USER@$SERVER_IP"