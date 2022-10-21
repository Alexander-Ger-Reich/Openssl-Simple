@echo off
set location=%cd%
dir "C:\Program Files\Microsoft Visual Studio\2022\" /b > temp.txt
set /p vs_v=<temp.txt
del temp.txt
@call "C:\Program Files\Microsoft Visual Studio\2022\"%vs_v%"\VC\Auxiliary\Build\vcvarsall.bat" x64 %*
C:\Windows\System32\bitsadmin.exe /transfer "nasm" /download /priority FOREGROUND https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/win64/nasm-2.14.02-installer-x64.exe "%location%\nasm-2.14.02-installer-x64.exe"
C:\Windows\System32\bitsadmin.exe /transfer "perl" /download /priority FOREGROUND https://strawberryperl.com/download/5.32.1.1/strawberry-perl-5.32.1.1-64bit.msi "%location%\strawberry-perl-5.32.1.1-64bit.msi"
"%location%\strawberry-perl-5.32.1.1-64bit.msi" /passive /norestart
"%location%\nasm-2.14.02-installer-x64.exe"
winget install --id Git.Git -e --source winget
del "%location%\strawberry-perl-5.32.1.1-64bit.msi"
del "%location%\nasm-2.14.02-installer-x64.exe"
powershell -command "Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value ((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path + ';C:\Program Files\NASM')"
set path=%path%+C:\Strawberry\c\bin;C:\Strawberry\perl\site\bin;C:\Strawberry\perl\bin;C:\Program Files\NASM;
cpan -i Text::Template
cpan -i Test::More
cmd
