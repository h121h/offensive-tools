Rem Copyright 2020 Marcos Azevedo (aka pylinux) : psylinux[at]gmail.com
Rem
Rem   Licensed under the Apache License, Version 2.0 (the "License");
Rem   you may not use this file except in compliance with the License.
Rem   You may obtain a copy of the License at
Rem
Rem       http://www.apache.org/licenses/LICENSE-2.0
Rem
Rem   Unless required by applicable law or agreed to in writing, software
Rem   distributed under the License is distributed on an "AS IS" BASIS,
Rem   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
Rem   See the License for the specific language governing permissions and
Rem   limitations under the License.

ECHO OFF
SET message=This program just disable UAC
ECHO %message%
ECHO.
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v "FilterAdministratorToken" /t REG_DWORD /d 0x00000001
CLS
ECHO.
ECHO "Your Windows 7 client will reboot in 15 seconds."
ECHO.
TIMEOUT 15
SHUTDOWN -t 0 -r
