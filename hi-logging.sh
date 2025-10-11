#!/bin/bash

echo "Starting to print 'hi' every 2 seconds"
echo "Press Ctrl+C to stop"
echo ""

while true; do
  echo "hi, Time is $(date)"
  sleep 2
done
