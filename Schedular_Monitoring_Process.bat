@ECHO OFF
REM ##################################################################
REM #Script Name	:Schedular_Monitoring_Process.bat                                                                                              
REM #Description:	
REM					:This script is used to get failed jobs with 0x1 code and send alert on email.                                                                                                                                                                          
REM #Author       	:Shahid Khan                                                

REM #####################################################

REM call %BNR_SCH_ROOT%\BNR-SCH\Config\BNR_SCH_VAR.bat

REM ##### Delete old files  #################################

REM ######## Delete old files(Task_Details.txt and Task_Errors.txt) #########################################

del \\hbinsnbnrf01\BNR-DEV\BNR-SCH\COMMON\ScheduledTasksManagement\AutomatedScripts_TST1\Task_Details.txt
del \\hbinsnbnrf01\BNR-DEV\BNR-SCH\COMMON\ScheduledTasksManagement\AutomatedScripts_TST1\Task_Errors.txt


REM ############### Fetch all Enabled jobs Last Run Result with code in file Task_Details.txt  ######################################

SCHTASKS /QUERY /V /FO CSV|findstr "Ready Running"|findstr "RDCHUB BATCH APP"|findstr /V "Upload Piktor POD Tiff Delivery PRU AR SAR Alert" >\\hbinsnbnrf01\BNR-DEV\BNR-SCH\COMMON\ScheduledTasksManagement\AutomatedScripts_TST1\Task_details.txt


REM ############### Filter jobs Last Run Result with code in file Task_Errors.txt  ######################################

for /F "tokens=2,7 delims=," %%a in ( \\hbinsnbnrf01\BNR-DEV\BNR-SCH\COMMON\ScheduledTasksManagement\AutomatedScripts_TST1\Task_Details.txt ) DO ( echo %%a %%b )| if %%b == "1" ( echo %%a ) >>\\hbinsnbnrf01\BNR-DEV\BNR-SCH\COMMON\ScheduledTasksManagement\AutomatedScripts_TST1\Task_Errors.txt

REM ########################## Send Email to team for action  ##############################

pushd %~dp0

cscript SendMail.vbs