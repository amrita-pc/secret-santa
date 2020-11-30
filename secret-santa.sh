check this code later
https://git.sr.ht/~moviuro/moviuro.bin/tree/master/secret-santa

#!/bin/bash

## Currently the input file has pairs of couples stored sequentially
## We are removing the last member in the file as they are not part of a couple

#list_of_couples=$(awk 'NR>1{print prev}{prev=$0}' "$1" |  awk '{printf "%s%s", $0, (NR%2?"\t\t":RS)}')
#add_index_santa_list=$(awk '{print NR,$0; getline}{ if (NR%2==0); print NR-1, $0}' "$1")

declare -A pairs

## By default, bash in a while loop splits on all whitespaces, e.g. if a person's name is Amy Brown, the loop will split "Amy" and "Brown" into two separate elements
## Set IFS to "\n" to ensure we only split on newlines
#IFS=$'\t\t'
while read key value; do
        pairs[$key]="${pairs[$key]}${pairs[$key]:+,}$value"
done < /tmp/line-no-secret-santa

#for key in "${!pairs[@]}"; do echo "$key ${pairs[$key]}"; done

for key in "${!pairs[@]}"; do
IFS=',' read -ra names <<< "${pairs[$key]}"
if [ "$key" -ne 1 ]; then
        echo "$key ${names[0]}" \
        && echo "$key ${names[1]}"
fi
done

# /tmp/line-no-secret-santa


## Create a temporary file to store the shuffled list
## Was unable to find a way to do it with awk, so saved the shuffled output to a file

#tmp_file=$(mktemp)

## Perform shuffling of input file, and save it to temporary file created in /tmp

#shuf "$1" --output="$tmp_file"


## Save the number of lines in the secret santa file to NUM_LINES
#NUM_LINES=$(wc -l < $1)

### If the num lines is odd:
#if [ $((NUM_LINES%2)) -ne 0 ]; then
#
### Capture the first line of the file, for line 2 and 3 print them on the same line
### To eliminate the odd number of people, get the first 2 names to buy a present together for the third person
#       head -n1 "$tmp_file"
#        sed -n '2,3p' "$tmp_file" | column
#
### For the rest of the lines pair the secret santa pairs up
##      tail -n+4 "$tmp_file" | awk '{printf "%s%s", $0, (NR%2?"\t\t":RS)}'
##fi
