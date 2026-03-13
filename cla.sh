#! /bin/bash

# Command Line Arguments

# $1 : Prints the first agrument.
# $2 : Prints the second agrument.
# $3 : Prints the third agrument.
#
# $# : Prints the total number of arguments. - it is going to exclude the script name.
# $@ : This variable holds all the CLA passed to the script, treating each agrument as a separate quoted string.
# $* : but it treats all arguments as a single string with spaces separating them.
#
# $@ Vs $*
# 1. $@ treats each argument as a separate entity, keeping them distinct even if there are spaces in the arguments.
# 2. $* treats all arguments as a single string, with spaces between them, which can lead to loss of distinction if arguments contains spaces.

echo "Script Name : $0"
echo "First Argument : $1"
echo "Second Argument : $2"
echo "Third Argument : $3"
echo "Number of Arugments : $#"
echo "All arugments as \$@ : $@"
echo "All arugments as \$* : $*"
