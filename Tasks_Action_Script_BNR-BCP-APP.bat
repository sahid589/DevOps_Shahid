@ECHO OFF
REM ##################################################################
REM #Script Name	:Tasks_Action_Script_BNR_BCP_APP.bat                                                                                              
REM #Description:	
REM					:This script can be used to check status of Task Scheduler jobs.
REM					:This script can be used to END Running Task Scheduler jobs.
REM					:This script can be used to Disable Task Scheduler jobs.
REM					:This script can be used to Enable Task Scheduler jobs.                                                                                                                                                                          
REM #Author       	:Shahid Khan                                                
REM #Args Options   :
REM #				QUERY .. (For Check tasks status).
REM #				END .. 	(For kill the tasks).
REM #				DISABLE .. (For Disable the tasks).
REM #				ENABLE .. (For Enable the tasks).                                           
REM ###################################################################
ECHO ********************STARTED*******************>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO Process Started at time: %date:~10%%date:~4,2%%date:~7,2%>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log

ECHO .. >>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO ********* Required parameter passed? **********>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
IF [%1]==[] (
GOTO sub_message
)
GOTO eof
:sub_message
ECHO "You forgot to pass parameter like QUERY or END or DISABLE or ENABLE etc.">>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
exit /B 1
:eof >>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO ********* Yes, Patameter: %1 passed ******>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO .. >>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log

ECHO ******* Delete old file(Final_Task_List_BCP_APP.txt) if available*******************>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
FORFILES /m Final_Task_List_BCP_APP*.txt /c "cmd /c Del Final_Task_List_BCP_APP*.txt" /d -2 2> nul>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log


ECHO ***********Parse file(Task_List_BCP_APP.txt) to select Job path***********>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
IF "%1" == "QUERY" IF NOT EXIST "Final_Task_List_BCP_APP*.txt" (
SCHTASKS /QUERY /FO CSV|findstr "Ready Running"|findstr "BNR-BCP\BNR-APP">Task_List_BCP_APP.txt 2> nul
COPY %1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log+Task_List_BCP_APP.txt %1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log > nul
ECHO. 2>Final_Task_List_BCP_APP%date:~10%%date:~4,2%%date:~7,2%.txt
FOR /F "delims=," %%A IN (Task_List_BCP_APP.txt) DO ECHO %%A>>Final_Task_List_BCP_APP%date:~10%%date:~4,2%%date:~7,2%.txt 2> nul
)
ECHO *********Collect all Enabled(Running and Ready) state jobs**************>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
COPY %1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log+Final_Task_List_BCP_APP%date:~10%%date:~4,2%%date:~7,2%.txt %1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log >NUL
DEL Task_List_BCP_APP.txt>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log 2> nul


ECHO .. >>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO ************Script Action will start from here as per Args Options**********>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO .. >>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log

IF "%1" == "QUERY" (
ECHO *********** Getting status of following tasks ******>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
FOR /F "usebackq tokens=*" %%f IN (Final_Task_List_BCP_APP%date:~10%%date:~4,2%%date:~7,2%.txt) DO (
SCHTASKS /QUERY /TN %%f
)>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log )


IF "%1" == "END" (
ECHO *********** Kill the following Running tasks ******>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log
FOR /F "usebackq tokens=*" %%f IN (Final_Task_List_BCP_APP%date:~10%%date:~4,2%%date:~7,2%.txt) DO (
SCHTASKS /%1 /TN %%f
REM FOR /F "usebackq delims==" %%i IN (`SCHTASKS /QUERY /FO CSV^|findstr "Running"^|findstr "BNR-BCP\BNR-APP"|find "\" /c`) do set output=%%i >NUL
REM IF %output% EQU 0 ( exit /B 1 )
)>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log )


IF "%1" == "DISABLE" ( FOR /F "usebackq tokens=*" %%f IN (Final_Task_List_BCP_APP%date:~10%%date:~4,2%%date:~7,2%.txt) DO (
SCHTASKS /Change /TN %%f /DISABLE
)>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log )


IF "%1" == "ENABLE" ( FOR /F "usebackq tokens=*" %%f IN (Final_Task_List_BCP_APP%date:~10%%date:~4,2%%date:~7,2%.txt) DO (
SCHTASKS /Change /TN %%f /ENABLE
)>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log )

ECHO ********************FINISHED*********************>>%1_Execution_Log_BCP_APP_%date:~10%%date:~4,2%%date:~7,2%.log