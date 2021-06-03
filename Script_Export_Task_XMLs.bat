REH@ECHO OFF
REM ##################################################################
REM #Script Name	:Script_Export_Task_XMLs.bat                                                                                              
REM #Description:	
REM					:This script can be used to fetch XMSl of Task Schedular jobs.
                                                                                                                                                                       
REM #Author       	:Shahid Khan                                                
REM #Args Options   :
                                     
REM ###################################################################
ECHO ********************STARTED*******************>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
ECHO Process Started at time: %date:~10%%date:~4,2%%date:~7,2%>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
FOR /F "usebackq tokens=1,2 delims=," %%A IN (Task_List_ExportXMLs.txt) DO (
SCHTASKS /Query /TN %%A /XML>%%B.xml
)>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log 

ECHO ********************FINISHED*********************>>%1_Execution_Log_SINGLE_%date:~10%%date:~4,2%%date:~7,2%.log
