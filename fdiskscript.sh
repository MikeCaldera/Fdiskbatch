  GNU nano 5.4                                                                                                                                                                                                 fdiskscript.sh                                                                                                                                                                                                          
#!/bin/bash

# Display warning message
echo -e "\e[1;31mWarning: This script will delete all data on the following disks:\e[0m"
disks=(
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
    /dev/sdcv
    /dev/sdcw
    /dev/sdcx
    /dev/sdcy
    /dev/sdcz
    /dev/sdda
    /dev/sddb
    /dev/sdds
    /dev/sddt
    /dev/sddu
    /dev/sddv
    /dev/sddw
    /dev/sddx
    /dev/sddy
    /dev/sdeq
    /dev/sder
    /dev/sdes
    /dev/sdet
    /dev/sdeu
    /dev/sdev
    /dev/sdew
    /dev/sdex
    /dev/sdey
    /dev/sdez
    /dev/sdfa
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
                echo -e "d\n$j\n" | fdisk "$i"
            done
            echo -e "w\n" | fdisk "$i"
            echo "Writing changes to $i ..."
            partprobe "$i"
        done

        echo "Done."
        ;;
    * )
        echo "Operation cancelled."
        ;;
esac

echo "Please reboot the server if you are adding ZFS disks in Proxmox. The disks will not show up in the Proxmox GUI until a reboot is done by the OS. Thank you."
