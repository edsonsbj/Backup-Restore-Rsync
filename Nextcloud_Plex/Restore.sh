#!/usr/bin/env bash
#

# Script Simples para a realização de backup e restauração de pastas e arquivos usando Rsync em HD Externo 
 
CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs"
. ${CONFIG}

# NÃO ALTERE
MOUNT_FILE="/proc/mounts"
NULL_DEVICE="1> /dev/null 2>&1"
REDIRECT_LOG_FILE="1>> $RESTLOGFILE_PATH 2>&1"
# ------------------------------------------------------------------------ #
# -------------------------------TESTS----------------------------------------- #
# Está executando como root?
[ "$UID" != "0" ] && {
  echo "---------- Você deve ser root ----------" >> $RESTLOGFILE_PATH
  exit 1
}

# O dispositivo está montado?
grep -q "$DEVICE" "$MOUNT_FILE"
if [ "$?" != "0" ]; then
  # Se não, monte em $DESTINATIONDIR
  echo "---------- Dispositivo não montado. Monte $DEVICE ----------" >> $RESTLOGFILE_PATH
  eval mount -t auto "$DEVICE" "$DESTINATIONDIR" "$NULL_DEVICE"
else
  # Se sim, grep o ponto de montagem e altere o $DESTINATIONDIR
  DESTINATIONDIR=$(grep "$DEVICE" "$MOUNT_FILE" | cut -d " " -f 2)
fi

cd "/"

# Há permissões de gravação
[ ! -w "$DESTINATIONDIR" ] && {
  echo "---------- Não tem permissões de gravação ----------" >> $RESTLOGFILE_PATH
  exit 1
}
## ------------------------------------------------------------------------ #

  echo "---------- Iniciando Restauração. ----------" >> $RESTLOGFILE_PATH

# -------------------------------FUNCTIONS----------------------------------------- #
  echo >> $RESTLOGFILE_PATH
  echo "---------- Restaurando Configurações. ----------" >> $RESTLOGFILE_PATH # 
  
# Pare O serviço Plex 

sudo snap stop plexmediaserver

# Extraindo Arquivos

tar -vxf $ARQUIVO_TAR $CONFIG_NC_RESTORE -C $NEXTCLOUD_CONFIG >> $RESTLOGFILE_PATH

tar -vxf $ARQUIVO_TAR $CONFIG_PLEX_RESTORE -C $PLEX_CONFIG >> $RESTLOGFILE_PATH

# Importando Configurações. Informe a data do arquvo extraido dentro da pasta backups no campo $date 

sudo nextcloud.import $NEXTCLOUD_CONFIG/backups/$date >> $RESTLOGFILE_PATH 

echo
echo Done!!

  echo "---------- Restaurando Nextcloud Data. ----------" >> $RESTLOGFILE_PATH # 

sudo nextcloud.occ maintenance:mode --on >> $RESTLOGFILE_PATH

backup() {
sudo rsync -avh --delete --dry-run --progress "$NEXTCLOUD_DATA" "$DESTINATIONDIR" --exclude-from "$EXCLUDELIST" 1>> $RESTLOGFILE_PATH

# Desativando Modo de Manutenção Nextcloud

sudo nextcloud.occ maintenance:mode --off >> $RESTLOGFILE_PATH

  # Funcionou bem? Desmonte.
  [ "$?" = "0" ] && {
    echo "---------- Restauração Finalizado. Desmonte $DEVICE ----------" >> $RESTLOGFILE_PATH
 	eval umount "$DEVICE" "$NULL_DEVICE"
	eval sudo udisksctl power-off -b "${DEVICE}" >>$RESTLOGFILE_PATH
    exit 0
  }
}

preparelogfile () {
  # Insira um cabeçalho simples no arquivo de log com o carimbo de data/hora
  echo "----------[ $(date) ]----------" >> $RESTLOGFILE_PATH
}

main () {
  preparelogfile
  backup
}
# ------------------------------------------------------------------------ #

# -------------------------------EXECUTION----------------------------------------- #
main
# ------------------------------------------------------------------------ #

