#!/usr/bin/env bash

# define - given a word , return its definition from dictionary.com

url="https://cogsci.princeton.edu/cgi-bin/webwn2.0?stage=1&word="

if [ $# -eq 0 ] ; then
    echo "Usage: $0 word" >&2
    exit 1
fi

lynx -source "$url$1" | \
    grep -E '(^[[:digit:]]+\. | has [[:digit:]]+$)' | \
    sed 's/<[^>]*>//g' |
( while read line
  do
    if [ "${line:0:3}" = "The" ] ; then
        part="$(echo $line | awk '{print $2}')"
        echo ""
        echo "The $part $1:"
    else
        echo "$line" | fmt | sed 's/^/ /g'
    fi
  done
)

exit 0