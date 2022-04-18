@Echo off
Setlocal EnableDelayedExpansion

REM THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY
REM KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
REM WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
REM AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
REM HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
REM WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
REM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
REM DEALINGS IN THE SOFTWARE.

REM This program is free software: you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation, either version 3 of the License, or
REM (at your option) any later version. 
REM see www.gnu.org/licenses


REM ================= ABOUT THE PROGRAM =================
REM This program is Created by Kvc at 'Fri 10/22/2021 - 17:43'
REM This program can Compare the execution time of two or more files on the
REM Same system, for their speed of execution comparison.
REM For More Visit: www.batch-man.com


REM Setting version information...
Set _ver=20211022


REM Checking for various parameters of the function...
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "-help" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "ver" (Echo.%_ver%&Goto :End)
If /i "%~1" == "" (goto :help)

If /i "%~2" == "" (goto :help)

REM Saving parameters to variables...
Set _1=%~1
Set _2=%~2
Set _3=%~3
Set _4=%~4
Set _5=%~5
Set _6=%~6
Set _7=%~7
Set _8=%~8
Set _9=%~9

REM Starting Main Program...
:Main
IF NOT EXIST "!_1!" (Echo. FILE-1 NOT FOUND! && GOTO :End)
IF NOT EXIST "!_2!" (Echo. FILE-2 NOT FOUND! && GOTO :End)

REM Measuring the Runtime of File-1 & 2 (one by one)...
Set _Repetition=3
Set _FilesToCompare=0

For /L %%A in (1,1,9) do (If /I "!_%%A!" NEQ "" (Set /A _FilesToCompare+=1))

For /L %%A in (1,1,!_FilesToCompare!) do (Set _File_%%A_Avg_Time=0)

For /L %%g in (1,1,!_FilesToCompare!) do (
Echo.
For /L %%a in (1,1,!_Repetition!) do (
	gEcho "<Gn>File - %%g : <B>Test - <DY>%%a<w>/<B>!_Repetition!</>"
    for /f "skip=12 tokens=1,2* delims=:" %%A in ('powershell measure-command {./^"!_%%g!^"}') do (
	if %%A NEQ "" (
        FOR /f "tokens=1,2* delims=." %%X in ("%%B") do (
            Set _Before_Decimal=%%X
            Set _After_Decimal=%%Y

            IF "!_After_Decimal:~0,1!" GEQ "5" (Set /A _Before_Decimal+=1)
            Set /A _File_%%g_Avg_Time+=!_Before_Decimal!
            REM Echo. !_Before_Decimal!
            )
        )
    )
)
)
Echo ===================================================
Set _Fastest_File_execution_time=60000
Set _Fastest_File_name=
Set _Slowest_File_execution_time=0
Set _Slowest_File_name=
For /L %%A in (1,1,!_FilesToCompare!) do (
    Set /A _File_%%A_Avg_Time/=!_Repetition!
    If !_File_%%A_Avg_Time! GTR !_Slowest_File_execution_time! (
        Set _Slowest_File_execution_time=!_File_%%A_Avg_Time!
        Set _Slowest_File_name=!_%%A!
        )
    If !_File_%%A_Avg_Time! LSS !_Fastest_File_execution_time! (
        Set _Fastest_File_execution_time=!_File_%%A_Avg_Time!
        Set _Fastest_File_name=!_%%A!
        )
    gEcho "<Gn>File - %%A <B>[!_%%A:~-20!]		: <Y>!_File_%%A_Avg_Time!<w> ms</>"
    )

Echo. ===================================================
gEcho "<w>Fastest Execution Time : <B>!_Fastest_File_execution_time!<w> ms</>"
gEcho "<w>Fastest File Name : <Gn>!_Fastest_File_name!</>"
gEcho "<w>Slowest Execution Time : <B>!_Slowest_File_execution_time!<w> ms</>"
gEcho "<w>Slowest File Name : <R>!_Slowest_File_name!</>"
Echo. ===================================================
Echo.
Set /A _Speed_Difference=!_Slowest_File_execution_time!/!_Fastest_File_execution_time!
gEcho "The Faster file is <Gn>!_Speed_Difference!x</> times <B>faster</> than the <R>slower</> file."
Echo.
Goto :End


:End
Goto :EOF

:Help
Echo.
Echo. This function will Compare the execution time of two or more files on the
Echo. Same system, for their speed of execution comparison.
echo. It will help in understanding "execution speed" comparison of different Files.
Echo. CREDITS: AnC %_ver% by Kvc
echo.
echo. Syntax: Call AnC [FilePath1] [FilePath2] [FilePath3] [...]
echo. Syntax: call AnC [help , /? , -h , -help]
echo. Syntax: call AnC ver
echo.
echo. Where:-
echo.
echo. ver		    : Displays version of program
echo. help		    : Displays help for the program
echo. FilePath1		: Path of File1
Echo. FilePath2		: Path of File2
Echo. FilePath3		: Path of File3
Echo. ...   		: More Files
Echo.
Echo. Example: Call AnC "Button-1-Test.bat" "D:\Button-2-Test.bat"
Echo. Example: Call AnC ver
Echo. Example: Call AnC [/? , -h , -help , help]
Echo.
Echo. Now, you can Enjoy Properly created comparison reports of the execution
Echo. Speed of two files.
Echo.
Echo. PLUGIN REQUIRED FOR THIS PROJECT...
Echo. Powershell        by Microsoft
Echo. gEcho             by Groophy
Echo.
Echo. www.batch-man.com
Echo. #batch-man
Goto :End

