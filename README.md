# Fdiskbatch
This will fdisk a large number of Disks at one time. This script is a time saver for data center admins.
This was made because I got tired of using fdisk with many disks at one time and repeating this insanity many times over. 
Now we can just use my free fdiskbatch and fdisk any listed disks on the fly. Once the disk is ready you can add
them to any ZFS pool. This solves that problem quickly when you need to build zpools but can't because you need fdisk first!

Just list the disks you want to delete all partitions (Not the OS disks please) and paste in the code section - disks=(/dev/sdw /dev/sdx) where /sdw is your disk etc.

1) Multipath must be disabled by either commenting out #the wwids or just emptying the file and saving. Whatever works for you. Just make sure you back up everything before you wipe the wwids or comment out.

cd/etc/multipath/
nano wwids 

Valid WWIDs:
#/350000396fxxxxxxx/
#/3500003974xxxxxxx/
#/350000396fxxxxxxx/


2) requires #apt-get install parted
This script will delete all disks specified in the "disks" array and make them visible when creating ZFS pools in the GUI.
To find disks, use #lsscsi or #lsblk.
To get WWIDs if using multipath.conf, run #dmsetup table | sort.
To count multipath disks, run #lsscsi -g.
To use this script, add your disks to the "disks" array below.
To store this script, save it as /usr/local/bin/fdiskscript.sh or /opt/scripts/fdiskscript.sh
To make it executable, run: chmod +x /usr/local/bin/fdiskscript.sh

3) IMPORTANT: Do not include the OS disks (e.g., sda, sdb) in the "disks" array.

Add your disks here, e.g.:
disks=(/dev/sdw /dev/sdx)
to run the script #cd /usr/local/bin/
./fdiskscript.sh ("Warning this will delete all disks!")


Ask the user for confirmation
read -rp "Are you sure you want to delete all partitions on disks listed in the array? Type 'yes' or 'no': " confirm

4) in some cases you must left over zpools in the example below replace Tank with your storage pool name. # zpool status
5) # zpool destroy -f tank 

MikeinNYC on Proxmox see you there!
