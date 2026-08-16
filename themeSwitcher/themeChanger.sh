#!/bin/bash

brightnessValue(){
    hex=$1

    r=$((16#${hex:0:2}))
    g=$((16#${hex:2:2}))
    b=$((16#${hex:4:2}))

    awk -v r="$r" -v g="$g" -v b="$b" 'BEGIN { print 0.2126*r + 0.7152*g + 0.0722*b }'
}

wallpaperChange(){
    killall swaybg 
    swaybg -m fill -i $1
}

waybarColorChanger(){
    killall waybar

    newColor=$1
    cssFile=~/.config/waybar/style.css

    oldColor=$(sed -n '11p' $cssFile | awk '{print $2}' | sed 's/#\|;//g')
    echo "The old color is: $oldColor"

    sed -i "s/$oldColor/$newColor/g" $cssFile

    waybar & 
}

fuzzelColorChanger(){
    newColor=$1
    cssFile=~/.config/fuzzel/fuzzel.ini

    oldColor=$(sed -n '57p' $cssFile | awk '{print $2}')
    echo "The old color is: $oldColor"

    newColor+="FF"
    sed -i "s/$oldColor/$newColor/g" $cssFile
}

cavaColorChanger (){
    newColor=$1
    cssFile=~/.config/cava/themes/tron

    oldColor=$(sed -n '3p' $cssFile | awk '{print $2}')
    oldColor=${oldColor:2:6}
    echo "The CAVA old color is: $oldColor"

    sed -i "s/$oldColor/$newColor/g" $cssFile
}

changeDefaultWallpaper() {
    sed -i '/swaybg/d' ~/.config/river/init
    echo "swaybg -m fill -i ~/Images/walls/$wallpaper &" >> ~/.config/river/init
}

###################
### ENTRY POINT ###
###################

# Getting wallpaper
cd ~/Images/walls/
wallpaper=$(ls | fuzzel -p "Wallpaper: " --dmenu)

# Finding colors
mapfile -t colors < <(magick $wallpaper -colors 2 -unique-colors txt:- | awk 'NR > 1 { print $3 }' | sed 's/#//g')
colorOne=${colors[0]}
colorTwo=${colors[1]}
colorOneBright=$(brightnessValue $colorOne)
colorTwoBright=$(brightnessValue $colorTwo)

echo "Color ONE is: $colorOne and is $colorOneBright bright"
echo "Color TWO is: $colorTwo and is $colorTwoBright bright"

if awk "BEGIN { exit !($colorTwoBright > $colorOneBright) }"; then
    temp=$colorOne
    colorOne=$colorTwo
    colorTwo=$temp

    echo "Testing"
fi

echo "Color ONE is: $colorOne and is $colorOneBright bright"
echo "Color TWO is: $colorTwo and is $colorTwoBright bright"

# if awk "BEGIN { exit !($colorOneBright < 10.0) }"; then
#     echo "Manual overide to white color one!"

#     riverctl border-color-focused "0x$colorTwo"
#     riverctl border-color-unfocused 0xFFFFFF

# elif awk "BEGIN { exit !($colorTwoBright < 10.0) }"; then
#     echo "Manual overide to white color two!"

#     riverctl border-color-focused "0x$colorOne"
#     riverctl border-color-unfocused 0xFFFFFF
# else

# Setting window borders
riverctl border-color-focused "0x$colorOne"
riverctl border-color-unfocused "0x$colorTwo"

sed -i '/border-color-focused/d' ~/.config/river/init
echo "riverctl border-color-focused 0x$colorOne" >> ~/.config/river/init

sed -i '/border-color-unfocused/d' ~/.config/river/init
echo "riverctl border-color-unfocused 0x$colorTwo" >> ~/.config/river/init

# Other functions
waybarColorChanger $colorOne
fuzzelColorChanger $colorOne
cavaColorChanger $colorOne
changeDefaultWallpaper $wallpaper

wallpaperChange $wallpaper # Should be last function as it's a deamon 
