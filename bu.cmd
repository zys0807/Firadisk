@echo off
title Build Firadisk
if not exist "%~dp0..\src\" (
  echo Error: No src directory.  
  echo Please place %~nx0 and source files in src directory.
  pause
  goto :eof
)
setlocal
if "%DDKDIR%"=="" for %%A in (C D E F) do if exist %%A:\WinDDK\7600.16385.1\ set DDKDIR=%%A:\WinDDK\7600.16385.1\
if "%pfxfile%"=="" set pfxfile=..\..\testsign\testpb.pfx
if ""=="%password%" set /p password=Enter signing publisher password : 

:loop
cls
cd /d %~dp0..
for %%I in (chk chk\amd64 bin bin\amd64) do if not exist %%I\ mkdir %%I

setlocal
call %DDKDIR%bin\setenv.bat %DDKDIR% chk x86 wxp
cd /d "%~dp0"
if not exist obj%BUILD_ALT_DIR% mkdir obj%BUILD_ALT_DIR%
build /w /jpath obj%BUILD_ALT_DIR%
endlocal
if errorlevel 1 goto :error

setlocal
call %DDKDIR%bin\setenv.bat %DDKDIR% chk x64 wnet
cd /d "%~dp0"
if not exist obj%BUILD_ALT_DIR% mkdir obj%BUILD_ALT_DIR%
build /w /jpath obj%BUILD_ALT_DIR%
endlocal
if errorlevel 1 goto :error

setlocal
call %DDKDIR%bin\setenv.bat %DDKDIR% fre x86 wxp
cd /d "%~dp0"
if not exist obj%BUILD_ALT_DIR% mkdir obj%BUILD_ALT_DIR%
build /w /jpath obj%BUILD_ALT_DIR%
endlocal
if errorlevel 1 goto :error

setlocal
call %DDKDIR%bin\setenv.bat %DDKDIR% fre x64 wnet
cd /d "%~dp0"
if not exist obj%BUILD_ALT_DIR% mkdir obj%BUILD_ALT_DIR%
build /w /jpath obj%BUILD_ALT_DIR%
endlocal
if errorlevel 1 goto :error

title Build Firadisk
cd /d "%~dp0.."
>nul copy src\objchk_wxp_x86\i386\firadisk.sys chk\firadisk.sys
>nul copy src\objfre_wxp_x86\i386\firadisk.sys bin\firadisk.sys
>nul copy src\objchk_wnet_amd64\amd64\firadisk.sys chk\firadi64.sys
>nul copy src\objfre_wnet_amd64\amd64\firadisk.sys bin\firadi64.sys
>nul copy src\firadisk.inf chk\firadisk.inf
>nul copy src\firadisk.inf bin\firadisk.inf

setlocal
PATH=%PATH%;%DDKDIR%bin\SelfSign;%DDKDIR%bin\x86

echo.
cd /d "%~dp0..\chk"
makecat -v ..\src\firadisk.cdf
makecat -v ..\src\firadi64.cdf
cd /d "%~dp0..\bin"
makecat -v ..\src\firadisk.cdf
makecat -v ..\src\firadi64.cdf
cd /d "%~dp0.."
if not exist "%pfxfile%" goto :nopfx
signtool sign /f "%pfxfile%" /p %password% /v chk\firadisk.sys chk\firadi64.sys chk\firadisk.cat chk\firadi64.cat bin\firadisk.sys bin\firadi64.sys bin\firadisk.cat bin\firadi64.cat 
if errorlevel 1 goto :error
:nopfx

cd /d "%~dp0.."
>nul copy src\txtsetup.oem chk\txtsetup.oem
>nul copy src\txtset64.oem chk\amd64\txtsetup.oem
>nul copy chk\firadisk.inf chk\amd64\firadisk.inf 
>nul copy chk\firadi64.cat chk\amd64\firadi64.cat 
>nul copy chk\firadi64.sys chk\amd64\firadi64.sys 
>nul copy src\txtsetup.oem bin\txtsetup.oem
>nul copy src\txtset64.oem bin\amd64\txtsetup.oem
>nul copy bin\firadisk.inf bin\amd64\firadisk.inf 
>nul copy bin\firadi64.cat bin\amd64\firadi64.cat 
>nul copy bin\firadi64.sys bin\amd64\firadi64.sys 

endlocal
goto :continue

:error
echo Error.

:continue
echo.
set /p loop=Build again ? [y/n] 
if "y"=="%loop%" goto :loop
endlocal
