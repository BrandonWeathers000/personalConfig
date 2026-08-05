#!/bin/bash

brightnessValue(){
    hex=$1

    r=$((16#${hex:0:2}))
    g=$((16#${hex:2:2}))
    b=$((16#${hex:4:2}))

    awk -v r="$r" -v g="$g" -v b="$b" 'BEGIN { print 0.2126*r + 0.7152*g + 0.0722*b }'
}

# findingColors(){
#     # Getting colors
#     colorOne=$(magick $1 -colors 2 -unique-colors txt:- | awk 'NR > 1 { print $3 }' | head -n 1 | sed 's/#//g')
#     colorTwo=$(magick $1 -colors 2 -unique-colors txt:- | awk 'NR > 1 { print $3 }' | tail -n 1 | sed 's/#//g')

#     colorOneBright=$(brightnessValue $colorOne)
#     colorTwoBright=$(brightnessValue $colorTwo)

#     if awk "BEGIN { exit !($colorTwoBright > $colorOneBright) }"; then
#         temp=$colorOne
#         colorOne=$colorTwo
#         colorTwo=$temp

#         echo "Testing"
#     fi

#     # echo "Color ONE is: $colorOne and is $colorOneBright bright"
#     # echo "Color TWO is: $colorTwo and is $colorTwoBright bright"

#     # if awk "BEGIN { exit !($colorOneBright < 10.0) }"; then
#     #     echo "Manual overide to white color one!"

#     #     riverctl border-color-focused "0x$colorTwo"
#     #     riverctl border-color-unfocused 0xFFFFFF

#     # elif awk "BEGIN { exit !($colorTwoBright < 10.0) }"; then
#     #     echo "Manual overide to white color two!"

#     #     riverctl border-color-focused "0x$colorOne"
#     #     riverctl border-color-unfocused 0xFFFFFF
#     # else
# }

wallpaperChange(){
    killall swaybg 
    swaybg -m fill -i $1
}

###################
### ENTRY POINT ###
###################

# Getting wallpaper
cd ~/Images/walls/
wallpaper=$(ls | fuzzel --dmenu)

# Finding colors
mapfile -t colors < <(magick $wallpaper -colors 2 -unique-colors txt:- | awk 'NR > 1 { print $3 }' | sed 's/#//g')
colorOne=${colors[0]}
colorTwo=${colors[1]}

echo "Color ONE is: $colorOne"
echo "Color TWO is: $colorTwo"

colorOneBright=$(brightnessValue $colorOne)
colorTwoBright=$(brightnessValue $colorTwo)

if awk "BEGIN { exit !($colorTwoBright > $colorOneBright) }"; then
    temp=$colorOne
    colorOne=$colorTwo
    colorTwo=$temp

    echo "Testing"
fi

# Setting window borders
riverctl border-color-focused "0x$colorOne"
riverctl border-color-unfocused "0x$colorTwo"

# Changing wallpaper
wallpaperChange $wallpaper
