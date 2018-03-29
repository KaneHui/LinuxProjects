#!/usr/bin/env bash

# DIR - pretend we're the DIR command in DOS and dsiplay the contents
# of the specified file, accepting some of the standard DIR flags

usage(){
cat << EOF >&2
    Usage: $0 [DOS flags] directory or directories
    Where:
        /D      sort by columns
        /H      show help for this shell script
        /N      show long listing format with filenames on right
        /OD     sort by oldest to newest
        /O-D    sort by newest to oldest
        /P      pause after each screenful of information
        /Q      show owner of the file
        /S      recursive listing
        /W      use wide listing format

EOF
    exit 0
}



postcmd=""
flags=""

while [ $# -gt 0 ]
do
    case $1 in
    /D      ) flags="flags -x"        ;;
    /H      ) usage                   ;;
    /[NQW]  ) flags="$flags -l"       ;;
    /OD     ) flags="$flags -rt"      ;;
    /O-D    ) flags="$flags -t"       ;;
    /P      ) postcmd="more"          ;;
    /S      ) flags="$flags -s"       ;;
    *       ) break                   ;
    esac
    shift   # processed flag, let's see if there's another
done

if [ ! -z "$postcmd" ] ; then
    echo "postcmd: $postcmd"
    ls $flags "$@" | $postcmd
else
    echo "postcmd: $postcmd"
    ls $flags "$@"
fi

exit 0








