#!/bin/bash

function help_
{
    echo "There sholud be some help info."
}

function ImportScriptsExist
{
    local fileName="ImportFiles.sh"
    if [[ -f $fileName ]]; then . $fileName;
    else
        echo "Fatal error: unable to find $fileName" > /dev/stderr
        help_
        exit -9
    fi
}

function FirstArgExist()
{
    if ! [[ -n $1 ]]
    then
        echo "Error: first argument not exist" > /dev/stderr
        help_
        exit -5
    fi

    if ! [[ $1 =~ ^(calc|search|reverse|strlen|log|interactive|help|exit)$ ]]
    then
        echo "Error: first argument should be like calc/search/reverse/strlen/log/interactive/help/exit. Not $1." > /dev/stderr
        help_
        exit -6
    fi
}

ImportScriptsExist
ImportScripts
FirstArgExist $1

case $1 in
    "calc")
        # $2 - sum/sub/mul/div
        # $3 - left integer parameter
        # $4 - right integer parameter
        if require Libs/CalcLib.sh; then calc $2 $3 $4; fi;;
    "search")
        # $2 - directory where to search
        # $3 - regular expression
        if require Libs/SearchLib.sh; then search $2 $3; fi;;
    "reverse")
        # $2 - file to read from
        # $3 - file to write to
        if require Libs/ReverseLib.sh; then reverse $2 $3; fi;;
    "strlen")
        # $1 - the string that was given from the terminal
        if require Libs/StrLenLib.sh; then strlen $2; fi;;
    "log")
        if require Lis/LogLib.sh; then log; fi;;
    "interactive")
        if require Libs/Interactive/InteractiveLib.sh; then interactive; fi;;
    "help")
        help_;;
    "exit")
        if require Libs/ExitLib.sh; then exi "$@"; fi;;
esac
