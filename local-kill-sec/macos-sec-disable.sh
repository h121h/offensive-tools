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

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Protection Control"
TITLE="Enable/Disable Protections"
MENU="Choose one of the following options:"

OPTIONS=(
    1 "Check Status"
    2 "Disable Protection"
    3 "Enable Protection"
    )

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
    1)
        echo -e "Checking Status"
        echo -e "\t System Integrity Protection:"
        echo -e "\t\t";csrutil status
        echo -e "\t Gatekeeper:"
        echo -e "\t\t";spctl --status
        ;;
    2)
        echo -e "Disabling Protections (Need to reboot)"
        echo -e "\t Disable - System Integrity Protection:"
        sudo csrutil disable
        echo -e "\t Disabling - Gatekeeper:"
        sudo spctl --master-disable
        ;;
    3)
        echo -e "Enabling Protections (Need to reboot)"
        echo -e "\t Enabling - System Integrity Protection:"
        sudo csrutil enable
        echo -e "\t Enabling - Gatekeeper:"
        sudo spctl --master-enable
        ;;
esac

