@echo off
cpan -i Text::Template
cpan -i Test::More
mkdir %cd%\ausgabe
mkdir %cd%\ausgabe\Lib
mkdir %cd%\ausgabe\DLL
mkdir %cd%\ausgabe\SSL
mkdir %cd%\ausgabe\Lib\x64
mkdir %cd%\ausgabe\Lib\x64\Debug
mkdir %cd%\ausgabe\Lib\x64\Release
mkdir %cd%\ausgabe\Lib\x32
mkdir %cd%\ausgabe\Lib\x32\Debug
mkdir %cd%\ausgabe\Lib\x32\Release
mkdir %cd%\ausgabe\DLL\x64
mkdir %cd%\ausgabe\DLL\x64\Debug
mkdir %cd%\ausgabe\DLL\x64\Release
mkdir %cd%\ausgabe\DLL\x32
mkdir %cd%\ausgabe\DLL\x32\Debug
mkdir %cd%\ausgabe\DLL\x32\Release
set location=%cd%
dir "C:\Program Files\Microsoft Visual Studio\2022\" /b > temp.txt
set /p vs_v=<temp.txt
del temp.txt
git clone https://github.com/openssl/openssl.git
cd openssl

@call "C:\Program Files\Microsoft Visual Studio\2022\"%vs_v%"\VC\Auxiliary\Build\vcvarsall.bat" x64 %*
perl Configure VC-WIN64A --prefix=%location%\ausgabe\Lib\x64\Release --openssldir=%location%\ausgabe\SSL no-shared
nmake
nmake test
nmake install_sw
nmake clean
perl Configure VC-WIN64A --debug --prefix=%location%\ausgabe\Lib\x64\Debug --openssldir=%location%\ausgabe\SSL no-shared
nmake
nmake test
nmake install_sw
nmake clean
perl Configure VC-WIN64A --prefix=%location%\ausgabe\DLL\x64\Release --openssldir=%location%\ausgabe\SSL
nmake test
nmake install_sw
nmake clean
perl Configure VC-WIN64A --debug --prefix=%location%\ausgabe\DLL\x64\Debug --openssldir=%location%\ausgabe\SSL
nmake test
nmake install_sw
nmake clean

@call "C:\Program Files\Microsoft Visual Studio\2022\"%vs_v%"\VC\Auxiliary\Build\vcvarsall.bat" x86 %*
perl Configure VC-WIN32 --prefix=%location%\ausgabe\Lib\x32\Release --openssldir=%location%\ausgabe\SSL no-shared
nmake
nmake test
nmake install_sw
nmake clean
perl Configure VC-WIN32 --debug --prefix=%location%\ausgabe\Lib\x32\Debug --openssldir=%location%\ausgabe\SSL no-shared
nmake
nmake test
nmake install_sw
nmake clean
perl Configure VC-WIN32 --prefix=%location%\ausgabe\DLL\x32\Release --openssldir=%location%\ausgabe\SSL
nmake test
nmake install_sw
nmake clean
perl Configure VC-WIN32 --debug --prefix=%location%\ausgabe\DLL\x32\Debug --openssldir=%location%\ausgabe\SSL
nmake test
nmake install_sw
nmake clean

echo Fertig
