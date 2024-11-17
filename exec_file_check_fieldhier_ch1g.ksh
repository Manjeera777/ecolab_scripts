########################################################################
#   Name:  exec_file_check_fieldhier_ch1g.ksh
#   Date:  10/04/2021
#   Author: Srini P
#   Desc:  Create Audit file and rename data for sam to callidus Interfaces for R6 project
#         
#  usage: exec_file_check_fieldhier_ch1g.ksh 
#
########################################################################



src_file_dir="/usr/local/idmc/SrcFiles/SAM/CH1G/SAP"

cd $src_file_dir

if [ -f OM_TM_CH1G_SUCCESS* ]
then
echo the file exists
else
touch OM_TM_ch1g_SUCCESS.csv
fi

ls OM_TM_CH1G_SUCCESS* > fieldhier_list.txt
