#!/bin/bash

## hyphop ##

#    if [ "$TERM" = "linux" ]; then
        echo -en "\e]P0000000" #black    	0 -> this is the background color as well. 
        echo -en "\e]P8666666" #darkgray 	8
        echo -en "\e]P1E86402" #darkred  	1
        echo -en "\e]P9a35757" #red      	9 
        echo -en "\e]P2A2EBA2" #darkgreen 	2
        echo -en "\e]PAc5f779" #green     	10
        echo -en "\e]P3968a38" #brown     	3
        echo -en "\e]PBfff796" #yellow    	11
        echo -en "\e]P4414171" #darkblue  	4
        echo -en "\e]PC4186be" #blue      	12
        echo -en "\e]P5963c59" #darkmagenta 	5
        echo -en "\e]PDcf9ebe" #magenta 	13
        echo -en "\e]P6418179" #darkcyan 	6
        echo -en "\e]PE71bebe" #cyan		14
        echo -en "\e]P7bebebe" #lightgray	7
        echo -en "\e]PFFFFCCC" #white   	15 -> this is the foreground color as well.
#        clear #for background artifacting
#    fi
