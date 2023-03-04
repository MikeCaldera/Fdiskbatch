#!/bin/bash

# Display warning message
echo -e "\e[1;31mWarning: This script will delete all data on the following disks:\e[0m"
disks=(
/dev/sdi
/dev/sdj
/dev/sdk
/dev/sdl
/dev/sdm
/dev/sdr
/dev/sdn
/dev/sdp
/dev/sdo
/dev/sds
/dev/sdq
/dev/sdt
/dev/sdu
/dev/sdv
/dev/sdw
/dev/sdx
/dev/sdy
/dev/sdz
/dev/sdaa
/dev/sdab
/dev/sdac
/dev/sdad
/dev/sdae
/dev/sdaf
/dev/sdag
/dev/sdah
/dev/sdai
/dev/sdaj
/dev/sdak
/dev/sdal
/dev/sdam
/dev/sdan
/dev/sdao
/dev/sdap
/dev/sdaq
/dev/sdar
/dev/sdas
/dev/sdat
/dev/sdau
/dev/sdav
/dev/sdaw
/dev/sdax
/dev/sday
/dev/sdaz
/dev/sdba
/dev/sdbb
/dev/sdbc
/dev/sdbd
/dev/sdbe
/dev/sdbf
/dev/sdbg
/dev/sdbh
/dev/sdbi
/dev/sdbj
/dev/sdbk
/dev/sdbl
/dev/sdbm
/dev/sdbn
/dev/sdbo
/dev/sdbp
/dev/sdbq
/dev/sdbr
/dev/sdbs
/dev/sdbt
/dev/sdbu
/dev/sdbv
/dev/sdbw
/dev/sdbx
/dev/sdby
/dev/sdbz
/dev/sdca
/dev/sdcb
/dev/sdcc
/dev/sdcd
/dev/sdce
/dev/sdcf
/dev/sdcg
/dev/sdch
/dev/sdci
/dev/sdcj
/dev/sdck
/dev/sdcl
/dev/sdcm
/dev/sdcn
)
for (( i=0; i<${#disks[@]}; i+=4 ))
do
echo -e "\e[1;31m${disks[$i]}\t${disks[$i+1]}\t${disks[$i+2]}\t${disks[$i+3]}\e[0m"
done

# Prompt user to confirm
read -p "Do you wish to proceed? (y/n) " confirm
case ${confirm:0:1} in
    y|Y )
        # Delete partitions and write changes
        for i in "${disks[@]}"; do
            echo "Deleting partitions on $i ..."
            for (( j=1; j<=4; j++ )); do
                echo -e "d\n$j\n" | fdisk $i
            done
            echo -e "w\n" | fdisk "$i"
            echo "Writing changes to $i ..."
            partprobe "$i"
        done
        echo -e "\e[1;33mPlease check now and make sure you have no disks partitions left. You can do this by #lsblk. If you see any leftover partitions like partition 1, then delete your zpool.# zpool destroy -f tank. Then run this again!\e[0m"
        ;;
    * )
        echo "Aborting."
        exit 1
        ;;
esac
