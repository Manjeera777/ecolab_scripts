########################################################################
#   Name:  exec_file_check_fieldhier_can.ksh
#   Date:  02/11/2020
#   Author: Sonu Pal
#   Desc:  Create Audit file and rename data for sam to callidus Interfaces for catalyst retrofit project
#         
#  usage: exec_file_check_fieldhier_can.ksh 
#
########################################################################



src_file_dir="/usr/local/idmc/SrcFiles/SAM/CAN/SAP"

cd $src_file_dir

if [ -f OM_TM_CA10_SUCCESS* ]
then
echo the file exists
else
touch OM_TM_CA10_SUCCESS.csv
fi

ls OM_TM_CA10_SUCCESS* > fieldhier_list.txt
