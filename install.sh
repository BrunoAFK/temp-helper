#!/bin/bash
#?
#? Template helper
#? by <hello@pavelja.me>
#?
#? Template helper is tool that will help you create template folder and
#? delete content of that folder after 10 days (or custom number of days)
#?

#...............................
#! Basic setup
#...............................

#DEBUG=0 # If 0, debug will be disabled
temp_dir=$(mktemp -d)

#...............................
#! Main variables
#...............................

default_days=10
default_name="Temp"
script_location="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )" #Script location

#...............................
#! Helpers
#...............................

# Spaces, new rows etc....
#...................
custom_space='    '
cr=`echo $'\n.'`
cr=${cr%.}

# Colors
#...................
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)
NC=$(tput sgr0) # No Color

# Detect OS/System
#...................
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    
    # You are using linux
    system_name="linux"
    
    
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    # You are using macos
    system_name="macos"
    
else
    # You are using OS that is not suported
    echo
    echo -e "${custom_space}${RED}You are using OS that isn't suported! Error code 6 $NC "
    echo -e "${custom_space}This script will only work on linux or macos system"
    exit 6
fi

#...............................
#! Functions
#...............................

#-------------------
# Clean function
# This will remove temp folder that is created before. Used for TRAP
#-------------------
function clean () {
    rm -rf $temp_dir
}

#...............................
#! Main section
#...............................

# Clean on exit
#...................
trap clean EXIT

# Script intro
#...................
echo
echo
echo -e "${GREEN}${custom_space}Hello, this is the script that will help you keep temp files organized"
echo
echo -e "${custom_space}This script will create a 'temp' folder,"
echo -e "${custom_space}and then create a cron job to delete files older than selected days"
echo
echo -e "${custom_space}You can find more info in the git repository"
echo -e "${custom_space}https://gitlab.com/bruno-afk/temp-helper ${NC}"
echo
echo

# Info show
#...................
echo
echo -e "${custom_space}${CYAN}Basic system info:${NC}"
echo "${custom_space}OS Type: $system_name"
if [[ $system_name == "linux" ]]; then
    echo "${custom_space}Distribution name is: $(lsb_release -si) $(lsb_release -sr)"
fi
echo "${custom_space}Username is: $USER"
echo "${custom_space}Home folder location is: $HOME"
echo

# Main section
#...................

if [[ $1 == "-c" ]] || [[ $1 == "-C" ]]; then
    echo
    read -p "${custom_space}${CYAN}Where do you want that ${GREEN}$default_name${CYAN} folder to be created? [$HOME]:${NC} $cr${custom_space}" location
    location=${location:-$HOME}
    echo
    
    read -p "${custom_space}${CYAN}The default name of the folder now is ${GREEN}$default_name${CYAN}. Do you want to change that name? (y/N)? ${NC} $cr${custom_space}" answer
    case ${answer:0:1} in
        y|Y )
            read -p "${custom_space}${CYAN}Enter new name of the folder that will contain your temp files:${NC} $cr${custom_space}" folder_name
            folder_name=${folder_name:-$default_name}
        ;;
        * )
            folder_name=$default_name
        ;;
    esac
    
    read -p "${custom_space}${CYAN}After how many days do you want to delete created files and folders? [$default_days days]:${NC} $cr${custom_space}" duration
    duration=${duration:-$default_days}
    echo
else
    location=$HOME
    folder_name=$default_name
    duration=$default_days
fi

# Create folder
#...................
if [ -d "$location/$folder_name" ]; then
    echo "${custom_space}Folder exists"
else
    mkdir -p $location/$folder_name
fi

# Create cronjob
#...................
crontab -l > $temp_dir/tempcron
echo "@reboot find $location/$default_name -ctime +$duration -exec rm -rf {} +" >> $temp_dir/tempcron
crontab $temp_dir/tempcron

echo "${custom_space}Cronjob created."


# The End
#...................
echo "${custom_space}${GREEN}Done${NC}"
echo
echo "${custom_space}Location of the folder: $location"
echo "${custom_space}Name of the folder: $folder_name"
echo "${custom_space}Numbers of days when a script will delete all files: $duration days"

if [[ $1 == "-c" ]] || [[ $1 == "-C" ]]; then
    
    read -p "${custom_space}Do you want to see the crontab content (y/N)?" answer
    case ${answer:0:1} in
        y|Y )
            echo
            cat $temp_dir/tempcron
        ;;
        * )
            echo
        ;;
    esac
fi

#?...............................
#?  Help
#?...............................

#* Error codes
# 6 - OS is not suported