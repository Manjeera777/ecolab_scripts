#!/usr/bin/sh

#########################################################
# session_failure_email.sh
#
# This script provides the functionality to send 
# email attaching latest session log to a 
# recipient via UNIX mailx utility.
#
# History Details:
# 16-OCT-23  Mani, Adepu    - Created this script

#########################################################

#-----------------Main Function Code to Implement Emailing ----------

SESSION_NAME=$1

TIME=$2

# Check the value of REPO and set it accordingly
if [ "$3" = "6n0GazvO1uviYLocrVLvy3" ]; then
    REPO="IDMC_DEV"
elif [ "$3" = "6n0GazvO1uviYLocr" ]; then
    REPO="IDMC_QA"
else
    # Default value if REPO doesn't match either condition
    REPO="Unknown"
fi

EMAIL=$4

LATEST_LOG=$(ls -t /infoa/apps/infaagent/apps/Data_Integration_Server/logs/"$SESSION_NAME"_*.log | head -1)

echo "Hi, 
Session $SESSION_NAME failed. 
Session Started at $TIME 
Repository Name: $REPO 
Regards,
ETL Team." | mailx -a "$LATEST_LOG" -s "Failed: $SESSION_NAME" "$EMAIL"