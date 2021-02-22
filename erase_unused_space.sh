
# Kleinere Datei erstellen
dd if=/dev/zero of=zerofill.small.file bs=1024 count=1024000 status=progress

# Allen restlichen unused space überschreiben:
dd if=/dev/zero of=zerofill.big.fill bs=4096k status=progress

sync

# Jetzt ist HDD zu 100% voll!
# kleines File löschen, damit User schnell weiterarbeiten können
rm zerofill.small.file
sync
# Großes File löschen
#shred -z -n 1 zero.file sync
# eigentlich nicht notwendig, oder? Ist doch nur mit Nullen gefüllt...
# ...und löschen
rm zerofill.big.fill
sync


