#!/bin/bash

for i in `seq 1 3`; do
    VBoxManage createvm --register --name node$i
    VBoxManage modifyvm node$i --boot1 net --memory 512 --nic1 intnet --intnet1 prov --cableconnected1 on
    VBoxManage createhd --size 8192 --variant Fixed --filename ./node$i.vdi
    VBoxManage storagectl node$i --name SATA --add sata --bootable on
    VBoxManage storageattach node$i --storagectl SATA --port 1 --type hdd --medium ./node$i.vdi
    VBoxManage startvm node$i
done
