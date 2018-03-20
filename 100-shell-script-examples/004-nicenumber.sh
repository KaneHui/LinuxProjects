#!/usr/bin/env bash
# nicenumber - given a number, show it with comma seperated values
# expects Decimal point Delimeter and Thousands Delimiter to be instantiated
# instantiates nicenum or, if a second arg is specified, the output is echoed to stdout

nicenumber(){
    # Note that we use the '.' as the decimal seperator for parsing
    # the INPUT value to this script. The output value is as specified
    # by the user with the -d flag, if different from a '.'
    integer=$(echo $1 | cut -d. -f1)  #left of the decimal
    decimal=$(echo $1 | cut -d. -f2) #right of the decimal

    if [ $decimal != $1 ] ; then
        # there is a fractional part, let's include it.
        result="${DD:="."}$decimal"
    fi

    thousands=$integer

    while [ $thousands -gt 999 ]; do
        remainder=$(($thousands % 1000)) # three least significant digits
        while [ ${#remainder} -lt 3 ] ; do
            remainder="0$remainder" #force leading zeroes as needed
        done
        thousands=$(($thousands / 1000)) # to left of remainder,if any
        result="${TD:=","}${remainder}${result}"

    done

    nicenum="${thousands}${result}"
    if [ ! -z $2 ] ; then
        echo $nicenum
    fi
}

DD="."
TD=","
while getopts "d:t:" opt; do
    case $opt in
    d) DD="$OPTARG" ;;
    t) TD="$OPTARG" ;;
    esac
done

echo "OPTIND:$OPTIND"

shift $(($OPTIND - 1))

if [ $# -eq 0 ] ; then
    cat << "EOF" > $2
Usage: $(basename $0) [-d c] [-t c] numerica value
        -d specifies the decimal point delimiter (default '.')
        -t specifies the thousands delimiter (default ',')
EOF
    exit 1
fi
nicenumber $1 1  # second arg forces this to 'echo' output

exit 0