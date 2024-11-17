#!bin/ksh
#####################################################################################################################################
#   Name:  email_splr.ksh                                                                                                           #
#   Date:  05/01/2018                                                                                                               #
# Author:  Satish Nakka                                                                                                             #
#   Desc:  Used to Notify Business about Vendors without GEP Supplier Id                                                            #
#                                                                                                                                   #
#                                                                                                                                   #
#  Maintenance Log                                                                                                                  #
#  Date       Who       	Description                                                                                               #
#  ------------------------------------------------------------------------------------------------------------------------------   #
#  05/01/2018 Satish Nakka	Initial file creation                                                                                   #
#                                                                                                                                   #
#####################################################################################################################################

#=================================================================================================================================
#Getting the argument values into variables
#=================================================================================================================================


#path=/usr/local/infadata/infaqa/TgtFiles/EEPD/GEP/Payments
#file=missing_gep_supplier_id_ebs.txt

path=$1
file=$2
file_name=$file.txt
#rcpnts=satish.nakka@ecolab.com
rcpnts=$3


echo "Target File Directory from 1st argument:         " $path > $path/eml.log
echo "Target File Name from 2nd argument     :         " $file >> $path/eml.log
echo "List of Recepeints from 3rd argument   :         " $rcpnts >> $path/eml.log

echo "Attached file contains list of Vendors without GEP supplier ID." > $path/mail_body

#==================================================================================================================================
#Verifying the existence of Error File
#==================================================================================================================================

if [ -s $path/$file_name ];
then
	echo "File Exists" >> $path/eml.log
##(cat $path/mail_body; uuencode $path/$file_name $file_name) | mailx -s "Vendors Without GEP Supplier IDs" $rcpnts

echo "" | mailx -s "Vendors Without GEP Supplier IDs" -a "$path/$file_name" $rcpnts

	echo "Mail Sent successfully" >> $path/eml.log
else
	echo "File does not exists" >> $path/eml.log
fi

#==================================================================================================================================
#Removing the mail body file
#==================================================================================================================================

rm $path/mail_body
echo "Mail Process completed" >> $path/eml.log


