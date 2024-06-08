#!/bin/bash

termux-wake-unlock
apt-get update
apt-get install git -y
apt-get install cmake -y
apt update
apt upgrade -y
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
cmake -DWITH_HWLOC=OFF ..
make

#Ask for pool
echo 'Where do you want to mine?在0、1、2、3里选1个你要开采的矿池？'
pool=("43.136.21.157:8888" "privacymine.net:5555" "78.78.187.214:3333" "techy.ddns.net:3333" "pacific-ocean-pool.xyz:3333")

for i in "${!pool[@]}"; do
  printf "%s\t%s\n" "$i" "${pool[$i]}"
done

read opt
echo After entering your XKR-address the miner will start. To start it again, just enter Termux and type xkr.
echo Your XKR-Address?填写你的xkr地址后回车开始采矿?
read address
#Create shortcut
DIR=$(pwd)
echo "${DIR}/xmrig -a cn-pico -o ${pool[$opt]} -u $address -p x -t $(nproc)" > start.sh
chmod +x start.sh
alias xkr="${DIR}/start.sh"
echo "alias xkr=${DIR}/start.sh" >> ~/.bashrc
#Start xmrig
./xmrig -a cn-pico -o ${pool[$opt]} -u $address -p x -t 8
