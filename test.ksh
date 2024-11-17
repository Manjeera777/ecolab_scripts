#!/bin/ksh
#
############################################################################################
#
# Name : kna1_knvv_prm_upd.sh
# Author : Sonu Pal
# Date : 10/03/2022
# Description : script to update last load run date time in paramfile for each region
#
###########################################################################################

##Set Variable, LastLoadRun Datetime,Parameter file,Temporary Parameter file

dt_tm=20200927113327;
prm1=KNA1_KNVV_US10_CA10_10.prm;
prm2=KNA1_KNVV_US10_CA10_10.prm_tmp;

cd /usr/local/idmc/ParamFiles/FLDOPSFIN;

sed "s|\(.*LAST_RUN_DT_TM=\)\([0-9].*\)|\1$dt_tm|g" $prm1 > $prm2;

chmod 777 $prm2;
cp -f $prm2 $prm1;
rm $prm2;
