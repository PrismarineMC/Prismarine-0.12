@echo off
TITLE Time
cd /d %~dp0
netstat -o -n -a | findstr 0.0.0.0:19132>nul
if %ERRORLEVEL% equ 0 (
    echo Your server is running.
    goto :loop
) ELSE (
    echo Starting your Prismarine server.
    goto :StartIM
)


:loop
echo Checking if server is online...
PING 127.0.0.1 -n 10 >NUL


netstat -o -n -a | findstr 0.0:19132>nul
if %ERRORLEVEL% equ 0 (
    echo Server is running.
    goto :loop
) ELSE (
	taskkill /f /im php.exe
	taskkill /f /im mintty.exe
    echo Starting in 10 seconds...
    PING 127.0.0.1 -n 10 >NUL
    goto :StartIM
)


:StartIM
cd /d %~dp0
if exist bin\php\php.exe (
	set PHPRC=""
	set PHP_BINARY=bin\php\php.exe
) else (
	set PHP_BINARY=php
)

if exist Prismarine*.phar (
	set POCKETMINE_FILE=Prismarine*.phar
) else (
	if exist src (
		set POCKETMINE_FILE=src
	) else (
	    if exist src\pocketmine\PocketMine.php (
	        set POCKETMINE_FILE=src\pocketmine\PocketMine.php
		) else (
			if exist Genisys.phar (
				set POCKETMINE_FILE=Genisys.phar
			) else (
		        echo "[ERROR] Couldn't find a valid Prismarine installation."
				pause
		        exit 8
		    )
	    )
	)
)

if exist bin\mintty.exe (
	start "" bin\mintty.exe %PHP_BINARY% %POCKETMINE_FILE% --enable-ansi %*
) else (
	%PHP_BINARY% %POCKETMINE_FILE% %*
)
goto :loop
