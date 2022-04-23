#!/bin/bash

#============================================================================================
# Author			:	Muhammad Ismail
# Program Name		: 	dupdel.sh
# Start Date 		:	21/04/2022
# Completion Date 	:	22/04/2022
# Purpose			:	Compare two files given as arguments at command line for duplication.
#					:	Then give the option to delete or keep the duplicate files.
#============================================================================================

clear

if [[ $# -eq 2 ]]; then
	# obtaining inode numbers of the files for comparision
	file1=$(ls -i $1 | awk '{print $1}')
	file2=$(ls -i $2 | awk '{print $1}')

	# If inodes are the same means same file has been given twice as argument
	# So programme will stop and give error message to the user for giving 
	# two different files as argument for comparision/duplication
	if [[ $file1 -eq $file2 ]]; then
		echo -e "\n|=======================================================|"
		echo "| Files are the same, please select two different files |"
		echo -e "|=======================================================|\n"
		exit
	fi
	
	# Files are checked here for differences
	# If files are duplicate then program will give user the option to either delete
	# any one file or keep both the duplicate files.
	if diff $1 $2 > /dev/null 2>&1; then
		echo "|==================================================|"
		echo "| Files are duplicate. Select an option to proceed |"
		echo "|==================================================|"
		echo
		echo -e "         [1] $1 \n         [2] $2 \n[3 or Enter] for no action\n" 
		read -p "Your Choice : " fileNo
		echo
		# If one is seleted then first file is deleted
		# If two is seleted then second file is deleted
		# If any other number or only Enter key is pressed no file will be deleted
		if [[ $fileNo -eq 1 ]]; then
			rm -v $1
		elif [[ $fileNo -eq 2 ]]; then
			rm -v $2
		else
			echo "No file has been removed"
		fi
		echo "===================================================="
		# If files are not duplicate and two different files.
		# Then differences are shown to the user
	else
		echo "|=============================================|"
		echo "| Files are different. Review the differences |"
		echo "|=============================================|"
		echo
		diff $1 $2
		echo
		echo "==============================================="
		echo
	fi
# If no arguments or less than or more than two arguments are given
# Program usage message is presented to the User 
else
	echo -e "\n====================================================================="
	echo "$0 <File-1> <File-2> - Give two files names for comparision"
	echo -e "=====================================================================\n"
fi