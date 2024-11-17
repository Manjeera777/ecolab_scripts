########################################################################
#   Name:  exec_file_check_fieldhier_es1g.ksh
#   Date:  10/04/2021
#   Author: Srini P
#   Desc:  Create Audit file and rename data for sam to callidus Interfaces for R6 project
#         
#  usage: exec_file_check_fieldhier_es1g.ksh 
#
########################################################################



src_file_dir="/usr/local/idmc/SrcFiles/SAM/ES1G/SAP"

cd $src_file_dir

if [ -f OM_TM_ES1G_SUCCESS* ]
then
echo the file exists
else
touch OM_TM_ES1G_SUCCESS.csv
fi

ls OM_TM_ES1G_SUCCESS* > fieldhier_list.txt
