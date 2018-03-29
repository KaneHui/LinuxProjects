#!/usr/bin/env bash
# locate - search the locate database for the specified pattern

locatedb="/var/lib/mlocate/mlocate.db"

exec grep -i "$@" $locatedb