#!/usr/bin/env bash
# inpath - verify that a specified program is either valid as-is,
# or can be found in the PATH directory list.
in_path(){
    cmd=$1
    path=$2
    retval=1
    oldIFS=$IFS
    IFS=":"

    for directory in $path
    do
        if [ -x $directory/$cmd ] ; then
            retval=0
        fi
    done
    IFS=$oldIFS
    return $retval
}

checkForCmdInPath(){
    var=$1
    if [ "$var" != "" ] ; then
        # or use ${var%${var#?}}  cut -c1 the variable slicing
        if [ "${var:0:1}" = "/" ] ; then
            echo ${var#?}
            echo ${var%${var#?}}

            if [ ! -x $var ] ; then
                return 1
            fi
        elif ! in_path $var $PATH ; then
            return 2
        fi
    fi
}


if [ $# -ne 1 ] ; then
    echo "Usage: $0 command" >$2 ; exit 1
fi

checkForCmdInPath "$1"

case $? in
    0)echo "$1 found in PATH"   ;;
    1)echo "$1 not found or not executable"  ;;
    2)echo "$1 not found in PATH"   ;;
esac

exit 0