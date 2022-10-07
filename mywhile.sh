#!/bin/bash

# determining whether -a flag is set
if [ $1 = '-a' ]
then
  FINDALL=true
else
  FINDALL=false
fi 

# iterating over positional params
for file
  do
    count=0
    found=false

    # setting field separator and iterating over $PATH
    IFS=:
    for dir in $PATH
    do
        cd $dir
        # checking whether file exists and is not a directory
        if [ -x "$file" -a ! -d "$file" ] 
        then
          unset found
          found=true 
          count=$((count+1))
            # echoes only once unless -a or count=0
            if [ FINDALL -o "$count" -lt 2 ]
            then
            echo "File found in $dir/$file"
            echo "Found: $found"
            echo "Count: $count"
            fi
        fi
    done
    # echoes if file was not found
    if [ $count -eq 0 -a $file!='-a' ]
    then
      echo "$file not found"
    fi
done