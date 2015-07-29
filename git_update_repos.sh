#! /usr/bin/env bash

for d in */; 
do
	(
		echo 
		echo "============================="
		echo $d
		echo "============================="
		echo 

		cd $d
		if [ -d ".git" ]; then
			git pull --rebase || git pull
		else
			echo "not a git repo"
		fi
        )
done;
