
# create small file 
dd if=/dev/zero of=zerofill.small.file bs=1024 count=1024000 status=progress

# fill disk without limit untill it is full
dd if=/dev/zero of=zerofill.big.fill bs=4096k status=progress

sync

# HDD is now  100% full !
# delete small file, to free space so user can work.
rm zerofill.small.file
sync
# delete big file

rm zerofill.big.fill
sync


