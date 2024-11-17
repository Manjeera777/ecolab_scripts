#!/bin/ksh 
#################################################################################################################################
#   Name:  split_files.ksh
#   Date:  01/11/2017
# Author:  Satish Nakka
#   Desc:  Used for splitting one target file into multiple files based on number of source files provided for OnBase Project
#
#
#  Maintenance Log
#  Date       Who       	Description
#  ------------------------------------------------------------------------------------------------------------------------------
#  01/11/2017 Satish Nakka	Initial file creation
#  01/13/2017 Satish Nakka	Modified the split based on PIPE delimeted target file
####################################################################################################################################
#========================================================================================================
#Getting the argument values into variable
#========================================================================================================

export file_name=$1;
#export file_name=ECL_RPP_Check_Request_*;
lg=splt_`date +%Y%m%d_"%T"`.log
#=========================================================================================================
echo "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*" > $lg
echo "#######  Execution begins to split the target file based on number of source files  ######" >> $lg
echo "==============================================================================================================================" >> $lg
echo "Time of Execution :" `date +%Y:%m:%d-"%T"` >> $lg
echo "File Pattern to Search :" $file_name >> $lg

#========================================================================================================
#Removing the double quotes from last column holding source file name
#=======================================================================================================
invs=`awk 'END {print NR}' onbase_file.csv`
awk -F"|" '{gsub("\"","",$35)}1' OFS="|" onbase_file.csv > tmp.csv
echo "Removed double quotes from the last column of onbase_file.csv" >> $lg

export num=$(cut -d"|" -f35 tmp.csv | sort |uniq | wc -l)
export fls=$(cut -d"|" -f35 tmp.csv | sort |uniq)

#========================================================================================================
#Splitting the target file based on Source File Name/s
#========================================================================================================
echo "Number of source files :" $num "\n"  >> $lg
echo "Total Number of Invoices :" $invs  "\n"  >> $lg
awk -F"|" '{print > ($35".csv")}' tmp.csv
echo "onbase_file.csv is splitted into :\n" "$fls\n" >> $lg
echo "Splitting of file onbase_file.csv is complete" >> $lg
#========================================================================================================
#Looping through split files
#========================================================================================================
for fle in `ls $file_name`; do 
	echo "==============================================================================================================================\n" >> $lg
	echo "File Name in context is                    	        :"  $fle >> $lg
	numrcds=`awk 'END {print NR}' $fle`
	#========================================================================================================
	#Removing the last column
	#========================================================================================================
	cut -d"|" -f1-34 $fle > tmp_$fle.csv
	echo "Removed the column holding source file name in the file :" $fle >> $lg
	#========================================================================================================
	#Making csv file
	#========================================================================================================
	#awk '{gsub(/[^,]+/,"\"&\"")}1' tmp_$fle.csv > tmp1_$fle.csv
	sed 's/|/,/g' tmp_$fle.csv > tmp1_$fle.csv
	echo "File transformed as csv " >> $lg	
	#========================================================================================================
	#Retaining the original file name
	#========================================================================================================
	mv tmp1_$fle.csv  $fle
	echo "Target file recreated                                   :" $fle ' - '$numrcds' Invoices' >> $lg	
	#========================================================================================================
	#Adding header
	#========================================================================================================
#	{
#	print "\"DOCUMENT_TYPE\",\"INVOICE_NUMBER\",\"VENDOR_NAME\",\"VENDOR_NUMBER\",\"INVOICE_DATE\",\"COMPANY_CODE\",\"CURRENCY\",\"FILE_NAME\",\"WORKTYPE\",\"REGION\",\"PO_NUMBER\",\"EMPLOYEE_NUMBER\",\"DELIVERY_COUNTRY\",\"EXTERNAL_APPROVAL\",\"ORIGINATION_NUMBER\",\"SOURCE\",\"GROSS_AMOUNT\",\"PRETAX_AMOUNT\",\"SUBLEDGER_VALUE\",\"COST_CENTER\",\"GL_ACCOUNT\",\"INTERNAL_ORDER\",\"SERVICE_ORDER\",\"TRUCK_NUMBER\",\"AMOUNT_TO_PAY\",\"MEMO\",\"SUBMITTED_BY\",\"NEED_BY_DATE\",\"REMIT_TO_NAME\",\"REMIT_TO_ADDR_LN\",\"REMIT_CITY\",\"REMIT_STATE\",\"REMIT_ZIP_CODE\",\"EFT_FLAG\""
#	cat "$fle"
#	} > "${fle}.tmp"
#	echo "Added header to the csv files" >> $lg	
	#========================================================================================================
	#Removing the temp files
	#========================================================================================================
	rm -f tmp*
	echo "Removed all temp file from the directory" >> $lg
	#echo "==============================================================================================" >> $lg
done

#========================================================================================================
#Removing the original target file
#========================================================================================================
rm onbase_file.csv
echo "Removed the original Target File onbase_file.csv"  >> $lg
echo "==============================================================================================================================" >> $lg
echo "########      Execution Completed   #######" >> $lg
echo "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*"  >> $lg

#========================================================================================================
#Removing the older log files
#========================================================================================================
find . -mtime +5 -name "splt*.log" -exec rm -f {} \; 2>/dev/null

