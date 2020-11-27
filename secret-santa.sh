check this code later
https://git.sr.ht/~moviuro/moviuro.bin/tree/master/secret-santa

#!/bin/bash

#awk 'END{print NR}
#' < "$1"

# awk '{
##
#if (NR%2 != 0)
#       print "hi"
#else
#       printf "%s%s", $0, (NR%2?"\t\t":RS)

#}' $1

## Create a temporary file to store the shuffled list
## Was unable to find a way to do it with awk, so saved the shuffled output to a file

tmp_file=$(mktemp)

## Perform shuffling of input file, and save it to temporary file created in /tmp

shuf "$1" --output="$tmp_file"

## Save the number of lines in the secret santa file to NUM_LINES
NUM_LINES=$(wc -l < $1)

## If the num lines is odd:
if [ $((NUM_LINES%2)) -ne 0 ]; then

## Capture the first line of the file, for line 2 and 3 print them on the same line
## To eliminate the odd number of people, get the first 2 names to buy a present together for the third person
        head -n1 "$tmp_file"
         sed -n '2,3p' "$tmp_file" | column

## For the rest of the lines pair the secret santa pairs up
        tail -n+4 "$tmp_file" | awk '{printf "%s%s", $0, (NR%2?"\t\t":RS)}'
fi
