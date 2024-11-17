########################################################################
#   Name:  exec_file_check_fieldhier_mx.ksh
#   Date:  09/07/2023
#   Author: Sonu Pal
#   Desc:  Informatica SAM Interfaces for Mexico project
#         
#  usage: exec_file_check_fieldhier_mx.ksh 
#
########################################################################



src_file_dir="/usr/local/idmc/SrcFiles/SAM/MX/SAP"

cd $src_file_dir

if [ -f OM_TM_MX10_SUCCESS* ]
then
echo the file exists
else
touch OM_TM_MX10_SUCCESS.csv
fi

ls OM_TM_MX10_SUCCESS* > fieldhier_list.txt
