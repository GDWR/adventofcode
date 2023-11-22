#!/usr/bin/env bash

all_chars_unique() {
  result="true"
  i=0
  while read -n 1 char1; do
    if [ -z "$char1" ]; then
      continue
    fi

    ((i++))

    while read -n 1 char2; do
      if [ -z "$char2" ]; then
        continue
      fi

      if [ "$char1" == "$char2" ]; then
        result="false"
      fi
    done <<<${1:$i}
  done <<<$1

}

input="./data"
while IFS= read -r line; do
  window=${line:0:14}
  counter=14
  while read -n 1 char; do

    all_chars_unique $window
    if [ $result == "true" ]; then
      printf "done: $window - $counter\n"
      break
    fi
    ((counter++))
    window="${window:1:13}${char}"
  done <<<${line:14}

done < "$input"
