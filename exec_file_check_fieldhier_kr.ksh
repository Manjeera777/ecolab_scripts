########################################################################
#   Name:  exec_file_check_fieldhier_kr.ksh
#   Date:  12/22/2022
#   Author: Sonu Pal
#   Desc:  Informatica SAM Interfaces for Korea, Vietnam, Thailand project
#         
#  usage: exec_file_check_fieldhier_kr.ksh 
#
########################################################################



src_file_dir="/usr/local/idmc/SrcFiles/SAM/KR/SAP"

cd $src_file_dir

if [ -f OM_TM_KR10_SUCCESS* ]
then
echo the file exists
else
touch OM_TM_KR10_SUCCESS.csv
fi

ls OM_TM_KR10_SUCCESS* > fieldhier_list.txt
