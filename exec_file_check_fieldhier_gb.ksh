########################################################################
#   Name:  exec_file_check_fieldhier_gb.ksh
#   Date:  09/09/2020
#   Author: Sonu Pal
#   Desc:  Create Audit file and rename data for sam to callidus Interfaces for UK_IE project
#         
#  usage: exec_file_check_fieldhier_gb.ksh 
#
########################################################################



src_file_dir="/usr/local/idmc/SrcFiles/SAM/GB/SAP"

cd $src_file_dir

if [ -f OM_TM_GB10_SUCCESS* ]
then
echo the file exists
else
touch OM_TM_GB10_SUCCESS.csv
fi

ls OM_TM_GB10_SUCCESS* > fieldhier_list.txt
