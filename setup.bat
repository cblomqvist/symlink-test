@echo off
REM ---------------------------------------------------------------------------
REM Creates the basic structure with symlinks
REM ---------------------------------------------------------------------------

call :cleanup
call :create_libs
call :create_global_script_link
call :create_units
echo "Done"
exit /B %ERRORLEVEL%

:cleanup
@echo === Cleaning up old stuff if any... ===
DEL /F/Q/S libs\*.*
rmdir /Q/S libs
rmdir /Q/S liblink
DEL /F/Q/S unit1\*.*
rmdir /Q/S unit1
DEL /F/Q/S unit2\*.*
rmdir /Q/S unit2
del global_script.bat
@echo === Clean up done! ===
exit /B 0

:create_libs
mkdir libs
mklink /D liblink libs
call :create_lib 1
call :create_lib 2
echo @echo script %%0 > libs\script.bat
echo @pause >> libs\script.bat
echo @echo global script %%0 > libs\global_script.bat
echo @pause >> libs\global_script.bat
exit /B 0

:create_lib
echo Creating libs\lib%1
mkdir libs\lib%1
echo @echo libfile%1 %%0 > libs\lib%1\libfile.bat
echo @pause >> libs\lib%1\libfile.bat
exit /B 0

:create_units
call :create_unit 1
call :create_unit 2
exit /B 0

:create_unit
echo Creating unit%1
mkdir unit%1
mkdir unit%1\app
echo Creating unit%1\app\appfile%1.bat
echo @echo app %1 %%0 > unit%1\app\appfile.bat
echo @pause >> unit%1\app\appfile.bat
mklink /D unit%1\lib ..\libs\lib%1
mklink unit%1\script.bat ..\libs\script.bat
exit /B 0

:create_global_script_link
mklink global_script.bat libs\global_script.bat
exit /B 0
