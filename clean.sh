#/bin/bash
vagrant destroy -f
for i in `seq 1 3`; do
    VBoxManage controlvm node$i poweroff
    sleep 1s
    VBoxManage unregistervm node$i -delete
done

