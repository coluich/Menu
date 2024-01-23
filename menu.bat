if not "%minimized%"=="" goto :minimized
set minimized=true
set stupid=0
start /min cmd /C "%~dpnx0"
goto :EOF
:minimized
@echo off
cls

if exist color.txt (
set /p colore=<color.txt
) else (
set colore=0a
)


powershell Start-Sleep -milliseconds 200
PowerShell.exe -window normal -command mode 80,30




:MENU
title Menu Utility Windows
cls
mode 100,27
color %colore%
echo.
echo.
echo                             ******* UTILITY WINDOWS *******
echo.
echo.
echo.
echo     A. Default menu color            J. Genera Chiavi                 S.
echo.
echo     B. Switch menu color             K. Cripta/Crea firma RSA         T.
echo.
echo     C. Got SAM+SYSTEM                L. Decripta/Verifica_firma RSA   U. Cambia Password Utente
echo.
echo     D. Fork Bomb                     M. Converte msg in Base64        V. Logout
echo.
echo     E. Add User Admin                N. Cripta\Decripta con AES       W. Sospendi il PC
echo.
echo     F. Enable ADMIN                  O.                               X. Ibernazione ON/OFF
echo.
echo     G. Admin secure                  P.                               Y. Riavvia
echo.
echo     H. Wifi Psw                      Q.                               Z. Spegni
echo.
echo     I. Got Admin                     R.
echo.
echo.
echo.

choice /c ABCDEFGHIJKLMNOPQRSTUVWXYZ /n /m "SELEZIONA DA ELENCO: "
cls
echo.
if %errorlevel%==1 goto A
if %errorlevel%==2 goto B
if %errorlevel%==3 goto C
if %errorlevel%==4 goto D
if %errorlevel%==5 goto E
if %errorlevel%==6 goto F
if %errorlevel%==7 goto G
if %errorlevel%==8 goto H
if %errorlevel%==9 goto I
if %errorlevel%==10 goto J
if %errorlevel%==11 goto K
if %errorlevel%==12 goto L
if %errorlevel%==13 goto M
if %errorlevel%==14 goto N
if %errorlevel%==15 goto O
if %errorlevel%==16 goto P
if %errorlevel%==17 goto Q
if %errorlevel%==18 goto R
if %errorlevel%==19 goto S
if %errorlevel%==20 goto T
if %errorlevel%==21 goto U
if %errorlevel%==22 goto V
if %errorlevel%==23 goto W
if %errorlevel%==24 goto X
if %errorlevel%==25 goto Y  
if %errorlevel%==26 goto Z

::###########################################################  A 

:A
cls
echo 0a >color.txt
set colore=0a
goto menu

::###########################################################  B

:B
cls
echo.
echo.
color /?|findstr "="
echo.
echo.
set col= 
set /p col="COLORE SFONDO/TESTO = "
if "%col%"==" " goto menu
set col1=%col:~0,1%
set col2=%col:~1,1%
if %col1%==%col2% (
echo.
echo NON PUOI METTERE SFONDO E SCRITTE DELLO STESSO COLORE
timeout /t 3 >nul
goto b
)

color %col% | findstr "="
if %errorlevel%==0 (
color %colore%
cls
goto b
)

cls
color %col%
echo.
echo.
color /?|findstr "="
echo.
echo.
choice /c YN /n /m "VAN BENE QUESTI COLORI? [YN]"
if %errorlevel%==1 goto ColorOk
if %errorlevel%==2 goto NoColor



:ColorOK
set colore=%col%
goto menu


:NoColor
color %colore%
goto b




::###########################################################  C

:C
cls
set /p choice=Directory: 
cd %choice%
mkdir %USERNAME%
cd %USERNAME%
powershell reg save HKLM\sam ./sam.save
powershell reg save HKLM\system ./system.save
pause
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu

::###########################################################  D

:D
echo :forchettabombastica>>fork.bat
echo start %0>>fork.bat
echo goto forchettabombastica>>fork.bat
start fork.bat
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu

