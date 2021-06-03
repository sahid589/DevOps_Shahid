@ECHO OFF
REM ##################################################################
REM #Script Name	:Tasks_Action_Script_SINGLE.bat                                                                                              
REM #Description:	
REM					:This script can be used to check status of Task Schedular jobs.
REM					:This script can be used to END Running Task Schedular jobs.
REM					:This script can be used to Disable Task Schedular jobs.
REM					:This script can be used to Enable Task Schedular jobs.                                                                                                                                                                          
REM #Author       	:Shahid Khan                                                
REM #Args Options   :
REM #				QUERY .. (For Check tasks status).
REM #				END .. 	(For kill the tasks).
REM #				DISABLE .. (For Disable the tasks).
REM #				ENABLE .. (For Enable the tasks).                                           
REM ###################################################################
ECHO ********************STARTED*******************>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO Process Started at time: %date:~10%%date:~4,2%%date:~7,2%>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log

ECHO .. >>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO ********* Required parameter passed? **********>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
IF [%1]==[] (
GOTO sub_message
)
GOTO eof
:sub_message
ECHO "You forgot to pass parameter like QUERY or END or DISABLE or ENABLE etc.">>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
exit /B 1
:eof >>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO ********* Yes, Patameter: %1 passed ******>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO .. >>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log


ECHO .. >>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO ************Script Action will start from here as per Args Options**********>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO .. >>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log

IF "%1" == "QUERY" (
ECHO *********** Getting status of following tasks ******>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
FOR /F "usebackq tokens=*" %%f IN (Job_List.txt) DO (
SCHTASKS /QUERY /TN %%f
)>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log )


IF "%1" == "END" (
ECHO *********** Kill the following Running tasks ******>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
FOR /F "usebackq tokens=*" %%f IN (Job_List.txt) DO (
SCHTASKS /%1 /TN %%f
REM FOR /F "usebackq delims==" %%i IN (`SCHTASKS /QUERY /FO CSV^|findstr "Running"^|findstr "BNR"^|find "\" /c`) do set output=%%i >NUL
REM IF %output% EQU 0 ( exit /B 1 )
)>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log )


IF "%1" == "DISABLE" ( FOR /F "usebackq tokens=*" %%f IN (Job_List.txt) DO (
SCHTASKS /Change /TN %%f /DISABLE
)>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log )


IF "%1" == "ENABLE" ( FOR /F "usebackq tokens=*" %%f IN (Job_List.txt) DO (
SCHTASKS /Change /TN %%f /ENABLE
)>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log )

ECHO ********************FINISHED*********************>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log