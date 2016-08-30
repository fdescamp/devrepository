:::::::::::::::::::::::
:: BUILD BATCH FILE  ::
:::::::::::::::::::::::
::
:: PATH TO CACHE DIRECTORY AND EXECUTABLES
set CACHEDIR=C:\InterSystems\HS20164QA
set CACHEBIN=%CACHEDIR%\bin\cache
set CACHEINSTANCE=HS20164QA

:: Check build variables
IF NOT DEFINED WORKSPACE EXIT 1
IF NOT DEFINED JOB_NAME EXIT 1
set SRCDIR=%WORKSPACE%

:: PREPARE OUTPUT FILE
set OUTFILE=%CD%\outFile
del "%OUTFILE%"


:: NOW, PREPARE TO CALL CACHE
:: FIRST, LOAD BUILD CLASS TO USER NAMESPACE
echo set sc=$SYSTEM.OBJ.Load("%SRCDIR%\Tutorial\Util.Build.cls","ck") >inFile

:: IF UNSUCCESSFULL, DISPLAY ERROR
echo if sc'=1 do $SYSTEM.OBJ.DisplayError(sc) >>inFile

:: NOW, PERFORM BUILD
:: FD modified to add multiple namespace
:: Import everything in TUTORIAL namespace
set NAMESPACE=TUTORIAL
echo if sc=1 set sc=##class(Util.Build).Build("%JOB_NAME%","%SRCDIR%","%NAMESPACE%") >>inFile

:: IF UNSUCCESSFULL, DISPLAY ERROR
echo if sc'=1 do $SYSTEM.OBJ.DisplayError(sc) >>inFile

:: IF UNSUCCESSFULL, CREATE OUTPUT FLAG FILE
echo if sc'=1 set fileName="%OUTFILE%" o fileName:("NWS") u fileName do $SYSTEM.OBJ.DisplayError(sc) c fileName >>inFile

:: THAT'S IT
echo halt >>inFile

:: CALL CACHE

%CACHEBIN% -s %CACHEDIR%\mgr -U USER <inFile

:: TEST IF THERE WAS AN ERROR
IF EXIST "%OUTFILE%" EXIT 1
