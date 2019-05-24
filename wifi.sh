#!/bin/bash

#if [[ $EUID -ne 0 ]]; then
#   echo "Tento příkaz lze spustit pouze pod uživatelem root." 
#   exit 1
#fi

if [ -d ~/.cache/google-chrome ]; then
    # Will enter here if $DIRECTORY exists, even if it contains spaces
    echo Cache googlu smazána
	rm -R ~/.cache/google-chrome
fi

ver=`echo Verze skriptu 1.60`
echo -n Zadej lokalitu:
echo
read lok
DATE=`date +"%d.%m.%y"`
TIME=`date +"%H:%M:%S"`
IP=`curl ipinfo.io/ip`
mkdir ~/hazard/${lok}_${DATE}
loc=~/hazard/${lok}_${DATE}
mkdir $loc/screen/
obr=$loc/screen/
log=~/hazard/${lok}_${DATE}/${lok}.log
echo $ver > $log
echo Výpis ip adres připojeného bodu >> $log
ip addr >> $log
echo test CAPTIVE PORTÁLU:
echo test CAPTIVE PORTÁLU: >> $log
chromium-browser --no-sandbox --headless --disable-gpu --window-size=1800,900 --screenshot=$obr/captive.png http://neverssl.com
#firefox -new-tab -url http://neverssl.com
read -n 1 -s -r -p "Pro pokračování stisknětě libovolnou klávesu"
echo Zkouším dne $DATE v $TIME ping na adresu blokovaných stránek v $lok
echo Nejdříve si stáhu IP adresu a další stránky
echo Zkouším dne $DATE v $TIME ping na adresy blokovaných stránek v $lok >> $log
echo >> $log
echo Nejdříve si stáhu IP adresu a další stránky >> $log
wget -c mojeip.cz -a ${lok}_ip.log --no-check-certificate -t 3
echo 1/5
mv index.html $loc/${lok}_ip.html
cat ${lok}_ip.log >> $log
rm ${lok}_ip.log
wget -c 1xbet.com -a ${lok}_com.log --no-check-certificate -t 3
echo 2/5
mv index.html $loc/${lok}_com.html
cat ${lok}_com.log >> $log
rm ${lok}_com.log
wget -c 1xbet.mobi -a ${lok}_mobi.log --no-check-certificate -t 3
echo 3/5
mv index.html $loc/${lok}_mobi.html
cat ${lok}_mobi.log >> $log
rm ${lok}_mobi.log
wget -c thelotter.com -a ${lok}_lot.log --no-check-certificate -t 3
echo 4/5
mv index.html $loc/${lok}_lot.html
cat ${lok}_lot.log >> $log
rm ${lok}_lot.log
wget -c webmoneycasino.com -a ${lok}_web.log --no-check-certificate -t 3
curl -O http://webmoneycasino.com/index.html
echo 5/5
mv index.html $loc/${lok}_web.html
cat ${lok}_web.log >> $log
rm ${lok}_web.log
echo  >> $log
echo  >> $log
echo Zkouším ping na 1xbet.com
echo Zkouším ping na 1xbet.com >> $log
ping 1xbet.com -c 4 >> $log
echo  >> $log
echo Zkouším ping na 1xbet.mobi
echo Zkouším ping na 1xbet.mobi >> $log
ping 1xbet.mobi -c 4 >> $log
echo  >> $log
echo Zkouším ping na thelotter.com
echo Zkouším ping na thelotter.com >> $log
ping thelotter.com -c 4 >> $log
echo  >> $log
echo Zkouším ping na webmoneycasino.com
echo Zkouším ping na webmoneycasino.com >> $log
ping webmoneycasino.com -c 4 >> $log
echo  >> $log
echo  >> $log
echo Zkouším traceroute na 1xbet.com
echo Zkouším traceroute na 1xbet.com >> $log
sudo traceroute 1xbet.com -w 1 -m 10 >> $log
#traceroute 1xbet.com >> $log
echo  >> $log
echo Zkouším traceroute na 1xbet.mobi
echo Zkouším traceroute na 1xbet.mobi >> $log
sudo traceroute 1xbet.mobi -w 1 -m 10 >> $log
#traceroute 1xbet.mobi >> $log
echo  >> $log
echo Zkouším traceroute na thelotter.com
echo Zkouším traceroute na thelotter.com >> $log
sudo traceroute thelotter.com -w 1 -m 10 >> $log
#traceroute thelotter.com >> $log
echo  >> $log
echo Zkouším traceroute na webmoneycasino.com
echo Zkouším traceroute na webmoneycasino.com >> $log
sudo traceroute webmoneycasino.com -w 1 -m 10 >> $log
#traceroute webmoneycasino.com >> $log
echo  >> $log
echo  >> $log
locip=`ip addr | grep wlan0 | grep inet | awk '{print $2}' | awk -F/ '{print $1}'`
range=`ip route | grep / | awk '{print $1}'`
ap=`ip route | grep default | awk '{print $3}'`
echo Pouštím scan sítě v rozsahu $range
echo Pouštím scan sítě v rozsahu $range >> $log
sudo nmap -sn $range >> $log
echo  >> $log
echo  >> $log
echo Zjišťuji adresy DNS serverů:
echo Zjišťuji adresy DNS serverů: >> $log
cat /etc/resolv.conf | grep nameserver 
cat /etc/resolv.conf | grep nameserver >> $log
echo  >> $log
echo  >> $log
whois $IP >> $log
echo  >> $log
echo pouštím chromium
chromium-browser --no-sandbox --headless --disable-gpu --window-size=1800,900 --screenshot=$obr/1xbet.png http://1xbet.com
chromium-browser --no-sandbox --headless --disable-gpu --window-size=1800,900 --screenshot=$obr/1xbetmob.png https://1xbet.mobi
chromium-browser --no-sandbox --headless --disable-gpu --window-size=1800,900 --screenshot=$obr/thelotter.png http://thelotter.com
chromium-browser --no-sandbox --headless --disable-gpu --window-size=1800,900 --screenshot=$obr/webmoney.png http://webmoneycasino.com
chromium-browser --no-sandbox --headless --disable-gpu --window-size=1800,900 --screenshot=$obr/mojeip.png https://mojeip.cz
chromium-browser --no-sandbox --headless --disable-gpu --window-size=1800,900 --screenshot=$obr/bezi.png https://cas.nebezi.cz
chromium-browser --no-sandbox --headless --disable-gpu --window-size=1800,900 --screenshot=$obr/AP.png http://$ap
chromium-browser --no-sandbox --headless --disable-gpu --window-size=1800,900 --screenshot=$obr/APs.png https://$ap
curl ipinfo.io >> $log
echo  >> $log
majitel=`whois $IP | grep netname | awk '{print $2}'`
echo Příkaz byl dokončen v `date +"%H:%M:%S"` v $lok s IP $IP a vnitřní IP $locip majitele $majitel
echo Příkaz byl dokončen v `date +"%H:%M:%S"` v $lok s IP $IP a vnitřní IP $locip majitele $majitel >> $log
