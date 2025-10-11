#!/bin/bash

read -p "Enter your username: " username

echo "You entered $username"

sudo useradd -m $username

echo "New User $username Added"
