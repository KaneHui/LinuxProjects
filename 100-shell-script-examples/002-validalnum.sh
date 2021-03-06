#!/usr/bin/env bash
# validaAlphaNum - Ensures that input only consists of alphabetical and numeric characters.

validAlphaNum(){
    # validate arg: return 0 if all upper+lower+digits, 1 otherwise
    # Remove all unacceptable chars [^[:alnum:]] means pattern which doesn't contain a alphabetical nor numeric characters
    compressed="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"
    if [ "$compressed" != "$input" ] ; then
        return 1
    else
        return 0
    fi
}

# Sample usage of this function in a script
echo -n "Enter input:"
read input
if ! validAlphaNum "$input" ; then
    echo "Your input must consist of only letters and numbers." >&2
    exit 1
else
    echo "Input is valid"
fi

exit 0