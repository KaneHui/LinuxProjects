#!/usr/bin/env bash

# echon - a script to emulate the -n flag functionality with 'echo'
# for Unix systems that don't have that available

echon(){
    echo "$*" | tr -d '\n'
}
# echo -n do not output trailing newline
#
#echo -n "this is a test:"
#read answer
#
#echo -n this is a test too " "
#read answer2
echon "this is a test:"
read answer

echon this is a test too " "
read answer2