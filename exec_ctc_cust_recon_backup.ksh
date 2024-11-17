########################################################################
#   Name:  exec_ctc_cust_recon_backup.ksh
#   Date:  06/03/2009
# Author:  Blaine Barnhart
#   Desc:  Backup CTC today file for STP
#         
#
#  Usage:  exec_ctc_cust_recon_backup.ksh 
#
#
#  Maintenance Log
#  Date       Who       Description
#  --------   --------- -------------------------------------------------
#  06/03/2009 Blaine    Initial Creation
########################################################################

#==================================================================
# SUBROUTINE to CHECK for ERRORS
#  PARAMETERS
#        ERROR CODE
#        ERROR TEXT
#  IF ERROR CODE != 0 - EXIT PROGRAM
#==================================================================

check_for_errors() 
{ 
   if [ "$1" != "0" ] 
   then 
     echo "Error in $2"  >> $LF
     echo "Return Code = $1" >> $LF
     exit $1
   fi

}


#==================================================================
# MAIN PROGRAM
#==================================================================

set -x

#-------------------------------------------------------------------
# Establish "infaprod" environment.
#-------------------------------------------------------------------
export HOME="/usr/local/infaprod"

export ENV=$HOME/.kshrc
export PATH=$PATH:$HOME/bin:/usr/local/bin:/usr/local/infaprod

#-----------------------------------------------
# Define all local variables and script values
#-----------------------------------------------
SCRIPTNM=`basename ${0}`

#---------------------------------
# Informatica specific variables 
INFAIP="10.23.49.16:4002"

INFADIR="/usr/local/infaprod"

INFALOGDIR="/usr/local/infaprod/SessLogs/"

typeset -l INFALOGFNAME=${1}
INFASRCDIR="/usr/local/infaprod/SrcFiles"

DROPDIR="/home/infaftp"

TGTFILESDIR="/usr/local/infaprod/TgtFiles"

INFATJCLDIR="/home/infapjcl/"

TMPDIR="/tmp/"
LF="${INFATJCLDIR}${SCRIPTNM}.`date +%C%y%m`.log"
PAGE_DBA_PATH="/dba/script/page_dba.sh"

#-------------------------------------------------------------------
#-------------------------------------------------------------------
# If the log file doesn't exist, create it, and then make sure
# it's available to the db2admin group.
#-------------------------------------------------------------------
if [ ! -f $LF ]
then
  > $LF
  chmod 775 $LF > /dev/null
fi

#-------------------------------------------------------------------
# Log an audit record that the script was executed.
#-------------------------------------------------------------------
echo "  " | tee -ia $LF
echo "`date '+<%D %T>'`  Step 1 - Beginning of script ${SCRIPTNM}..." | tee -ia $LF
echo "                   System User   :   `whoami`" | tee -ia $LF
echo "                   Executing User:   $USERNAME " | tee -ia $LF
echo "                   Workflow Name :   $1 " | tee -ia $LF
echo "  " | tee -ia $LF


count_drop=0
count_process=0

cd $TGTFILESDIR

check_for_errors $? "Changing directory to Target Files."

DATE_EXT=`date +"%m%d%Y_%H%M%S"`

cp ctc_stp_today_file1.txt CTC_BACKUP/ctc_stp_today_file1.txt.$DATE_EXT
check_for_errors $? "Copying today file to backup."

cd CTC_BACKUP
check_for_errors $? "Changing directory to Backup directory."

gzip ctc_stp_today_file1.txt.$DATE_EXT
check_for_errors $? "Compressing the backup files."



exit 0
