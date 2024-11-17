########################################################################
#   Name:  missing_customers_report.ksh
#   Date:  08/27/2008
# Author:  Surendra Kotte
#   Desc:  Find missing customer accounts with no global customer id 
#         
#
#  Usage:  missing_customers_report.ksh 
#
#
#  Maintenance Log
#  Date       Who		Description
#  --------   ---------		-------------------------------------------------
#  08/27/2008 Surendra  	Initial Creation
#  03/31/2009 Barnhart	Added Summed EXTD_SLS_AMT column and GROUP BY.
########################################################################

#cd /home/db2as/sqllib
#. db2profile
#echo "Selecting Source Customer Account ID's with Null Global Customer ID for ECOSURE SOURCE SYSTEM"
db2 -x  connect to CTCMSTRP user sipctc using Ecolab2006;

echo "Selecting Source Customer Account ID's with Null Global Customer ID for ECO SOURCE SYSTEM"

stmt="SELECT SRC_SYS||','||SRC_SLS_DIV_CD||','||SRC_CUST_ACCT_ID||','||CHAR(SUM(EXTD_SLS_AMT))  
FROM CTCMSDS.ECO_SLS_LAND WHERE GLBL_CUST_ID IS NULL AND EXTD_SLS_AMT <> 0 
GROUP BY SRC_SYS, SRC_SLS_DIV_CD, SRC_CUST_ACCT_ID"
db2 -x "$stmt" >> /usr/local/infadev/SrcFiles/missing_customers_rollup.txt


echo "Selecting Source Customer Account ID's with Null Global Customer ID for PEST SOURCE SYSTEM"

stmt="SELECT SRC_SYS||','||SRC_SLS_DIV_CD||','||SRC_CUST_ACCT_ID||','||CHAR(SUM(EXTD_SLS_AMT))  
FROM CTCMSDS.PES_SLS_LAND WHERE GLBL_CUST_ID IS NULL AND EXTD_SLS_AMT <> 0 
GROUP BY SRC_SYS,SRC_SLS_DIV_CD, SRC_CUST_ACCT_ID"
db2 -x "$stmt" >> /usr/local/infadev/SrcFiles/missing_customers_rollup.txt


echo "Selecting Source Customer Account ID's with Null Global Customer ID for GCS SOURCE SYSTEM"

stmt="SELECT SRC_SYS||','||SRC_SLS_DIV_CD||','||SRC_CUST_ACCT_ID||','||CHAR(SUM(EXTD_SLS_AMT))  
FROM CTCMSDS.GCS_SLS_LAND WHERE GLBL_CUST_ID IS NULL AND EXTD_SLS_AMT <> 0  
GROUP BY SRC_SYS, SRC_SLS_DIV_CD, SRC_CUST_ACCT_ID"
db2 -x "$stmt" >> /usr/local/infadev/SrcFiles/missing_customers_rollup.txt


echo "Selecting Source Customer Account ID's with Null Global Customer ID for CAN SOURCE SYSTEM"

stmt="SELECT SRC_SYS||','||SRC_SLS_DIV_CD||','||SRC_CUST_ACCT_ID||','||CHAR(SUM(EXTD_SLS_AMT))  
FROM CTCMSDS.CAN_SLS_LAND WHERE GLBL_CUST_ID IS NULL AND EXTD_SLS_AMT <> 0  
GROUP BY SRC_SYS, SRC_SLS_DIV_CD, SRC_CUST_ACCT_ID"
db2 -x "$stmt" >> /usr/local/infadev/SrcFiles/missing_customers_rollup.txt


echo "Selecting Source Customer Account ID's with Null Global Customer ID for KAY SOURCE SYSTEM"

stmt="SELECT SRC_SYS||','||SRC_SLS_DIV_CD||','||SRC_CUST_ACCT_ID||','||CHAR(SUM(EXTD_SLS_AMT))  
FROM CTCMSDS.KAY_SLS_LAND WHERE GLBL_CUST_ID IS NULL AND EXTD_SLS_AMT <> 0 
GROUP BY SRC_SYS, SRC_SLS_DIV_CD, SRC_CUST_ACCT_ID"
db2 -x "$stmt" >> /usr/local/infadev/SrcFiles/missing_customers_rollup.txt


echo "Selecting Source Customer Account ID's with Null Global Customer ID for DDT SOURCE SYSTEM"

stmt="SELECT SRC_SYS||','||SRC_SLS_DIV_CD||','||SRC_CUST_ACCT_ID||','||CHAR(SUM(EXTD_SLS_AMT))  
FROM CTCMSDS.DDT_SLS_LAND WHERE GLBL_CUST_ID IS NULL AND EXTD_SLS_AMT <> 0  
GROUP BY SRC_SYS, SRC_SLS_DIV_CD, SRC_CUST_ACCT_ID"
db2 -x "$stmt" >> /usr/local/infadev/SrcFiles/missing_customers_rollup.txt


echo "Selecting Source Customer Account ID's with Null Global Customer ID for STP SOURCE SYSTEM"

stmt="SELECT SRC_SYS||','||SRC_SLS_DIV_CD||','||SRC_CUST_ACCT_ID||','||CHAR(SUM(EXTD_SLS_AMT))  
FROM CTCMSDS.STP_SLS_LAND WHERE GLBL_CUST_ID IS NULL AND EXTD_SLS_AMT <> 0  
GROUP BY SRC_SYS, SRC_SLS_DIV_CD, SRC_CUST_ACCT_ID"
db2 -x "$stmt" >> /usr/local/infadev/SrcFiles/missing_customers_rollup.txt

