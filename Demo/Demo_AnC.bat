@Echo off

pushd "..\Src"
Set "Path=%Path%;%cd%;%cd%\Files"
popd

Call AnC FnProgressTest.bat PluginProgressTest.bat
pause