echo "##############################################"
echo
echo
echo "DEACTIVATE BTRFS SNAPSHOTs for this folder!"
echo "otherwise the system could get unstable and hang"
echo
if [ "$1" != "-f" ] ; then
	read -p " REALLY START DISK FILLING ? (type REALLY to confirm) " key
	if [ "$key" !=  "REALLY" ];then
		exit
	fi
fi



if [ "$2" != "--max" ] && [ "$2" != "--throttle" ]; then
	read -p " GO WIth maximum dd speed ? (type max to do so ) " speed
	if [ "$speed" ==  "max" ];then
		BS=8192
		echo "Ok, go for max speed"
	else
		BS=256
		echo "Default: throttled speed"
	fi
else
	if [ "$2" == "--max" ];then
		BS=8192
		echo "OK, go fro max speed!"
	fi
	if [ "$2" == "--throttle" ]; then
		BS=256
		echo "OK, throttle write speed"
	fi
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

