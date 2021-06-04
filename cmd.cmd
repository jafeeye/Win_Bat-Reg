@echo off & setlocal
echo ===================進行系統優化======================
::停止更新
sc stop wuauserv && sc config wuauserv start= disabled
sc stop BITS && sc config BITS start= disabled
sc stop dosvc && sc config dosvc start= disabled
sc stop WaaSMedicSvc && sc config WaaSMedicSvc start= disabled
sc stop UsoSvc && sc config UsoSvc start= disabled

::停止 Windows Search，禁止後 SearchIndexer 和附屬的 SearchProtocolHost、SearchFilterHost 還是會跑出來
sc stop "wsearch" && sc config "wsearch" start= disabled
dism /online /disable-feature /featurename:WSearch

::停止 fetch
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t reg_dword /d 0 /F
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t reg_dword /d 0 /F
sc stop "sysmain" && sc config "sysmain" start= disabled

::停用多餘服務
::Connected User Experiences and Telemetry Service
sc stop "DiagTrack" && sc config "DiagTrack" start= disabled

::禁用 Diagnostics 診斷策略服務
:: Diagnostic Execution Service
sc stop diagsvc && sc config diagsvc start= disabled
:: Diagnostic Policy Service
sc stop DPS && sc config DPS start= disabled
:: Diagnostic Service Host
sc stop WdiServiceHost && sc config WdiServiceHost start= disabled
:: Diagnostic System Host
sc stop WdiSystemHost && sc config WdiSystemHost start= disabled

::停用磁碟重組
schtasks /Delete /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /F

::停用系統還原
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v DisableSR /t reg_dword /d 00000001 /F
schtasks /delete /TN "\Microsoft\Windows\SystemRestore\SR" /F

::刪除排程
schtasks /delete /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /F
schtasks /delete /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /F
schtasks /delete /TN "\Microsoft\Windows\Autochk\Proxy" /F
schtasks /delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /F
schtasks /delete /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /F
schtasks /delete /TN "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /F

::啟用傳統圖片檢視器

::移除 OneDrive
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

::停用 Autorun.inf

::停用 SmartScreen

::禁用 Windows Defender
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t reg_dword /d 00000001 /F

:: 停用 HomeGroup (1903後此功能被移除)

:: 停用註冊檔備份 (1803後此功能被移除)
:: HKLM\System\CurrentControlSet\Control\Session Manager\Configuration Manager\EnablePeriodicBackup

::停用休眠
powercfg.exe /hibernate off

::啟用 .Net 3.5
dism /online /enable-feature /featurename:NetFx3

::刪除暫存檔
del C:\REG\*.* /s /q /f
RD C:\REG
pause
exit
