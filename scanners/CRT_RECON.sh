#CRT_RECON
function crt-recon (){ 
  curl -s https://crt.sh/?q=%25."$1" | grep TD | grep "$1" | sed -e 's/<TD>//g' -e 's/<\/TD>//g' | egrep -v '(<TD class)' | sort -u }