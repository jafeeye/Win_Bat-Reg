@echo off

net session
if %ERRORLEVEL% GTR 0  (
cls
echo "�Э���bat�A�k��y�H�t�κ޲z����������z"
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
echo 1 - "�w��"
echo 2 - "���}"

set /P var="Please select a numaber : "
if %var% == 1 goto :install_all
if %var% == 2 goto :dev_exit


:install_all

::�R���u�@�Ƶ{������
::1.�ۮe�ʻ���
schtasks /delete /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /F

::2.Microsoft �Ȥ�g���i�p�e
schtasks /delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /F
schtasks /delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /F

::���Φh�l�A��
::Connected User Experiences and Telemetry Service
sc stop "DiagTrack" && sc config "DiagTrack" start= disabled

::���Ψt���٭�
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v DisableSR /t reg_dword /d 00000001 /F
schtasks /delete /TN "\Microsoft\Windows\SystemRestore\SR" /F

pause

:dev_exit
exit