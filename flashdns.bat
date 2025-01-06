@echo off
color 0A

echo ##########################
ipconfig /release
ipconfig /renew
ipconfig /flushdns
echo DNS cache has been flushed.
ipconfig | findstr /i "IPv4"
netstat -e

echo
echo ################################
echo Cleaning temporary directories...
del /q /f /s %TEMP%\*
del /q /f /s C:\Windows\Temp\*
echo Temporary directories have been cleaned.
echo
echo ################################
echo Deleting cookies...
:: For Internet Explorer
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
:: For Google Chrome
del /q /s /f "%LocalAppData%\Google\Chrome\User Data\Default\Cookies"
:: For Mozilla Firefox
del /q /s /f "%AppData%\Mozilla\Firefox\Profiles\*\cookies.sqlite"
echo Cookies have been deleted.
echo
echo ################################

echo Cleaning up temporary files...
del /s /f /q %temp%\*
rd /s /q %temp%
md %temp%

echo Cleaning up prefetch files...
del /s /f /q C:\Windows\Prefetch\*

echo Cleaning up recent files...
del /s /f /q %userprofile%\Recent\*

echo Cleaning up Windows Update cache...
del /s /f /q C:\Windows\SoftwareDistribution\Download\*

echo Cleaning up Recycle Bin...
rd /s /q C:\$Recycle.Bin

echo Cleaning up browser cache...
for /d %%x in ("%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*") do rd /s /q "%%x"
for /d %%x in ("%userprofile%\AppData\Local\Google\Chrome\User Data\Default\Cache\*") do rd /s /q "%%x"


echo Pinging google.co.il...
ping google.co.il
if %errorlevel%==0 (
    echo Network is up.
) else (
    echo Network is down.
)

start chrome "https://www.speedtest.net/"

echo Cleanup complete!

pause