::###########################################################  E

:E
set /p name=Name: 
set /p psw=Password: 
New-LocalUser -Name "%name%"
Set-LocalUser -Name "%name%" -Password (ConvertTo-SecureString -AsPlainText "%psw%" -Force)
set /p fgad=admin (Y/n): 
if %fgad%=="" Add-LocalGroupMember -Group "Administrators" -Member "%name%"
if %fgad%=="y" Add-LocalGroupMember -Group "Administrators" -Member "%name%"
if %fgad%=="n" Add-LocalGroupMember -Group "Administrators" -Member "%name%"
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" -Name "%name%" -Value 0 -PropertyType DWORD
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu

::###########################################################  F

:F
mode 38,11
cls
echo.     ENABLE/DISABLE ADMIN
echo.
echo.
echo        1. ENABLE ADMIN
echo.
echo        2. DISABLE ADMIN
echo.
echo.
choice /c 12 /n /m "ENABLE [1] DISABLE [2] "
echo.
if %errorlevel%==1 goto admin_ENABLE
if %errorlevel%==2 goto admin_DISABLE
:admin_ENABLE
net user administrator /active:no
cls
color af
echo.
echo.
echo.
echo.
echo.
echo         admin is Enabled
echo.
echo.
echo.
echo.
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu
:admin_DISABLE
net user administrator /active:no
cls
color c0
echo.
echo.
echo.
echo.
echo.
echo        admin is Disabled   
echo.
echo.
echo.
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu

::###########################################################  G

:G
mode 38,11
cls
echo.     ENABLE/DISABLE ADMIN SECURE
echo.
echo.
echo        Choose an number
echo.
echo        1   2   3   4   5
echo.
echo.
echo.
set /p arrlvl="-> " 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d %arrlvl% /f
cls
color af
echo.
echo.
echo.
echo.
echo.
echo    set admin on %arrlvl%
echo.
echo.
echo.
echo.
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu

::###########################################################  H

:H
mode 38,11
cls
echo H
echo.
set /p choice=Directory: 
cd %choice%
mkdir %USERNAME%
cd %USERNAME%
netsh wlan export profile key=clear
pause
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu

::###########################################################  I

:I
:administratoressimo
>nul 2>&1 "%systemroot%\system32\cacls.exe" "%systemroot%\system32\config\system"
If '%errorlevel%' neq '0' (Goto uacprompt) else (goto gotadmin)
:uacprompt
Echo set uac = createobject^("shell.application"^) > "%temp%\getadmin.vbs"
Echo uac.shellexecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
Exit /b
:gotadmin
If exist "%temp%\getadmin.vbs" (del "%temp%\getadmin.vbs")
echo.   Error: %errorlevel%
pause >nul
goto menu

::###########################################################  J

:J
echo J
echo.
choice /c ra /n /m "RSA or AES? [r/a]"
if %errorlevel%==1 goto errorlevel1
if %errorlevel%==2 goto errorlevel2



:errorlevel1
set /p chiave1=chiave privata: 
set /p chiave2=chiave pubblica: 
set /p lenght=Immettere lunghezza chiave: 
openssl genpkey -algorithm RSA -out %chiave1% -pkeyopt rsa_keygen_bits:%lenght%
openssl rsa -pubout -in %chiave1% -out %chiave2%
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu



:errorlevel2
set /p chiave_aes=chiave: 
set /p lenght=Immettere lunghezza chiave: 
openssl rand -hex %lenght% > %chiave_aes%
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu




echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu

::###########################################################  K

:K
echo K
echo.

:unem1
set /p msg=percorso msg: 
set /p scelta=Cripotgrafare o Firmare [c/f]: 
if %scelta%==c goto criptografare
if %scelta%==f goto firma
goto unem1


:firma
set /p chiave3=chiave privata: 
openssl dgst -sha256 -sign %chiave3% -out %msg%.sign %msg%
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu

