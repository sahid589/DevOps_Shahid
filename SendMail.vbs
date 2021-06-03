'Set objShell = WScript.CreateObject("WScript.Shell")
'objShell.Run("\\hbinsnbnrf01.bsg.ad.adp.com\bnr-dev\BNR-SCH\COMMON\ScheduledTasksManagement\AutomatedScripts_TST2\Schedular_Monitoring_Process.bat"), 0, True
 'msgbox "1"
  Set fso = CreateObject("Scripting.FileSystemObject")  
  'msgbox fso.GetFile("\\hbinsnbnrf01.bsg.ad.adp.com\bnr-dev\BNR-SCH\COMMON\ScheduledTasksManagement\AutomatedScripts_TST2\Task_Errors.txt").Size
    If fso.GetFile("\\hbinsnbnrf01.bsg.ad.adp.com\bnr-dev\BNR-SCH\COMMON\ScheduledTasksManagement\AutomatedScripts_TST2\Task_Errors.txt").Size > 0 Then
    Set OutApp = CreateObject("CDO.Message")
       Set cdoConf = CreateObject("CDO.Configuration")
       OutApp.From = "ANVR-DPTeam@broadridge.com"
       OutApp.To =    "ANVR-DPTeam@broadridge.com"		
       OutApp.Subject = "HBIPSWBNRT01: India task schedular job failure alert"
       OutApp.HTMLBody = " DP Team: Please look into the attached job(s) immediately and take corrective action !!"
       OutApp.AddAttachment "\\hbinsnbnrf01.bsg.ad.adp.com\bnr-dev\BNR-SCH\COMMON\ScheduledTasksManagement\AutomatedScripts_TST2\Task_Errors.txt"	
       Dim sch, X, MSMail, Priority, Importance
       sch = "http://schemas.microsoft.com/cdo/configuration/"
       cdoConf.Fields.Item(sch & "sendusing") = 2
       cdoConf.Fields.Item(sch & "smtpserver") = "bnriprodmailrelay.broadridge.net"
       cdoConf.Fields.Item(sch & "smtpserverport") = 25
       cdoConf.Fields.Item(sch & "smtpauthenticate") = 0
       cdoConf.Fields.Update
       Set OutApp.Configuration = cdoConf
       OutApp.Fields.Item("urn:schemas:mailheader:X-MSMail-Priority") = X - MSMail - Priority ' For Outlook 2003
       OutApp.Fields.Item("urn:schemas:mailheader:X-Priority") = Int(X - Priority) ' For Outlook 2003 also
       OutApp.Fields.Update
	   'msgbox "Send Start"
       OutApp.Send
       'msgbox "Send End"
      Set cdoConf = Nothing
    End If
    set fso= nothing