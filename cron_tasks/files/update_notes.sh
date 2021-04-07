#!/usr/bin/env bash

cd /home/azx/Projects/notes
no_changes=$(git status | grep 'nothing to commit' | sed 's/\s//g')
if [ $no_changes ]; then
  exit 0
fi
git add .
git commit -m "$(date +"%H:%M:%S %d-%m-%Y")"
git push origin master
