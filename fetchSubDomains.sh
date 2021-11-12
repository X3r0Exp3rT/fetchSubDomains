#!/bin/bash
        
url=$1

if [ ! -d "logs" ];then
        mkdir logs
fi

if [ ! -d "logs/$url" ];then
        mkdir logs/$url
fi

if [ ! -f "logs/$url/subDomainsAll.txt" ];then
        touch logs/$url/subDomainsAll.txt
fi

if [ ! -f "logs/$url/subDomainsInScope.txt" ];then
        touch logs/$url/subDomainsInScope.txt
fi

if [ ! -f "logs/$url/subDomainsInScope.txt" ];then
        touch logs/$url/subDomainsInScope.txt
fi

if [ ! -f "logs/$url/subDomainsAlive.txt" ];then
        touch logs/$url/subDomainsAlive.txt
fi

echo " "
echo "[+] Fetching SubDomains..."

assetfinder $url >> logs/$url/tmp1.txt
cat logs/$url/tmp1.txt | sort -u >> logs/$url/subDomainsAll.txt
rm logs/$url/tmp1.txt

echo " "
echo "[+] Separating In Scope SubDomains..."
sleep 2

cat logs/$url/subDomainsAll.txt | grep $url >> logs/$url/tmp2.txt
cat logs/$url/tmp2.txt | sort -u >> logs/$url/subDomainsInScope.txt
rm logs/$url/tmp2.txt

echo " "
echo "[+] Fetching Alive SubDomains In Scope..."

cat logs/$url/subDomainsInScope.txt | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> logs/$url/tmp3.txt
cat logs/$url/tmp3.txt | sort -u >> logs/$url/subDomainsAlive.txt
rm logs/$url/tmp3.txt

echo " "
echo "[Found] SubDomains [ALL]: "$(cat logs/$url/subDomainsAll.txt | wc -l)
echo "[Found] SubDomains [In Scope]: "$(cat logs/$url/subDomainsInScope.txt | wc -l)
echo "[Found] SubDomains [Alive]: "$(cat logs/$url/subDomainsAlive.txt | wc -l)

echo " "
echo "[] DONE []"
echo " "
echo "Script by @X3r0Exp3rT [GitHub]"
echo " "
