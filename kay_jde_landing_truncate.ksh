########################################################################
#   Name:  kay_jde_landing_truncate.ksh
#   Date:  03/12/2009
# Author:  Mahendrakar Sridhar
#   Desc:  Used to truncate the siperian kay landing table if the kay file indicator exists
#
#  Usage:  kay_jde_landing_truncate.ksh 
#
#  Maintenance Log
#  Date       Who              Description
#  --------   ---------------- -----------------------------------------------------------------------
#  03/12/2009 Mahendrakar Sridhar         Original creation
###################################################################################################

###################################################################################################
# Set path for execution
###################################################################################################

# Profile setup not required in production environment
#cd /home/db2as/sqllib
#. db2profile

########################################################################
# Connect to CTCSIPP database
########################################################################

db2 -x  connect to CTCSIPP user sipctc using Ecolab2006;

########################################################################
# Query to truncate KAY customer and address table
########################################################################

stmt_1="DELETE FROM CMX_ORS.C_L_KAY_CUST"
stmt_2="DELETE FROM CMX_ORS.C_L_KAY_ADDR"
stmt_3="COMMIT"

db2 "$stmt_1" 

db2 "$stmt_2"

db2 "$stmt_3"
