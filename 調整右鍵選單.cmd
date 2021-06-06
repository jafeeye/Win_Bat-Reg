@echo off
::取消右鍵3D小畫家編輯(Edit With Paint3D)
reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpg\Shell\3D Edit" /F
reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit" /F
reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.png\Shell\3D Edit" /F
reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.bmp\Shell\3D Edit" /F
reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.gif\Shell\3D Edit" /F
reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tif\Shell\3D Edit" /F
reg DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tiff\Shell\3D Edit" /F

::取消Win10相片編輯(Edit With Photos)
reg add "HKEY_CLASSES_ROOT\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v ProgrammaticAccessOnly /t reg_sz /d "" /F

::取消 Acrobat Context Menu
cd /d C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat Elements
regsvr32.exe /u ContextMenuShim64.dll /s
regsvr32.exe /u ContextMenu64.dll /s
regsvr32.exe /u ContextMenu.dll /s
regsvr32.exe /u ContextMenu.dll /s

::取消圖片右鍵選單建立新影片
reg DELETE "HKEY_CLASSES_ROOT\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellCreateVideo" /F
reg DELETE "HKEY_CLASSES_ROOT\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\ShellCreateVideo" /F
pause
exit
