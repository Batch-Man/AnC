@Echo off

Set "Path=%Path%;%cd%;%cd%\Files;%~dp0;%~dp0Files;%~dp0Src"
Pushd "%~dp0Files"
Call AnC FnProgressTest.bat PluginProgressTest.bat
Popd
pause
