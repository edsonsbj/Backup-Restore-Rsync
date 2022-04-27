#!/usr/bin/env bash
#

# Script Simples para a realização de backup e restauração de pastas e arquivos usando Rsync em HD Externo 
 
CONFIG="/path/to/Rsync/Configs"
. ${CONFIG}

# NOT CHANGE
MOUNT_FILE="/proc/mounts"
NULL_DEVICE="1> /dev/null 2>&1"
REDIRECT_LOG_FILE="1>> $LOGFILE_PATH 2>&1"
# ------------------------------------------------------------------------ #
# -------------------------------TESTS----------------------------------------- #
# Is root?
[ "$UID" != "0" ] && {
  echo "---------- You must be root ----------" >> $LOGFILE_PATH
  exit 1
}

# Is device mounted?
grep -q "$DEVICE" "$MOUNT_FILE"
if [ "$?" != "0" ]; then
  # If not, mount to $DESTINATIONDIR
  echo "---------- Device not mounted. Mounting $DEVICE ----------" >> $LOGFILE_PATH
  eval mount -t auto "$DEVICE" "$DESTINATIONDIR" "$NULL_DEVICE"
else
  # If yes, grep the mount point and change the $DESTINATIONDIR
  DESTINATIONDIR=$(grep "$DEVICE" "$MOUNT_FILE" | cut -d " " -f 2)
fi

cd "/"

# Is there write permissions?
[ ! -w "$DESTINATIONDIR" ] && {
  echo "---------- Do not have write permissions ----------" >> $LOGFILE_PATH
  exit 1
}
## ------------------------------------------------------------------------ #

  echo "---------- Back-up initiated. ----------" >> $LOGFILE_PATH

# -------------------------------FUNCTIONS----------------------------------------- #
# Exemplo para realizar backup e restauração de vários diretórios. Comente a linha abaixo se naão tiver interesse

backup() {
sudo rsync -avh --delete --progress {"$DIR01","$DIR02"} "$DESTINATIONDIR" 1>> $LOGFILE_PATH

# Exemplo para realizar backup e restauração de um único diretório e filtrar os arquivos que sera realizado backup. Comente a linha abaixo se não tiver interesse

backup() {
sudo rsync -avh --delete --progress "$DIR01" "$DESTINATIONDIR" --files-from "$INCLIST" 1>> $LOGFILE_PATH

# Exemplo para realizar backup simples de um único diretório. Comente a linha abaixo se não tiver interesse

backup() {
sudo rsync -avh --delete --progress "$DIR01" "$DESTINATIONDIR" 1>> $LOGFILE_PATH

  # Worked fine? Umount.
  [ "$?" = "0" ] && {
    echo "---------- Back-up finished. Umounting $DEVICE ----------" >> $LOGFILE_PATH
 	eval umount "$DEVICE" "$NULL_DEVICE"
	eval sudo udisksctl power-off -b "${DEVICE}" >>$LOGFILE_PATH
    exit 0
  }
}

preparelogfile () {
  # Insert a simple header to the log file with the timestamp
  echo "----------[ $(date) ]----------" >> $LOGFILE_PATH
}

main () {
  preparelogfile
  backup
}
# ------------------------------------------------------------------------ #

# -------------------------------EXECUTION----------------------------------------- #
main
# ------------------------------------------------------------------------ #

