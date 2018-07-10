#!/usr/bin/env bash

# update snpe to newest version

while getopts "o:n:" opt; do	
	case $opt in
	o) old_snpe_version="$OPTARG"	;;	 
	n) new_snpe_version="$OPTARG"	;;
	esac
done
shift $(($OPTIND - 1))

new_snpe_sdk_dir="$HOME/share/SNPE_SDK/snpe-$new_snpe_version"

if [ -d $new_snpe_sdk_dir ] ; then
	echo "Found new snpe version at: $new_snpe_sdk_dir"
	cp -R $new_snpe_sdk_dir /home/kane/
fi

echo "update bashrc ......"
echo "old version : $old_snpe_version"

sed -i "s/snpe-${old_snpe_version}/snpe-${new_snpe_version}/g" /home/kane/.bashrc

echo "source bashrc ......"
source /home/kane/.bashrc
