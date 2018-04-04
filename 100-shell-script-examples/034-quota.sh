#!/usr/bin/env bash

# newquota - a front0end to quota that works with fullword flags a la GNU

# quota has three possible flags: -g -v and -q and in this script we allow
# them to be '--group' '--verbose' and '--quiet' too:

# man quota

flags=""
realquota="/usr/bin/quota"

while [ $# -gt 0 ]
do
    echo checking flag $1
    case $1 in
    --help              )   echo "Usage: $0 [--group --verbose --quiet -gvq]" >&2
                            exit 1 ;;
    --group | -group    )   flags="$flags -g" ; shift   ;;
    --verbose | -verbose)   flags="$flags -v" ; shift   ;;
    --quiet | -quiet    )   flags="$flags -q" ; shift   ;;
    --                  )   shift;              break   ;;
    *                   )   break;
    esac

done

exec $realquota $flags "$@"

