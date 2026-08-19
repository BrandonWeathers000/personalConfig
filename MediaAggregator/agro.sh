#!/bin/bash

checkDependency(){
    util="$1"

    if command -v $util >/dev/null ; then
        echo -e "[\e[32;50m  OK  \e[m] $util found"
    else
        echo -e "[[\e[31;50mFAILED\e[m] $util NOT found"
    fi
}

downloadSong(){
    url="$1" 
    cd ~/Videos/
    yt-dlp "$url" && echo -e "[\e[32;50m GOT  \e[m]: $(ls -1t --time=birth | head -n1)"
    # cd ~/Desktop/GeneralProgramming/MediaAggregator
    cd ~/.config//MediaAggregator
}

parseInputFile(){
    index=1
    while IFS= read -r currentEntry; do
        echo -e "[\e[32;50m DNLD \e[m]: $currentEntry"
        downloadSong $currentEntry
        ((index++))
    done < sources.txt
}

checkDependency head
checkDependency tail
checkDependency yt-dlp
checkDependency ffmpeg

parseInputFile
