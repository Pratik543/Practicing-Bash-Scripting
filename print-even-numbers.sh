#! /bin/bash

echo "Printing Even Numbers from 2 to 20"

for ((i = 2; i <= 20; i++)); do
  if [[ $((i % 2)) -eq 0 ]]; then
    echo $i
  fi
done
