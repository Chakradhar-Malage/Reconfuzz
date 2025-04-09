echo "Yes this file is called"

#!/bin/bash
# subdomainEnumeration.sh

# Check if target is provided as an argument
target="$1"
if [ -z "$target" ]; then
    echo "No target specified. Usage: ./subdomainEnumeration.sh <target_domain>"
    exit 1
fi

echo "============================================="
echo "Subdomain Enumeration for target: $target"
echo "============================================="
echo ""
echo "Select your approach:"
echo "1) Use a particular tool"
echo "2) Use all recommended tools"
echo ""
read -p "Enter your choice [1-2]: " method_choice

case $method_choice in
    1)
        # Particular tool selection submenu
        while true; do
            echo ""
            echo "Select a tool:"
            echo "1) sublist3r"
            echo "2) amass"
            echo "3) recon-ng"
            echo "4) subdomainizer"
            echo "5) Back to previous menu"
            echo ""
            read -p "Enter your choice [1-5]: " tool_choice
            case $tool_choice in
                1)
                    echo ""
                    echo "Running sublist3r on $target"
                    outfile="${target}_sublist3r.txt"
                    sublist3r -d "$target" > "$outfile"
                    echo "Output saved to $outfile"
                    ;;
                2)
                    echo ""
                    echo "Running amass on $target"
                    outfile="${target}_amass.txt"
                    amass enum -d "$target" > "$outfile"
                    echo "Output saved to $outfile"
                    ;;
                3)
                    echo ""
                    echo "Running recon-ng on $target"
                    outfile="${target}_recon-ng.txt"
                    recon-ng -d "$target" > "$outfile"
                    echo "Output saved to $outfile"
                    ;;
                4)
                    echo ""
                    echo "Running subdomainizer on $target"
                    outfile="${target}_subdomainizer.txt"
                    subdomainizer -d "$target" > "$outfile"
                    echo "Output saved to $outfile"
                    ;;
                5)
                    echo ""
                    echo "Returning to the previous menu..."
                    exit 0
                    ;;
                *)
                    echo "Invalid choice, please try again."
                    ;;
            esac

            echo ""
            read -p "Do you want to run another tool? (y/n): " run_again
            if [[ "$run_again" != "y" && "$run_again" != "Y" ]]; then
                break
            fi
        done
        ;;
    2)
        # Use all recommended tools sequentially, saving outputs to a single file
        outfile="${target}_allToolsOutput.txt"
        echo "Running all recommended tools on $target..."
        # Start with a fresh file
        echo "" > "$outfile"
        
        echo "=== sublist3r Output ===" >> "$outfile"
        echo "Running sublist3r on $target" >> "$outfile"
        sublist3r -d "$target" >> "$outfile"
        echo "" >> "$outfile"
        
        echo "=== amass Output ===" >> "$outfile"
        echo "Running amass on $target" >> "$outfile"
        amass enum -d "$target" >> "$outfile"
        echo "" >> "$outfile"
        
        echo "=== recon-ng Output ===" >> "$outfile"
        echo "Running recon-ng on $target" >> "$outfile"
        recon-ng -d "$target" >> "$outfile"
        echo "" >> "$outfile"
        
        echo "=== subdomainizer Output ===" >> "$outfile"
        echo "Running subdomainizer on $target" >> "$outfile"
        subdomainizer -d "$target" >> "$outfile"
        echo ""
        echo "Combined output saved to $outfile"
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac

echo ""
echo "Subdomain enumeration complete."
