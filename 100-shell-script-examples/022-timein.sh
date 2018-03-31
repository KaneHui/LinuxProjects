#!/usr/bin/env bash

# timein - show the current time in the specified timezone or
# geographic zone. Without any argument, show UTC/GMT. Use the
# word "list" to see a list of known geographic regions
# note that it's possible to match a zone directory(a region)
# but that only timezone files are valid specifications.

# Timezone database ref: http://www.twinsun.com/tz/tz-link.htm
#------------------------------debugging---------------------------------------
zonedir="/usr/share/zoneinfo"

if [ ! -d $zonedir ] ; then
    echo "No timezone database at $zonedir" >&2 ; exit 1
fi


if [ -d "$zonedir/posix" ] ; then
    zonedir=$zonedir/posix
fi


if [ $# -eq 0 ] ; then
    timezone="UTC"
    mixedzonde="UTC"

elif [ "$1" = "list" ] ; then
    ( echo "All known timezones and resgions defined on this system:"
      cd $zonedir
      find * -type l -print | xargs -n 1 | gawk '{ print $1 }'
    ) | more
    exit 0

else

    region="$(dirname $1)"
    zone="$(basename $1)"
    print "region:$region"
    print "zone:$zone"
    # Is it a direct match? If so, we're good to go. Otherwise we need
    # to dig around a bit to find things. Start by just counting matches

    matchcnt="$(find $zonedir -name $zone -type l -print0 | wc -l | sed 's/[^[:digit:]]//g')"

    if [ $matchcnt -gt 0 ] ; then
        if [ $matchcnt -gt 1 ] ; then  # more than one file match
            echo "\"$zone\" matches more than one possible time zone record.">&2
            echo "Please use 'list' to see all known regions and timezones "
            exit 1
        fi
        match="$(find $zonedir -name $zone -type f -print)"
        mixedzone="$zone"
    else
        # Normalize to first upper, rest of word lowercase for region + zone
        mixedregion="$(echo ${region:0:1} | tr '[[:lower:]]' '[[:upper:]]')$(echo ${region#?} | tr '[[:upper:]]' '[[:lower:]]') "
        mixedzone="$(echo ${zone:0:1} | tr '[[:lower:]]' '[[:upper:]]')$(echo ${region#?} | tr '[[:upper:]]' '[[:lower:]]')"

        if [ "$mixedregion" != "." ] ; then
            #only look for specified zone in specified region
            # to let users sepcify unique matches when there's
            # more than one possibility(e.g., "Atlantic")
            match="$(find $zonedir/$mixedregion -type f -name $mixedzone -print)"

        else
            match="$(find $zonedir -name $mixedzone -type -f -print)"

        fi

        if [ -z "$match" ] ; then
            if [ ! -z $(find $zonedir -name $mixedzone -type -d -print) ] ; then
                echo "The region \"$region\" has more than one timezone. Please use 'list'" >&2
            else
                echo "Can't find an exact match for \"$1\".Please use 'list'" >&2
            fi
            echo "to see all known regions and timezones." >&2
            exit 1
        fi

    fi
    timezone="$match"
fi
nicetz="$(echo $timezone | sed 's|$zonedir/||g')"  #pretty up the output
echo "It's $(TZ=$timezone date '+$A,%B %e,%Y, at $1:$M: $p') in $nicetz"
exit 0