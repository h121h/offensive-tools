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
SET message=This program define multiple routes
ECHO %message%
ECHO.
ECHO ================================
ECHO ###     EXCLUINDO ROTAS      ###
ECHO ================================
ROUTE DELETE 0.0.0.0 MASK 0.0.0.0 2> NUL
ROUTE DELETE 0.0.0.0 MASK 0.0.0.0 2> NUL
ROUTE DELETE 0.0.0.0 MASK 0.0.0.0 2> NUL
ECHO ROTAS EXCLUIDAS: OK
ECHO.
ECHO ================================
ECHO ### ADICIONANDO ROTAS PADRAO ###
ECHO ================================
ECHO ROTA PARA REDE WIFI X1X2X3
ROUTE ADD 0.0.0.0 MASK 0.0.0.0 192.168.0.1 METRIC 10
ECHO.
ECHO ROTA PARA REDE WIFI
ROUTE ADD 0.0.0.0 MASK 0.0.0.0 10.11.18.1 METRIC 20
ECHO.
ECHO ROTA PARA REDE LAN
ROUTE ADD 0.0.0.0 MASK 0.0.0.0 10.11.10.1 METRIC 80
ECHO.
ECHO ROTAS ADICIONAS COM SUCESSO
ECHO.
ECHO ================================
ECHO ###     INICIANDO TESTE      ###
ECHO ================================
timeout /t 3 /nobreak
TRACERT GOOGLE.COM
