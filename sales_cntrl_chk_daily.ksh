########################################################################
#   Name:  sales_cntrl_chk_daily.ksh
#   Date:  02/19/2009
# Author:  Surendra Kotte
#   Desc:  Used to generate text files from sls_cntrl_chk table with ready_to_go_stat='N'.
#          Send email to IT support & CTC Informatica support if the sales batches are less than 24 hrs old and 
#          send email to CTC Informatica support if the sales batches are older than 24 hrs old
#          This script can be run from the UC4.  
#
#  Usage:  sales_cntrl_chk_daily.ksh 
#
#  Maintenance Log
#  Date       Who              Description
#  --------   ---------------- -----------------------------------------------------------------------
#  02/19/2009 Surendra         Original creation
#  03/03/2009 S Anderson       Modified selects--adding '' for batch_nbr to avoid losing 0's
#  03/05/2009 S Anderson       Added 'and READY_TO_GO_OVRD_STAT = 'N'' to queries
#
###################################################################################################

###################################################################################################
# Set path for execution
###################################################################################################

# Profile setup not required in production environment
# cd /home/db2as/sqllib
# . db2profile

echo "Creating list of failed sales loads"

DATE=`date +"%Y%m%d_%H%M%S"`
DATE_1=`date +"%Y/%m/%d"`

########################################################################
# Connect to CTCMSTRP database
########################################################################

db2 -x  connect to CTCMSTRP user sipctc using Ecolab2006;

########################################################################
# Query CTCMSTRP to check sales batches have failed, if any 
########################################################################


stmt_1="select LTRIM(RTRIM(src_sys)) concat',''' concat LTRIM(RTRIM(batch_nbr)) concat ''',' concat LTRIM(RTRIM(CHAR(exp_load_cnt))) concat ',' concat LTRIM(RTRIM(char(exp_sls_amt))) concat ',' concat LTRIM(RTRIM(CHAR(load_end_cnt))) concat ',' concat LTRIM(RTRIM(char(load_end_amt)))  concat ',' concat LTRIM(RTRIM(char(cre_dttm))) concat ',' concat LTRIM(RTRIM(CHAR(MOD_DTTM))) from ctcmsds.sls_cntrl_chk where ready_to_go_stat='N' and READY_TO_GO_OVRD_STAT = 'N' and mod_dttm>(current_timestamp-24 hour) and exp_load_cnt is not null"

stmt_2="select LTRIM(RTRIM(src_sys)) concat',''' concat LTRIM(RTRIM(batch_nbr)) concat ''',' concat LTRIM(RTRIM(CHAR(exp_load_cnt))) concat ',' concat LTRIM(RTRIM(char(exp_sls_amt))) concat ',' concat LTRIM(RTRIM(CHAR(load_end_cnt))) concat ',' concat LTRIM(RTRIM(char(load_end_amt)))  concat ',' concat LTRIM(RTRIM(char(cre_dttm))) concat ',' concat LTRIM(RTRIM(CHAR(MOD_DTTM))) from ctcmsds.sls_cntrl_chk where ready_to_go_stat='N' and READY_TO_GO_OVRD_STAT = 'N' and mod_dttm<(current_timestamp-24 hour) and exp_load_cnt is not null"

db2 -x "$stmt_1" > /usr/local/bin/informatica/TgtFiles/CTC_Sales_failed_loads.csv

db2 -x "$stmt_2">/usr/local/bin/informatica/TgtFiles/CTC_sales_failed_loads_24hrs_or_more.csv

count_1="`wc -l /usr/local/bin/informatica/TgtFiles/CTC_Sales_failed_loads.csv | awk '{print $1}'`"

count_2="`wc -l /usr/local/bin/informatica/TgtFiles/CTC_sales_failed_loads_24hrs_or_more.csv | awk '{print $1}'`"

echo " count_1 " $count_1
echo " count_2 " $count_2

echo "SOURCE_SYSTEM,BATCH_NUMBER,EXP_LOAD_CNT,EXP_SLS_AMT,LOAD_END_CNT,LOAD_END_AMT,CRE_DTTM,MOD_DTTM " > /usr/local/bin/informatica/TgtFiles/header.csv
#echo "\r">>/usr/local/bin/informatica/TgtFiles/header.csv
cat '/usr/local/bin/informatica/TgtFiles/header.csv' '/usr/local/bin/informatica/TgtFiles/CTC_Sales_failed_loads.csv' >/usr/local/bin/informatica/TgtFiles/CTC_Sales_failed_loads_$DATE.csv
cat '/usr/local/bin/informatica/TgtFiles/header.csv' '/usr/local/bin/informatica/TgtFiles/CTC_sales_failed_loads_24hrs_or_more.csv' >/usr/local/bin/informatica/TgtFiles/CTC_sales_failed_loads_24hrs_or_more_$DATE.csv

###############################################################################################
# Send email to IT support and CTC informatica support for sales batches less than 24 hours old 
###############################################################################################

SUBJECT_1="Please Create Remedy Case"
BODY_1="\n\nTHIS MESSAGE IS GENERATED AUTOMATICALLY.  Please don't reply to this message.  \n"*****************************************************************************"\n\n\nCreate a Case; assign to CTC Informatica Support (Low Priority) with the following title: CTC Sales Load Batch Failure on $DATE_1; $count_1 batches failed.  Include attached text file, named CTC_Sales_failed_loads_$DATE.csv.  "
email_1="servicedesk@ecolab.com"
email_2="ctcinformatica@ecolab.com"
if [ ${count_1} -gt 0 ] ; then
(echo "${BODY_1}" ; uuencode /usr/local/bin/informatica/TgtFiles/CTC_Sales_failed_loads_$DATE.csv CTC_Sales_failed_loads_$DATE.csv ) | mailx -s "$SUBJECT_1" "$email_1" 
(echo "${BODY_1}" ; uuencode /usr/local/bin/informatica/TgtFiles/CTC_Sales_failed_loads_$DATE.csv CTC_Sales_failed_loads_$DATE.csv ) | mailx -s "$SUBJECT_1" "$email_2"
fi 

#############################################################################
# Send email to CTC informatica support for sales batches older than 24 hours
#############################################################################

SUBJECT_2="CTC Sales Load Batch Failure on $DATE_1 ; $count_2 batches failed"
BODY_2="\n\nTHIS MESSAGE IS GENERATED AUTOMATICALLY.  Please don't reply to this message.  \n"*****************************************************************************"\n\n\n$count_2 CTC sales batches failed.  Please refer to attached text file, named 'CTC_sales_failed_loads_24hrs_or_more_$DATE.csv' for details.  "
if [ ${count_2} -gt 0 ]; then 
echo "${email_2}"
(echo "${BODY_2}" ; uuencode /usr/local/bin/informatica/TgtFiles/CTC_sales_failed_loads_24hrs_or_more_$DATE.csv CTC_sales_failed_loads_24hrs_or_more_$DATE.csv ) | mailx -s "$SUBJECT_2" "$email_2"
fi 

rm -rf /usr/local/bin/informatica/TgtFiles/header.csv /usr/local/bin/informatica/TgtFiles/CTC_sales_failed_loads_24hrs_or_more_$DATE.csv /usr/local/bin/informatica/TgtFiles/CTC_Sales_failed_loads_$DATE.csv
