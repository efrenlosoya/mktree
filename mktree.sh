#!/bin/bash

# This version is for ZSH and does not support BASH shell

if [[ $# < 1 ]]
then
    echo "usage: mktree directory/{directoryA,directoryB/{file1.js,file2.js}}"
    exit 1
fi

for param in $@
do

    # add safety check - mktree does not allow making a directory or file beginning with /. Must use relative paths only like dirname/filname.js
    # the reason for that is I am not sure if that is a safe thing to do and I split on character /.
    if [[ $param = "/"* ]]
        then
            echo "The first char is /. mktree only supports relative paths like somedir/somefile.js"
            break
    fi

    # create array from / delimited string: this is for zsh - need a conditional here to add support for bash
    # IMPORTANT: zsh arrays index starts with one and not zero
    parts=("${(@s:/:)$(echo $param)}")

    # will handle relative prefixes such as ../ or ./
    relativePrefix=""

    # find out if we are dealing with relative redirection like ../ or ./
    if [[ $parts[1] = "."* ]]
        then
            # create string like ../
            relativePrefix=${parts[1]}/

            # remove the relative prefix from the array which happens to be the first element
            parts=("${parts[@]:1}")
    fi

    let i=1

    # will use this var to create directory path
    directoryPart=$relativePrefix

    # figure out which parts are directories and which are files
    # then run commands to create directories and files
    for part in "${parts[@]}"
    do

        # find out if this is the last element
        if [[ ${#parts[@]} = $(( $i )) ]]
        then

            # find the index where the dot is in
            if [[ $part = *"."* ]]
            then

                if [[ $directoryPart != '' ]]
                then

                    # create parent directory or directories
                    mkdir -p $directoryPart
                fi

                # create file by concatenating the directory path and the file name (value of part at this point)
                touch $directoryPart$part

            else
                mkdir -p $directoryPart$part
            fi

        fi

        # build directory path
        directoryPart+=$part/

        ((i++))

    done
done
