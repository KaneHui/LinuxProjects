#!/usr/bin/env bash

# mysftp - make sftp start up more like ftp

echo -n "User account:"
read account

if [ -z "$account" ] ; then
    exit 0      # change their mind, presumably
fi


if [ -z "$1" ] ; then
    echo -n "Remote host: "
    read host

    if [ -z $host ] ; then
        exit 0
    fi
else
    host=$1
fi


echo sftp -C $account@$host