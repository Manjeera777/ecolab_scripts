########################################################################
#   Name:  exec_file_check_fieldhier_th11.ksh
#   Date:  12/22/2020
#   Author: Sonu Pal
#   Desc: Informatica SAM Interfaces for Korea, Vietnam, Thailand project
#         
#  usage: exec_file_check_fieldhier_th11.ksh 
#
########################################################################



src_file_dir="/usr/local/idmc/SrcFiles/SAM/TH11/SAP"

cd $src_file_dir

if [ -f OM_TM_TH11_SUCCESS* ]
then
echo the file exists
else
touch OM_TM_TH11_SUCCESS.csv
fi

ls OM_TM_TH11_SUCCESS* > fieldhier_list.txt
