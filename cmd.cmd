@echo off & setlocal
echo ===================�i��t���u��======================
::�����s
sc stop wuauserv && sc config wuauserv start= disabled
sc stop BITS && sc config BITS start= disabled
sc stop dosvc && sc config dosvc start= disabled
sc stop WaaSMedicSvc && sc config WaaSMedicSvc start= disabled
sc stop UsoSvc && sc config UsoSvc start= disabled

::���� Windows Search�A�T��� SearchIndexer �M���ݪ� SearchProtocolHost�BSearchFilterHost �٬O�|�]�X��
sc stop "wsearch" && sc config "wsearch" start= disabled
dism /online /disable-feature /featurename:WSearch

::���� fetch
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t reg_dword /d 0 /F
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t reg_dword /d 0 /F
sc stop "sysmain" && sc config "sysmain" start= disabled

::���Φh�l�A��
::Connected User Experiences and Telemetry Service
sc stop "DiagTrack" && sc config "DiagTrack" start= disabled

::�T�� Diagnostics �E�_�����A��
:: Diagnostic Execution Service
sc stop diagsvc && sc config diagsvc start= disabled
:: Diagnostic Policy Service
sc stop DPS && sc config DPS start= disabled
:: Diagnostic Service Host
sc stop WdiServiceHost && sc config WdiServiceHost start= disabled
:: Diagnostic System Host
sc stop WdiSystemHost && sc config WdiSystemHost start= disabled

::���κϺЭ���
schtasks /Delete /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /F

::���Ψt���٭�
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v DisableSR /t reg_dword /d 00000001 /F
schtasks /delete /TN "\Microsoft\Windows\SystemRestore\SR" /F

::�R���Ƶ{
schtasks /delete /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /F
schtasks /delete /TN "\Microsoft\Windows\Autochk\Proxy" /F
schtasks /delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /F
schtasks /delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /F
schtasks /delete /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /F

::�ҥζǲιϤ��˵���

::���� OneDrive
taskkill /f /im OneDrive.exe
%SystemRoot%\System32\OneDriveSetup.exe /uninstall
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
rd "%UserProfile%\OneDrive" /s /q
rd "%LocalAppData%\Microsoft\OneDrive" /s /q
rd "%ProgramData%\Microsoft OneDrive" /s /q
rd "C:\OneDriveTemp" /s /q
del "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" /s /f /q
REG Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
REG Delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f

::���� Autorun.inf

::���� SmartScreen

::�T�� Windows Defender
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t reg_dword /d 00000001 /F

:: ���� HomeGroup (1903�ᦹ�\��Q����)

:: ���ε��U�ɳƥ� (1803�ᦹ�\��Q����)
:: HKLM\System\CurrentControlSet\Control\Session Manager\Configuration Manager\EnablePeriodicBackup

::���Υ�v
powercfg.exe /hibernate off

::�ҥ� .Net 3.5
dism /online /enable-feature /featurename:NetFx3

::�R���Ȧs��
del C:\REG\*.* /s /q /f
RD C:\REG
pause
exit
