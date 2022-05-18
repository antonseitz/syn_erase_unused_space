echo $1
if ["$1" == "--maxspeed" ];then
	BS=4096
	echo "max"
else
	BS=512
	echo "throttled speed"
fi
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
if [ -f zerofill.small.file ]; then
echo "alredy present!"
else
dd if=/dev/zero of=zerofill.small.file bs=1024 count=2024000 status=progress
fi

echo " fill disk without limit untill it is full"
for (( x=11; x+=1 ; x>0)); do 
if [ -f zerofill.big.fill.$x ] ;then 
echo "zerofill.big.fill.$x already exits; skipping"
continue
else

echo "create zerofill.big.fill.$x.."
dd if=/dev/zero of=zerofill.big.fill.$x bs=$BS status=progress count=100000000
LASTCODE=$?
echo $LASTCODE
if [ $LASTCODE -gt 0 ]; then 
echo "DISK FULL: exit loop"
break;

else
echo "..created! "
fi
fi
done
sync

echo " HDD is now  100% full !"
echo " delete small file, to free space so user can work."
rm zerofill.small.file
sync

echo "delete last big file.."

rm zerofill.big.fill.$x
sync


echo "COMPLETED!"

echo "##############################################"
echo
echo
echo "NOW ACTIVATE BTRFS SNAPSHOTs AGAIN for this folder!"

