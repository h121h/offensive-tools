#!/bin/bash
#
# Copyright 2020 Marcos Azevedo (aka pylinux) : psylinux[at]gmail.com
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

echo -e "============================================================";
echo    "############################################################";
echo    "#SCRIPT PARA DESABILITAR BLOQUEIOS E MONITORAMENTO DO CSIRT#";
echo    "############################################################";
echo -e "============================================================";
echo " "
echo "------------> Desabilita SEP"
echo " "
sudo launchctl stop /Library/LaunchDaemons/com.symantec.*
sudo launchctl stop /Library/LaunchAgents/com.symantec.*
sudo launchctl unload /Library/LaunchAgents/com.symantec.*
sudo launchctl unload /Library/LaunchDaemons/com.symantec.*
echo " "
echo " "
echo "------------> Desabilita bloqueio de instalação de apps"
echo " "
sudo spctl --master-disable
echo " "
echo "------------> Desabilita SPLUNK FORWARDER"
echo " "
sudo launchctl stop /Library/LaunchDaemons/com.splunk.plist
sudo launchctl stop /Library/LaunchAgents/com.splunk.plist
sudo launchctl unload /Library/LaunchDaemons/com.splunk.plist
sudo launchctl unload /Library/LaunchAgents/com.splunk.plist
echo " "
echo " "
echo "------------> Desabilita CYLANCE"
echo " "
sudo launchctl stop /Library/LaunchAgents/com.cylancePROTECT.plist
sudo launchctl stop /Library/LaunchDaemons/com.cylance.agent_service.plist
sudo launchctl unload /Library/LaunchDaemons/com.cylance.agent_service.plist
sudo launchctl unload /Library/LaunchAgents/com.cylancePROTECT.plist
echo " "
echo " "
echo    "############################################################";