:criptografare
set /p chiave3=chiave pubblica: 
openssl rsautl -encrypt -pubin -inkey %chiave3% -in %msg% -out %msg%.bin
set /p cass=vuoi convertirlo in base64 [s/N]? 
if %cass%==s ( 
    openssl base64 -in %msg%.bin -out %msg%_Base64.bin
    echo.   Error: %errorlevel%
    timeout /t 4 >nul
    goto menu
) else (
    echo.   Error: %errorlevel%
    timeout /t 4 >nul
    goto menu
)
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu
::###########################################################  L

:L
echo L
echo.

:unem1
set /p msg=percorso msg: 
set /p scelta=Decrittogafare o Verifica_firma [d/v]: 
if %scelta%==d goto decrittografare
if %scelta%==v goto verifica_firma
goto unem1




:decrittografare
set /p chiave4=chiave privata: 
openssl rsautl -decrypt -inkey %chiave4% -in %msg% -out %msg%.txt
goto stop

:verifica_firma
set /p chiave4=chiave pubblica: 
set /p sign_file=firma: 
openssl dgst -sha256 -verify %chiave4% -signature %sign_file% %msg%
:stop
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu

::###########################################################  M

:M
echo M
echo.

set /p scelta21=input: 
openssl base64 -in %scelta21% -out %scelta21%_Base64.pem

echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menu

::###########################################################  N 

:N
echo N
echo.

:unem2
set /p msg=percorso msg: 
set /p chiave4=chiave: 
set /p scelta=Cripotgrafare o Decriptografare [c/d]: 
if %scelta%==c goto criptografare2
if %scelta%==d goto decrittografare2
goto unem2


:decrittografare2
openssl enc -d -aes-256-cbc -in %msg% -out %msg%.txt -k %chiave4% -pbkdf2
goto stop3


:criptografare2
openssl enc -aes-256-cbc -salt -in %msg% -out %msg%.enc -k %chiave4% -pbkdf2
goto stop3


:stop3
echo.   Error: %errorlevel%
timeout /t 4 >nul
goto menuz

::###########################################################  O

:O
echo O
echo.
set /a stupid+=1
if %stupid%==1 echo this letter haven't any menu, chose another letter
if %stupid%==2 echo are you stupid?? CHOSE ANOTER LETTER WITCH HAVE A MENU!!!
if %stupid%==3 shutdown /f
pause >nul
goto menu

::###########################################################  P

:P
echo P
echo.
set /a stupid+=1
if %stupid%==1 echo this letter haven't any menu, chose another letter
if %stupid%==2 echo are you stupid?? CHOSE ANOTER LETTER WITCH HAVE A MENU!!!
if %stupid%==3 shutdown /f
pause >nul
goto menu

::###########################################################  Q

:Q
echo Q
echo.
set /a stupid+=1
if %stupid%==1 echo this letter haven't any menu, chose another letter
if %stupid%==2 echo are you stupid?? CHOSE ANOTER LETTER WITCH HAVE A MENU!!!
if %stupid%==3 shutdown /f
pause >nul
goto menu

::###########################################################  R

:R
echo R
echo.
set /a stupid+=1
if %stupid%==1 echo this letter haven't any menu, chose another letter
if %stupid%==2 echo are you stupid?? CHOSE ANOTER LETTER WITCH HAVE A MENU!!!
if %stupid%==3 shutdown /f
pause >nul
goto menu


::###########################################################  S

:S
echo S
echo.
set /a stupid+=1
if %stupid%==1 echo this letter haven't any menu, chose another letter
if %stupid%==2 echo are you stupid?? CHOSE ANOTER LETTER WITCH HAVE A MENU!!!
if %stupid%==3 shutdown /f
pause >nul
goto menu

::###########################################################  T

:T
echo T
echo.
set /a stupid+=1
if %stupid%==1 echo this letter haven't any menu, chose another letter
if %stupid%==2 echo are you stupid?? CHOSE ANOTER LETTER WITCH HAVE A MENU!!!
if %stupid%==3 shutdown /f
pause >nul
goto menu

