########################################################################
#   Name:  exec_file_check_fieldhier_th.ksh
#   Date:  12/22/2022
#   Author: Sonu Pal
#   Desc:  Informatica SAM Interfaces for Korea, Vietnam, Thailand project
#         
#  usage: exec_file_check_fieldhier_th.ksh 
#
########################################################################



src_file_dir="/usr/local/idmc/SrcFiles/SAM/TH/SAP"

cd $src_file_dir

if [ -f OM_TM_TH10_SUCCESS* ]
then
echo the file exists
else
touch OM_TM_TH10_SUCCESS.csv
fi

ls OM_TM_TH10_SUCCESS* > fieldhier_list.txt
