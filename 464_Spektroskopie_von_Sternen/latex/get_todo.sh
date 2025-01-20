#! /bin/bash

echo -----
for i in $(ls | grep tex); do 
  if cat $i | grep TODO; then 
    printf "+++ $i\n\n"
  fi
done
