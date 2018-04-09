#!/usr/bin/env bash

# VALIDATOR - Checks to ensure that all enviroment variables are valid
# looks at SHELL, HOME, PATH, EDITOR, MAIL, and PAGER

errors=0

in_path(){
    # given a command and the PATH, try to find the command. Returns
    # 1 if found, 0 if not. Note that this temporarily modifies the
    # the IFS input field seperator, but restores it upon completion.
    oldIFS=$IFS
    IFS=":"
    retval=0
    for directory in $path
    do
        if [ -x $directory/$cmd ] ; then
            retval=1
        fi

    done
    IFS=$oldIFS
    return $retval

}

validate(){
    varname=$1
    varvalue=$2
    if [ ! -z $varvalue ] ; then
        if [ "${varvalue:0:1}" = "/" ] ; then
            if [ ! -x $varvalue ] ; then
                echo "** $varname set to $varvalue, but I cannot find executable."
                errors=$(( $errors + 1 ))
            fi
        else
            if in_path $varvalue $PATH ; then
                echo "** $varname set to $varvalue, but I cannot find it in PATH."
                errors=$(( $errors + 1 ))
            fi
        fi
    fi

}

###### Begining of actual shell script #####

if [ ! -x ${SHELL:?"Cannot proceed without SHELL being defined."} ] ; then
    echo "** SHELL set to $SHELL, But I cannot find that executable."
    errors=$(( $errors + 1 ))
fi

if [ ! -d ${HOME:?"Your need to have your HOME set to your home directory"} ] ; then
    echo "** HOME set to $HOME, but it's not a directory."
    errors=$(( $errors + 1 ))
fi

# Our first interesting test: are all the paths in PATH valid?

oldIFS=$IFS
IFS=":"
for directory in $PATH
do
    if [ ! -d $directory ] ; then
        echo "** PATH contains invalid directory $directory"
        errors=$(( $errors + 1 ))
    fi
done


IFS=$oldIFS

# The following can be undefined, and they can also be a progname, rather
# than a fully qualified path. Add additional variables as necessary for
# your site and user commmunity.

validate "EDITOR" $EDITOR
validate "MAILER" $MAILER
validate "PAGER" $PAGE

# and, finally, a different ending depending on whether errors > 0

if [ $errors -gt 0 ] ; then
    echo "Errors encountered. Please notify sysadmin for help."
else
    echo "Your enviroment checks out fine."
fi

exit 0















