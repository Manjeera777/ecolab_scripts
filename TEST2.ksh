#!/bin/ksh 
#####################################################################################################################################
#   Name:  EEPD_sap_param_changes.ksh                                                                                                #
#   Date:  03/27/2017                                                                                                               #
# Author:  Satish Nakka                                                                                                             #
#   Desc:  Used for updating the LAST_RUN_DT parameter value with latest run date for CDC                                           #
#                                                                                                                                   #
#                                                                                                                                   #
#  Maintenance Log                                                                                                                  #
#  Date       Who       	Description                                                                                               #
#  ------------------------------------------------------------------------------------------------------------------------------   #
#  03/24/2017 Satish Nakka	Initial file creation                                                                                   #
#  11/09/2017 Satish Nakka	Modified the script to consider CDC file name specific to each Work flow                                #
#                           Log name/s will be created seperately for each system with date stamp                                   #
#														Log Files will be archived for five days                                                                #
#                                                                                                                                   #
#####################################################################################################################################
#=================================================================================================================================
#Getting the argument values into variables
#=================================================================================================================================

set -x

root_dir=/usr/local/idmc
param_file=EEPD_param_GEP_Payments.txt
lst_dt=LAST_RUN_DT_EBS
nxt_dt=NEXT_RUN_DT_EBS
sess_name=mct_EEPD_EXTRACT_GEP_INVOICE_PAYMENTS_EBS
last_dt='$$'$lst_dt
next_dt='$$'$nxt_dt
op_file=sap_last_run_dt_ebs.txt


param_dir="$root_dir/ParamFiles/EEPD"
#output_file=`grep '$OutputFileName' $param_dir/$param_file | cut -f 2 -d'='`

tgt_dir=`grep '$PMTargetFileDir' $param_dir/$param_file | cut -f 2 -d'='`
#$tgt_dir=$root_dir/TgtFiles/EEPD/

#root_dir=/usr/local/idmc
#param_file=EEPD_SAP.txt
#
sapsys=`echo $lst_dt | rev | cut -d"_" -f1 | rev | tr '[:upper:]' '[:lower:]'`

lg_fl=$tgt_dir/sap_"$sapsys"_`date +%Y%m%d`.log

#touch $tgt_dir/sap.log
touch $lg_fl

echo 'Execution Begins' > $lg_fl


#==================================================================================================================================
#Verifying the existence of sixth argument for CDC date output file name
#==================================================================================================================================
if [ -z "sap_last_run_dt_ebs.txt" ]
then
	output_file=sap_last_run_dt.txt
else
	output_file=$op_file
fi	

echo "========================================================================================================="  >> $lg_fl
echo "Time of Execution                       :" `date +%Y:%m:%d-"%T"`>> $lg_fl
echo 'Infa Root Dir from  1st argument        : '$root_dir >> $lg_fl
echo 'Parameter file name from  2nd argument  : '$param_file >> $lg_fl
echo 'NEXTRUNDT param name from 3rd argument  : '$next_dt >> $lg_fl
echo 'LASTRUNDT param name from 4th argument  : '$last_dt >> $lg_fl
echo 'Session name from 4th argument          : '$sess_name >> $lg_fl
echo 'Date o/p File name from 5th argument    : '$output_file >> $lg_fl
echo 'Parameter File Directory                : '$param_dir >> $lg_fl
echo 'Target dir from parameter file          : '$tgt_dir >> $lg_fl

#==================================================================================================================================
#Getting the Date value from Parameter File
#==================================================================================================================================
last_run_dt_prev=`grep $last_dt $param_dir/$param_file | cut -f 2 -d'='`
next_run_dt_prev=`grep $next_dt $param_dir/$param_file | cut -f 2 -d'='`

echo 'Prev Last Run Dt 			                  : '$last_run_dt_prev >> $lg_fl
echo 'Prev  Next Run Dt 		                  : '$next_run_dt_prev >> $lg_fl

#==================================================================================================================================
#Getting the Latest Date value from target File
#==================================================================================================================================
curr_dts=`cat $tgt_dir/$output_file | sort -nr | head -1`
last_run_dt_curr=`echo $curr_dts | cut -d '|' -f 1`
next_run_dt_curr=`echo $curr_dts | cut -d '|' -f 2`

echo 'Current Date 			                      : '$last_run_dt_curr >> $lg_fl
echo 'Next Date   			                      : '$next_run_dt_curr >> $lg_fl


#====================================================================================================================================
#Verifying if Target File has value or not
#====================================================================================================================================
dt_cnt=`awk 'END {print NR}' $tgt_dir/$output_file`

echo 'Number of rows in target date file      : '$dt_cnt >> $lg_fl

#====================================================================================================================================
#Storing the available maximum date in a variable
#====================================================================================================================================

if [ $dt_cnt -eq 0 ]; then
	last_run_dt=$last_run_dt_prev
	next_run_dt=$next_run_dt_prev
else
	last_run_dt=$last_run_dt_curr
	next_run_dt=$next_run_dt_curr

fi

echo 'Value to replace in parameter file      : '$last_dt'='$last_run_dt >> $lg_fl
echo 'Value to replace in parameter file      : '$next_dt'='$next_run_dt >> $lg_fl


#====================================================================================================================================
#Update the Parameter file with available lastest date
#====================================================================================================================================
#sed 's/.*$$LAST_RUN_DT.*/$$LAST_RUN_DT='$last_run_dt'/g' $param_dir/$param_file > $tgt_dir/dt.tmp && mv $tgt_dir/dt.tmp $param_dir/$param_file
sed 's/.*'$last_dt'.*/'$last_dt'='$last_run_dt'/g' $param_dir/$param_file > $tgt_dir/dt.tmp && mv $tgt_dir/dt.tmp $param_dir/$param_file
sed 's/.*'$next_dt'.*/'$next_dt'='$next_run_dt'/g' $param_dir/$param_file > $tgt_dir/dt.tmp && mv $tgt_dir/dt.tmp $param_dir/$param_file
#sed 's/.*'$last_dt'.*/'$last_dt'='$curr_dt'/g' $param_dir/$param_file > $tgt_dir/dt.tmp && mv $tgt_dir/dt.tmp $param_dir/$param_file

echo "========================================================================================================="  >> $lg_fl

#========================================================================================================
#Removing the older log files
#========================================================================================================
cd $tgt_dir
find . -mtime +5 -name "sap*.log" -exec rm -f {} \; 2>/dev/null
echo 'Execution Ends' >> $lg_fl
chmod 777 $param_dir/$param_file