#!/bin/ksh 
#################################################################################################################################
#   Name:  file_verify.ksh
#   Date:  02/07/2016
# Author:  Satish Nakka
#   Desc:  Used for verifying the existence of source files
#
#
#  Maintenance Log
#  Date       Who       	Description
#  ------------------------------------------------------------------------------------------------------------------------------
#  02/07/2017 Satish Nakka	Initial file creation
####################################################################################################################################
#========================================================================================================
#Getting the argument values into variable
#========================================================================================================
echo "Script Execution Begins" > lst.log


file_pattern=$1;
lst_file=onbase_invoice_ext_appr_file_list.txt;

echo "File Pattern is :"$1 >> lst.log
echo "List file name is :"$lst_file >> lst.log

##file_pattern=SerengetiLaw_USAWA_*;
##lst_file=onbase_invoice_ext_appr_file_list.txt;

dummy_file="${file_pattern%?}"`date +%d%m%y`_dummy

#echo "Dummy file name is :"$dummy_file >> lst.log

#========================================================================================================
#Verifying the existing of file/s
#If exists, store the file name/s in list file for Informatica to process
#If does not exists pass a dummy file to list file for Informatica
#========================================================================================================

file_exists=`ls -1 $file_pattern 2>/dev/null |wc -l`

echo "File exits counter is ":$file_exists >>lst.log

if [ $file_exists -ge 1 ]; then
	ls $1 > $lst_file
else
	touch $dummy_file.txt
	echo $dummy_file.txt > $lst_file
fi