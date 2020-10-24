@ECHO OFF

SET cartelle=Clienti Progetti

SET remota="T:"
SET locale=%userprofile%\desktop
SET mese=%DATE:~6,4%-%DATE:~3,2%
SET opzioni=/Z /E /R:2 /W:15 /TBD /TEE /LOG+:%tmp%\%username%_sync_%mese%.log

(FOR %%c IN (%cartelle%) DO ( 
	REM carica da "locale" a "remota" i file creati negli ultimi 7 giorni (se "locale" esiste)
	IF EXIST %locale%\%%c ROBOCOPY %locale%\%%c %remota%\%%c %opzioni% /MAXAGE:7 /XO /IPG:100
	REM se "remota" o "locale" non esistono, creali
	IF NOT EXIST %remota%\%%c MKDIR %remota%\%%c
	IF NOT EXIST %locale%\%%c MKDIR %locale%\%%c 
	REM scarica "remota" in "locale" + elimina su "locale" quello eliminato in "remota"
	ROBOCOPY %remota%\%%c %locale%\%%c %opzioni% /PURGE /IPG:50
))

REM riavvio il PC
SHUTDOWN /T 60 /R
