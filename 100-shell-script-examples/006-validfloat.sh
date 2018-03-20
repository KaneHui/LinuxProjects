#!/usr/bin/env bash

# validfloat - test whether a number is a valid floating point value.
#  Note that this cannot accept scientific (1.304e5) notation

# To test whether an entered value is a valid floating point number, we
# need to split the value at the decimal point, then test the first part
# to see if it's a valid integer, then the second part to see if it's a
# valid >=0 integer, so -39.3 is valid, but -39.-3 isn't


. /home/kane/share/kuanghui/LinuxProjects/100-shell-script-examples/005-validint.sh # source the validint function

validfloat(){
    fvalue="$1"
    if [ ! -z $(echo $fvalue | sed 's/[^.]//g') ] ; then
        # with decimal point
        decimalpart="$(echo $fvalue | cut -d. -f1)"
        fractionalpart="$(echo $fvalue | cut -d. -f2)"
        if [ ! -z decimalpart ] ; then
            echo "decimalpart: $decimalpart"
            if ! validint "$decimalpart" "" "" ; then
                return 1
            fi
        fi

        if [ "${fractionalpart:0:1}" = "-" ] ; then
            echo "Invalid floating point number: '-' not allowed after decimal point "
            return 1
        fi

        if [ "$fractionalpart" != "" ] ; then
            echo "fractionalpart: $fractionalpart"
            if ! validint "$fractionalpart" "0" "" ; then
                return 1
            fi
        fi


        # -.23 is not allowed
        if [ "$decimalpart" = "-" ] ; then

            echo "Invalid floating point format." >&2 ; return 1

        fi

    else
        if [ "$fvalue" = "-" ] ; then
            echo "Invalid floating point format." >&2
            return 1
        fi
        if ! validint "$fvalue" "" "" ; then
            return 1
        fi
    fi
    return 0
}

if validfloat $1 ; then
    echo "$1 is a valid floating point value"
fi

exit 0