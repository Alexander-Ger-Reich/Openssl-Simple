mkdir %cd%\ausgabe
mkdir %cd%\ausgabe\Lib
mkdir %cd%\ausgabe\SSL
mkdir %cd%\ausgabe\Lib\x64
mkdir %cd%\ausgabe\Lib\x64\Debug
mkdir %cd%\ausgabe\Lib\x64\Release
mkdir %cd%\ausgabe\Lib\x32
mkdir %cd%\ausgabe\Lib\x32\Debug
mkdir %cd%\ausgabe\Lib\x32\Release
set location=%cd%
git clone https://github.com/openssl/openssl.git
cd openssl

@call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64 %*
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

@call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x86 %*
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
echo Fertig
