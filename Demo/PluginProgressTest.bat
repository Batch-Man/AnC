@Echo off

CD Files >nul 2>nul

For /L %%A in (1,1,30) do (Progress.exe 77 %%A 30)
Goto :EOF