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
SET message=This program makes ssh port forwarding
ECHO %message%
ECHO.
ECHO Fazendo foward porta remota 8834 para localhost:4444
ECHO.
plink.exe 192.168.1.103 -P 22 -C -L 127.0.0.1:4444:192.168.1.103:8834 -l root -pw MySecretPass
