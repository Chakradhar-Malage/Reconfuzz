#!/bin/bash

# Define colors for styling
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print the banner once at startup
echo -e "${RED}"
echo "###################################################################################################################################### "
echo " _____   ______  _____  ____   _   _            ______  _    _  ______ ______                                                          "
echo " |  __ \ |  ____|/ ____|/ __ \ | \ | |   ___    |  ____|| |  | ||___  /|___  /                                                         "
echo " | |__) || |__  | |    | |  | ||  \| |  ( _ )   | |__   | |  | |   / /    / /                                                          "
echo " |  _  / |  __| | |    | |  | || .   |  / _ \/\ |  __|  | |  | |  / /    / /                                                           "     
echo " | | \ \ | |____| |____| |__| || |\  | | (_>  < | |     | |__| | / /__  / /__                                                          "                                   
echo " |_|  \_\|______|\_____|\____/ |_| \_|  \___/\/ |_|      \____/ /_____|/_____|                                                         "
echo "                                                                                                                                       "                            
echo "                                                                             - By Chakradhar Malage                                                          "                    
echo "###################################################################################################################################### "

echo -e "${NC}"

# Function to check if a tool is installed
check_installed() {
    tool="$1"
    if command -v "$tool" &> /dev/null; then
        echo -e "${GREEN}Installed${NC}"
        return 0
    else
        echo -e "${RED}Not installed${NC}"
        return 1
    fi
}

# Function to install a tool
install_tool() {
    tool="$1"
    echo -e "${CYAN}Attempting to install $tool...${NC}"
    # Check for the package manager and install accordingly (for Ubuntu/Debian-based systems)
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y "$tool"
    elif command -v brew &> /dev/null; then
        brew install "$tool"
    else
        echo -e "${RED}No known package manager found. Installation failed for $tool.${NC}"
    fi
}

# Main menu loop
while true; do
    echo ""
    echo -e "${CYAN}Main Menu - Select an option:${NC}"
    echo -e "${YELLOW}1) Subdomain enumerations${NC}"
    echo -e "${YELLOW}2) FUZZ URLs${NC}"
    echo -e "${YELLOW}3) Reconnaissance${NC}"
    echo -e "${YELLOW}4) Exit${NC}"
    echo ""
    
    read -p "Enter your choice [1-4]: " choice_main
    
    case $choice_main in
        1)
            # Display information about the recommended tools
            echo ""
            echo "For better results we would recommend using the results from all the tools listed below."
            echo "Otherwise, you can skip any tool if you want."
            echo "1. sublist3r"
            echo "2. amass"
            echo "3. recon-ng"
            echo "4. subdomainizer"
            echo ""
            echo -e "${CYAN}Subdomain Enumeration Tools Status:${NC}"
            echo "---------------------------------------------"
            
            tools=("sublist3r" "amass" "recon-ng" "subdomainizer")
            missing_tools=()

            # Check the installation status of each tool
            for tool in "${tools[@]}"; do
                check_installed "$tool"
                if [[ $? -ne 0 ]]; then
                    missing_tools+=("$tool")
                fi
            done

            # Suggest installation for missing tools
            if [ ${#missing_tools[@]} -gt 0 ]; then
                echo ""
                echo -e "${YELLOW}The following tools are not installed:${NC}"
                for missing_tool in "${missing_tools[@]}"; do
                    echo -e "${YELLOW}$missing_tool${NC}"
                done

                read -p "Do you want to install them? (yes/no): " install_choice
                if [[ "$install_choice" == "yes" ]]; then
                    for missing_tool in "${missing_tools[@]}"; do
                        install_tool "$missing_tool"
                    done
                else
                    echo -e "${RED}Skipping installation of missing tools.${NC}"
                fi
            fi

            # Prompt for the target domain after checking the tools
            echo ""
            read -p "Enter the target domain for subdomain enumeration: " target
            echo -e "${CYAN}Starting subdomain enumeration for $target...${NC}"
            
            # Call the external subdomain enumeration script and pass the target as an argument
            if [ -f "./subdomainEnumeration.sh" ]; then
                chmod +x ./subdomainEnumeration.sh
                ./subdomainEnumeration.sh "$target"
            else
                echo -e "${RED}subdomainEnumeration.sh not found in the current directory.${NC}"
            fi

            read -p "Press Enter to return to Main Menu..." temp
            ;;

        2)
            # FUZZ URLs placeholder submenu
            while true; do
                echo ""
                echo -e "${CYAN}FUZZ URLs functionality coming soon...${NC}"
                echo -e "${YELLOW}1) Back to Main Menu${NC}"
                read -p "Enter your choice: " sub_choice2
                if [[ $sub_choice2 == 1 ]]; then
                    break
                else
                    echo -e "${RED}Invalid choice. Try again.${NC}"
                fi
            done
            ;;

        3)
            # Reconnaissance placeholder submenu
            while true; do
                echo ""
                echo -e "${CYAN}Reconnaissance functionality coming soon...${NC}"
                echo -e "${YELLOW}1) Back to Main Menu${NC}"
                read -p "Enter your choice: " sub_choice3
                if [[ $sub_choice3 == 1 ]]; then
                    break
                else
                    echo -e "${RED}Invalid choice. Try again.${NC}"
                fi
            done
            ;;

        4)
            echo -e "${RED}Exiting...${NC}"
            exit 0
            ;;

        *)
            echo -e "${RED}Invalid choice in Main Menu! Please choose a valid option.${NC}"
            ;;
    esac
done
