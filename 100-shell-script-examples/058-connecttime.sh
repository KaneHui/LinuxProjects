#!/usr/bin/env bash

# connecttime - reports cumulative connection time for month/year entries
# found in the system log file

log="/var/log/syslog"
tempfile="/tmp/$0.$$"

trap "rm $tempfile" EXIT

cat << 'EOF' > $tempfile
BEGIN{
    lastmonth=""
    sum=0
}
{
    if ( $1 != lastmonth && lastmonth != "" ){
        if (sum > 60)   { total = sum/60 " hours" }
        else            { total = sum " minutes" }
        print lastmonth ": " total
        sum=0
    }
}
END{
    if (sum > 60)
}
EOF

exit 0