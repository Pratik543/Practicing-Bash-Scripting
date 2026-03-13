#! /bin/bash

echo "If Else Conditional Statement to check whether the year is a leap year or not."
echo "Ctrl + c to stop the script."

while [[ true ]]; do

  read -p "Enter a year: " year

  if ((year % 4 == 0 && year % 100 != 0 || year % 400 == 0)); then
    echo "$year is a leap year"
  else
    echo "$year is not a leap year"
  fi

done
