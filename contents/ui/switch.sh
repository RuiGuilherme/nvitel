#!/bin/bash

Intel="Intel GPU"
Nvidia="NVIDIA GPU"
Hybrid="Hybrid GPU"

Title="Prime video card selector"
Question="Please choose a video card:"
FirstColumn="Options"
SecondColumn="Video cards"
QuestionTitle="Do you want to log out now?"
QuestionText="You will be log out save all your files or choose 'No' to cancel."
IconUrl="$HOME"

Option="$(zenity --window-icon="$IconUrl"/.local/share/plasma/plasmoids/org.kde.plasma.nvitel/contents/ui/main.svg --width=600 --height=280 --title="$Title" --text="$Question" --list --radiolist --column "$FirstColumn" --column="$SecondColumn" TRUE "$Intel" FALSE "$Nvidia" FALSE "$Hybrid")"

if [ "$Option" = "$Nvidia" ]; then
    notify-send -i "$IconUrl"/.local/share/plasma/plasmoids/org.kde.plasma.nvitel/contents/ui/nvidia.svg "$Nvidia" "You have selected the $Nvidia as the main video card of the system. Save all files before continuing."
    if zenity --question --window-icon="$IconUrl"/.local/share/plasma/plasmoids/org.kde.plasma.nvitel/contents/ui/nvidia.svg --title="$QuestionTitle" --text="$QuestionText" --width=500
    then 
        optimus-manager --switch nvidia --no-confirm
    fi
    exit
elif [ "$Option" = "$Intel" ]; then
    notify-send -i "$IconUrl"/.local/share/plasma/plasmoids/org.kde.plasma.nvitel/contents/ui/main.svg "$Intel" "You have selected the $Intel as the main video card of the system. Save all files before continuing"
    if zenity --question --window-icon="$IconUrl"/.local/share/plasma/plasmoids/org.kde.plasma.nvitel/contents/ui/main.svg --title="$QuestionTitle" --text="$QuestionText" --width=500
    then 
        optimus-manager --switch intel --no-confirm
    fi
    exit
elif [ "$Option" = "$Hybrid" ]; then
    notify-send -i "$IconUrl"/.local/share/plasma/plasmoids/org.kde.plasma.nvitel/contents/ui/main.svg "$Hybrid" "You have selected the $Hybrid as the main video card of the system. Save all files before continuing."
    if zenity --question --window-icon="$IconUrl"/.local/share/plasma/plasmoids/org.kde.plasma.nvitel/contents/ui/main.svg --title="$QuestionTitle" --text="$QuestionText" --width=500
    then 
        optimus-manager --switch hybrid --no-confirm
    fi
    exit    
else
    exit
fi
