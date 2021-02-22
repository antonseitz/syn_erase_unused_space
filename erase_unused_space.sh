echo "##############################################"
echo
echo
echo "DEACTIVATE BTRFS SNAPSHOTs for this folder!"
echo "otherwise the system could get unstable and hang"
echo
read -p " REALLY START DISK FILLING ? (type REALLY to confirm) " key
if [ "$key" !=  "REALLY" ];then
exit
fi
echo "creting small file... "
dd if=/dev/zero of=zerofill.small.file bs=1024 count=1024000 status=progress

echo " fill disk without limit untill it is full"
dd if=/dev/zero of=zerofill.big.fill bs=4096k status=progress

sync

ehco " HDD is now  100% full !"
echo " delete small file, to free space so user can work."
rm zerofill.small.file
sync

echo "delete big file.."

rm zerofill.big.fill
sync


