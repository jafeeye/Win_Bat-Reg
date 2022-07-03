@echo off

net session
if %ERRORLEVEL% GTR 0  (
cls
echo "請重啟bat，右鍵『以系統管理員身分執行』"
pause
exit
)
cls

echo *************************************
echo *                                   * 
echo *                                   * 
echo *   Windows 11 Opti Script          * 
echo *                                   * 
echo *                                   *
echo *                                   * 
echo *                                   * 
echo *   2022.07.03                      * 
echo *                                   * 
echo *************************************

:MENU
echo 1 - "安裝"
echo 2 - "離開"

set /P var="Please select a numaber : "
if %var% == 1 goto :install_all
if %var% == 2 goto :dev_exit


:install_all

::刪除工作排程器任務
::1.相容性遙測
schtasks /delete /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /F

::2.Microsoft 客戶經驗改進計畫
schtasks /delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /F
schtasks /delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /F

::停用多餘服務
::Connected User Experiences and Telemetry Service
sc stop "DiagTrack" && sc config "DiagTrack" start= disabled

::停用系統還原
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v DisableSR /t reg_dword /d 00000001 /F
schtasks /delete /TN "\Microsoft\Windows\SystemRestore\SR" /F

pause

:dev_exit
exit