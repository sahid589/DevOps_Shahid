@ECHO OFF
REM ##################################################################
REM #Script Name	:ScriptAutoTasks_Setup.bat                                                                                              
REM #Description:	
REM					:This script is used to auto Task Schedular jobs setup using xmls..
                                                                                                                                                                       
REM #Author       	:Shahid Khan                                                
REM #Args Options   :
                                     
REM ###################################################################
ECHO ********************STARTED*******************>Execution_Log_%date:~10%%date:~4,2%%date:~7,2%.log
SET RUNUSER=%1
SET RUNPASSWORD=%2

ECHO ********* Required parameter passed Check Started:: **********>>Execution_Log_%date:~10%%date:~4,2%%date:~7,2%.log
IF "%RUNUSER%"=="" (	
GOTO sub_message
)
GOTO eof
:sub_message
ECHO You forgot to pass required parameters. Please run the script with following input parameters as: ScriptAutoTasks_Setup.bat bsg\username password>>Execution_Log_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO .>CON
ECHO Sorry..Looks like you forgot to pass correct parameters. Please run the script with following input parameters: ScriptAutoTasks_Setup.bat bsg\username password>CON
exit /B 1
:eof >>Execution_Log_%date:~10%%date:~4,2%%date:~7,2%.log

IF "%RUNPASSWORD%"=="" (	
GOTO sub_message
)
GOTO eof
:sub_message
ECHO You forgot to pass required parameters. Please run the script with following input parameters as: ScriptAutoTasks_Setup.bat bsg\username password>>Execution_Log_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO .>CON
ECHO Sorry..Looks like you forgot to pass correct parameters. Please run the script with following input parameters: ScriptAutoTasks_Setup.bat bsg\username password>CON
exit /B 1
:eof >>Execution_Log_%date:~10%%date:~4,2%%date:~7,2%.log

FOR /F "usebackq tokens=1,2,3 delims=," %%A IN (Task_List_JobSetup.txt) DO (
schtasks.exe /Create /XML %%A /tn %%B /RU %RUNUSER% /RP %RUNPASSWORD%
)>>Execution_Log_%date:~10%%date:~4,2%%date:~7,2%.log 

ECHO ********************FINISHED*********************>>Execution_Log_%date:~10%%date:~4,2%%date:~7,2%.log
