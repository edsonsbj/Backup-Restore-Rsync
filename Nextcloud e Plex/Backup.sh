#!/usr/bin/env bash
#

# Script Simples para a realização de backup e restauração de pastas e arquivos usando Rsync em HD Externo 
 
# Adicione aqui o caminho para o Arquivo Configs
CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs" 

. ${CONFIG}

# NÃO ALTERE
MOUNT_FILE="/proc/mounts"
NULL_DEVICE="1> /dev/null 2>&1"
REDIRECT_LOG_FILE="1>> $LOGFILE_PATH 2>&1"
# ------------------------------------------------------------------------ #
# -------------------------------TESTS----------------------------------------- #
# Script Executado como root?
[ "$UID" != "0" ] && {
  echo "---------- Você deve ser root ----------" >> $LOGFILE_PATH
  exit 1
}

# O Dispositivo está Montado?
grep -q "$DEVICE" "$MOUNT_FILE"
if [ "$?" != "0" ]; then
  # Se não, monte em $DESTINATIONDIR
  echo "---------- Dispositivo não montado. Monte $DEVICE ----------" >> $LOGFILE_PATH
  eval mount -t auto "$DEVICE" "$DESTINATIONDIR" "$NULL_DEVICE"
else
  # Se sim, grep o ponto de montagem e altere o $DESTINATIONDIR
  DESTINATIONDIR=$(grep "$DEVICE" "$MOUNT_FILE" | cut -d " " -f 2)
fi

# Há permissões de excrita e gravação?
[ ! -w "$DESTINATIONDIR" ] && {
  echo "---------- Não tem permissões de gravação ----------" >> $LOGFILE_PATH
  exit 1
}
## ------------------------------------------------------------------------ #

   echo "---------- Iniciando Backup. ----------" >> $LOGFILE_PATH

# -------------------------------FUNÇÕES----------------------------------------- #
  echo >> $LOGFILE_PATH
  echo "---------- Backup das Configurações. ----------" >> $LOGFILE_PATH # 

# Vá Para a Raiz

cd "/"
  
# Exportando Configurações Snap Nextcloud

sudo nextcloud.export -abc >> $LOGFILE_PATH

# Compactar Diretorio de Backup para melhor desempenho ao transferir 

tar -czvf $ARQUIVO_TAR -T $TARLIST >> $LOGFILE_PATH

echo
echo Done!!

  echo "---------- Backup Nextcloud Data. ----------" >> $LOGFILE_PATH # 

# Ativar Modo de Manutenção Nextcloud
sudo nextcloud.occ maintenance:mode --on >> $LOGFILE_PATH

backup() {
sudo rsync -avh --delete --progress "$NEXTCLOUD_DATA" "$DESTINATIONDIR" --exclude-from "$EXCLUDELIST" 1>> $LOGFILE_PATH

# Desativar Modo de Manutenção Nextcloud

sudo nextcloud.occ maintenance:mode --off >> $LOGFILE_PATH

# Remover Arquivos Residuais

rm -rf $NEXTCLOUD_CONFIG/backups

  # Funcionou bem? Remova a Midia Externa.
  [ "$?" = "0" ] && {
    echo "---------- Backup Finalizado. Desmonte a Unidade $DEVICE ----------" >> $LOGFILE_PATH
 	eval umount "$DEVICE" "$NULL_DEVICE"
	eval sudo udisksctl power-off -b "${DEVICE}" >>$LOGFILE_PATH
    exit 0
  }
}

preparelogfile () {
  #   # Insira um cabeçalho simples no arquivo de log com o carimbo de data/hora
  echo "----------[ $(date) ]----------" >> $LOGFILE_PATH
}

main () {
  preparelogfile
  backup
}
# ------------------------------------------------------------------------ #

# -------------------------------EXECUÇÃO----------------------------------------- #
main
# ------------------------------------------------------------------------ #

