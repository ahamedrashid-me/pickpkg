#!/bin/bash

# Temporary file for storing user input/output
TEMPFILE=$(mktemp)

# Function to get terminal window size dynamically
get_screen_size() {
    HEIGHT=$(stty size | awk '{print $1}') # Get terminal height
    WIDTH=$(stty size | awk '{print $2}')  # Get terminal width
}

# Main menu function
main_menu() {
    get_screen_size
    dialog --clear --title "PickPkg - App Store v-1.1 by fb:@ahamedrashid.fb" \
    --menu "Pick an option:" $((HEIGHT - 10)) $((WIDTH - 10)) 6 \
    1 "Search for a package" \
    2 "Install a package" \
    3 "Remove a package" \
    4 "List installed packages" \
    5 "Refresh package list" \
    6 "Edit repositories" 2> "$TEMPFILE"
    
    menu_choice=$(cat "$TEMPFILE")

    case $menu_choice in
        1) search_package ;;
        2) install_package ;;
        3) remove_package ;;
        4) list_installed_packages ;;
        5) refresh_package_list ;;
        6) edit_repositories ;;
        *) exit 0 ;;
    esac
}

# Function to show package details and list (package name and description)
show_packages() {
    package_name=$1
    package_desc=$2
    get_screen_size
    
    dialog --begin 4 4 --msgbox "Package Name: $package_name\n\nDetails: $package_desc" $((HEIGHT - 10)) $((WIDTH - 10))
}

# Search package function
search_package() {
    dialog --inputbox "Enter package name to search:" 8 40 2> "$TEMPFILE"
    package_name=$(cat "$TEMPFILE")
    
    if [ -n "$package_name" ]; then
        apt-cache search "$package_name" > "$TEMPFILE"
        get_screen_size
        dialog --begin 5 5 --title "Search Results" --menu "Package - Description" $((HEIGHT - 10)) $((WIDTH - 10)) 16 $(awk '{print $1 " \"" $2 "\""}' "$TEMPFILE") 2> "$TEMPFILE"
        selected_package=$(cat "$TEMPFILE")
        
        # Get package details from apt-cache show
        package_info=$(apt-cache show "$selected_package")
        
        # Show selected package details
        show_packages "$selected_package" "$package_info"
    fi
    main_menu
}

# Install package function
install_package() {
    dialog --inputbox "Enter package name to install:" 8 40 2> "$TEMPFILE"
    package_name=$(cat "$TEMPFILE")
    
    if [ -n "$package_name" ]; then
        dialog --msgbox "Installing $package_name..." 6 40
        sudo apt-get install -y "$package_name" > "$TEMPFILE" 2>&1
        get_screen_size
        dialog --textbox "$TEMPFILE" $((HEIGHT - 10)) $((WIDTH - 10))
    fi
    main_menu
}

# Remove package function
remove_package() {
    dialog --inputbox "Enter package name to remove:" 8 40 2> "$TEMPFILE"
    package_name=$(cat "$TEMPFILE")
    
    if [ -n "$package_name" ]; then
        dialog --msgbox "Removing $package_name..." 6 40
        sudo apt-get remove -y "$package_name" > "$TEMPFILE" 2>&1
        sudo apt-get autoremove -y >> "$TEMPFILE" 2>&1
        get_screen_size
        dialog --textbox "$TEMPFILE" $((HEIGHT - 10)) $((WIDTH - 10))
    fi
    main_menu
}

# List installed packages function
list_installed_packages() {
    dpkg --list > "$TEMPFILE"
    get_screen_size
    dialog --textbox "$TEMPFILE" $((HEIGHT - 10)) $((WIDTH - 10))
    main_menu
}

# Refresh package list function
refresh_package_list() {
    dialog --msgbox "Refreshing package list..." 6 40
    sudo apt-get update > "$TEMPFILE" 2>&1
    get_screen_size
    dialog --textbox "$TEMPFILE" $((HEIGHT - 10)) $((WIDTH - 10))
    main_menu
}

# Edit repositories function
edit_repositories() {
    sudo nano /etc/apt/sources.list
    main_menu
}

# Run the main menu
main_menu

# Clean up temporary file
rm -f "$TEMPFILE"
