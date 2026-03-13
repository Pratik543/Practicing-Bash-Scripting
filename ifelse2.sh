#! /bin/bash

echo "Ctrl+c to stop the script."
while [[ true ]]; do

  echo "Write a number from 1 to 7 to know the day of the week."
  read day

  if [[ $day -eq 1 ]]; then
    echo "Monday"
  elif [[ $day -eq 2 ]]; then
    echo "Tuesday"
  elif [[ $day -eq 3 ]]; then
    echo "Wednesday"
  elif [[ $day -eq 4 ]]; then
    echo "Thursday"
  elif [[ $day -eq 5 ]]; then
    echo "Friday"
  elif [[ $day -eq 6 ]]; then
    echo "Saturday"
  elif [[ $day -eq 7 ]]; then
    echo "Sunday"
  else
    echo "Invalid input. Write a number only between 1 to 7"
  fi

done
