folderName=$1
workflowName=$2
Tasktype=$3
waitParam=$4


if [ "$waitParam" = "nowait" ]
then
        cd /u01/apps/informatica/downloads/package-runAJobCli.27/package
sh -x cli.sh runAJobCli -t $Tasktype -un $workflowName -fp $folderName -w nowait
if [ $? -ne 0 -a $? -ne 6 ]
then
exit 1;
fi

else
cd /u01/apps/informatica/downloads/package-runAJobCli.27/package
sh -x cli.sh runAJobCli -t $Tasktype -un $workflowName -fp $folderName
fi