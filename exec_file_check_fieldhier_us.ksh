########################################################################
#   Name:  exec_file_check_fieldhier.ksh
#   Date:  02/13/2017
#   Author: Sangeetha Yadagiri
#   Desc:  Create Audit file and rename data for sam to callidus Interfaces for catalyst 4A project
#         
#  usage: exec_file_check_fieldhier.ksh 
#
#  Maintenance Log
#  Date       Who       		Description
#  --------   --------- -------------------------------------------------
#  02/13/2017 Sangeetha Yadagiri    	Initial Creation
#  04/11/2017 Khairul   Anam
#  11/26/2018 Anil			split the script to USA and CAN
########################################################################



src_file_dir="/usr/local/infadata/infaprod/SrcFiles/SAM/USA/SAP"

cd $src_file_dir

if [ -f OM_TM_US10_SUCCESS* ]
then
echo the file exists
else
touch OM_TM_US10_SUCCESS_EMPTY.csv
fi

ls OM_TM_US10_SUCCESS* > fieldhier_list.txt