::###########################################################  U

:U
:netuser
cls
echo.
echo LISTA UTENTI:
echo.
echo.
wmic useraccount get name|more +1
echo.
set /p  nameacc="NOME ACCOUNT = "
echo.
echo.
wmic useraccount get name|more +1|findstr /i /c:"%nameacc%" 1>nul
if %errorlevel%==1 echo Utente non trovato&timeout /t 3 >nul&goto netuser
cls
echo.
echo Cambia password a "%nameacc%"
echo.
echo.
net user %nameacc% *

timeout /t 4 >nul
goto menu

::###########################################################  V

:V
(
echo Set Shell = WScript.CreateObject^("WScript.Shell"^)
echo if MsgBox^("Disconnessione Account?", vbquestion ^+ vbyesno ^+ vbsystemmodal, "Menu Utility [Power LogOut]"^) ^= vbyes then
echo Shell.Run^("cmd.exe /c shutdown /l "^), 0, true
echo else
echo Shell.Run^("cmd.exe /c EXIT"^), 0, true
echo end if
)>LogOutPC.vbs.vbs
start LogOutPC.vbs 2>nul
goto menu

::###########################################################  W

:W
(
echo Set Shell = WScript.CreateObject^("WScript.Shell"^)
echo if MsgBox^("Sospendi PC?", vbquestion ^+ vbyesno ^+ vbsystemmodal, "Menu Utility [Sospendi PC]"^) ^= vbyes then
echo Shell.Run^("cmd.exe /c Rundll32.exe powrprof.dll,SetSuspendState"^), 0, true
echo else
echo Shell.Run^("cmd.exe /c EXIT"^), 0, true
echo end if
)>SospendiPC.vbs
start SospendiPC.vbs 2>nul
goto menu

::###########################################################  X

:X
mode 38,11
cls
echo.     ENABLE/DISABLE HIBERNATE
echo.
echo.
echo        1. ENABLE HIBERNATE
echo.
echo        2. DISABLE HIBERNATE
echo.
echo.
choice /c 12 /n /m "ENABLE [1] DISABLE [2] "
echo.
if %errorlevel%==1 goto hibernate_ENABLE
if %errorlevel%==2 goto hibernate_DISABLE
:hibernate_ENABLE
powercfg -hibernate on
cls
color af
echo.
echo.
echo.
echo.
echo.
echo         hibernation is Enabled
echo.
echo.
echo.
echo.
echo.
timeout /t 4 >nul
goto menu
:hibernate_DISABLE
powercfg -hibernate off
cls
color c0
echo.
echo.
echo.
echo.
echo.
echo        hibernation is Disabled
echo.
echo.
echo.
echo.
timeout /t 4 >nul
goto menu

::###########################################################  Y

:Y
(
echo Set Shell = WScript.CreateObject^("WScript.Shell"^)
echo if MsgBox^("Riavviare il PC?", vbquestion ^+ vbyesno ^+ vbsystemmodal, "Menu Utility [Reboot PC]"^) ^= vbyes then
echo Shell.Run^("cmd.exe /c shutdown /r /t 00"^), 0, true
echo else
echo Shell.Run^("cmd.exe /c EXIT"^), 0, true
echo end if
)>RebootPC.vbs
start RebootPC.vbs 2>nul
goto menu

::###########################################################  Z

:Z
(
echo Set Shell = WScript.CreateObject^("WScript.Shell"^)
echo if MsgBox^("Spegnere il PC?", vbquestion ^+ vbyesno ^+ vbsystemmodal, "Menu Utility [Power off]"^) ^= vbyes then
echo Shell.Run^("cmd.exe /c SHUTDOWN /P"^), 0, true
echo else
echo Shell.Run^("cmd.exe /c EXIT"^), 0, true
echo end if
)>PowerOFF.vbs
start PowerOFF.vbs 2>nul
goto menu
::###########################################################









:: 69