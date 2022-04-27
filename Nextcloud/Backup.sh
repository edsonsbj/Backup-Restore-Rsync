#!/usr/bin/env bash
#

# Script Simples para a realização de backup e restauração de pastas e arquivos usando Rsync em HD Externo 
 
CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs"
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

# Exportando Configurações Snap Nextcloud

sudo nextcloud.export -abc >> $LOGFILE_PATH

# Compactar Diretorio de Backup para melhor desempenho ao transferir 

tar -czvf $ARQUIVO_TAR $NEXTCLOUD_CONFIG >> $LOGFILE_PATH

# Ativar Modo de Manutenção Nextcloud

sudo nextcloud.occ maintenance:mode --on >> $LOGFILE_PATH

# -------------------------------FUNCTIONS----------------------------------------- #
backup() {
sudo rsync -avh --delete --progress "$NEXTCLOUD_DATA" "$DESTINATIONDIR" --exclude-from "$EXCLUDELIST" 1>> $LOGFILE_PATH

# Ativar Modo de Manutenção Nextcloud

sudo nextcloud.occ maintenance:mode --off >> $LOGFILE_PATH

# Remover Arquivos Residuais

rm -rf $NEXTCLOUD_CONFIG

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

