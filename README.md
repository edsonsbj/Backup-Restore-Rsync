### **Script de backup e restauração usando Rsync**

Scripts de backup e restauração que utiliza o `rsync` e `tar`como forma de backup e restauração de seus arquivos e configurações.

Estes Scripts assume que você fara backups em uma midia externa com um espaço consideravel para armazenar seus backups.

**Realizando Backup**

1. Instale o Git se não estiver instalado.
2. Clone este Repositório` git clone,`ou baixe e descompacte o arquivo zip.
3. Copie os arquivos `backup.sh Configs e include-lst` para uma pasta de sua preferencia.
4. Altere as variáveis do arquivo `Configs` conforme suas necessidades. 
5. Adicione o caminho para o arquivo `Configs` nos scripts `backup.sh` e `restore.sh` na parte `CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs"`.
6. Vá para a pasta onde colocou os scripts e os torne executáveis com o comando `sudo chmod a+x`.
7. Execute o backup: `sudo /path/to/backup.sh`.
8. Agende o backup no Cron: `00 00** * sudo /path/to/backup.sh`

**Restauração**

1. Edite o `backup.sh` com editor de sua preferencia e onde estiver `"$DIR01" "$DESTINATIONDIR"`e altere para o seguinte `"$DESTINATIONDIR" "$DIR01".`

## **Backup & Restauração Servidores Nextcloud**

Este Script realiza o Backup e a Restauração de um servidor `Nextcloud` instalado via `snap` 

**Realizando Backup**

1. Instale o Git se não estiver instalado.
2. Clone este Repositório `git clone,` ou baixe e descompacte o arquivo zip.
3. Copie os arquivos da Pasta Nextcloud para uma pasta de sua preferencia. 
4. Altere as variáveis do arquivo `Configs` conforme suas necessidades.
5. Não Altere a Variável `NEXTCLOUD_CONFIG` e `TAR_NEXTCLOUD_CONFIG` em seu arquivo `Configs`
6. Adicione o caminho para o arquivo `Configs` nos scripts `backup.sh` e `restore.sh` na parte `CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs"`.
7. Inclua os arquivos que não queira fazer backup de sua pasta `./Nextcloud/data` no arquivo `exclude-lst`. Se a intensão for realizar backup somente de algumas pastas ou usúarios, inclua os no arquivo `include-lst` e altere o comando no script de `--exclude-from` para `--files-from.`
8. Torne os scripts `backup.sh.` e `restore.sh.` executáveis

**Realizando Restauração**

1. Certifique-se que sua distribuição já esteja habilitado o suporte a snap, se não o faça.
2. instale o snap nextcloud.
3. Execute o script `restore.sh.`

## **Backup & Restauração Servidores Nextcloud e PLEX**

Este Script realiza o Backup e a Restauração das configurações do `Nexcloud` e do `Plexmediaserver` instalados por meio de pacotes `snap`. Este script tambem faz backup de sua pasta `/Nextcloud/data.`

**Realizando Backup**

1. Instale o Git se não estiver instalado.
2. Clone este Repositório `git clone,` ou baixe e descompacte o arquivo zip.
3. Copie os arquivos da Pasta Nextcloud Plex para uma pasta de sua preferencia. 
4. Altere as variáveis do arquivo `Configs` conforme suas necessidades.
5. Não Altere as variáveis `NEXTCLOUD_CONFIG.` `PLEX_CONFIG` `TAR_NEXTCLOUD_CONFIG` `TAR_EPLEX_CONFIG.` Os Caminhos referente a estas variáveis já estão com seus caminhos de backup e restauração corretos para um backup de configurações snap.
6. Adicione o caminho para o arquivo `Configs` nos scripts `backup.sh` e `restore.sh` na parte `CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs"`.
7. Inclua os arquivos que não queira fazer backup de sua pasta `./Nextcloud/data` no arquivo `exclude-lst`. Se a intensão for realizar backup somente de algumas pastas ou usúarios, inclua os no arquivo `include-lst` e altere o comando no script de `--exclude-from` para `--files-from.` 
8. Torne os scripts `backup.sh.` e `restore.sh.` executáveis

**Realizando Restauração**

1. Certifique-se que sua distribuição já esteja habilitado o suporte a snap, se não o faça.
2. instale o snap nextcloud.
3. Instale o snap plexmediaserver 
4. Execute o script `restore.sh.`

## **Backup & Restauração Servidores Nextcloud e Emby (Jellyfn)**

Este Script realiza o Backup e a Restauração das configurações de seu servidor `Nexcloud` e `emby`. Este script tambem faz backup de sua pasta `/Nextcloud/data.`

**Realizando Backup**

1. Instale o Git se não estiver instalado.
2. Clone este Repositório `git clone,` ou baixe e descompacte o arquivo zip.
3. Copie os arquivos da Pasta Nextcloud Plex para uma pasta de sua preferencia. 
4. Altere as variáveis do arquivo `Configs` conforme suas necessidades.
5. Não Altere as variáveis `NEXTCLOUD_CONFIG.` `EMBY_CONFIG` `TAR_NEXTCLOUD_CONFIG` `TAR_EMBY_CONFIG`. Os Caminhos referente a estas variáveis já estão com seus caminhos de backup e restauração corretos para um backup de configurações snap e instações padrão do emby (jellyfn).
6. Adicione o caminho para o arquivo `Configs` nos scripts `backup.sh` e `restore.sh` na parte `CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs"`.
7. Inclua os arquivos que não queira fazer backup de sua pasta `./Nextcloud/data` no arquivo `exclude-lst`. Se a intensão for realizar backup somente de algumas pastas ou usúarios, inclua os no arquivo `include-lst` e altere o comando no script de `--exclude-from` para `--files-from`.
8. Torne os scripts `backup.sh.` e `restore.sh.` executáveis

**Realizando Restauração**

1. Certifique-se que sua distribuição já esteja habilitado o suporte a snap, se não o faça.
2. instale o snap nextcloud.
3. Instale o emby
4. Execute o script `restore.sh.`

# **Algumas Observações**

**Para Intalação que executem o snap Nextcloud e o Plex juntos**

. Utilize este outro script https://github.com/edsonsbj/Nextcloud-Plex-Onlyoffice-Aria2c-qBitorrent para realizar a instalação e configuração dos pacotes.

. Se apos a restauração aparece algum erro relacionado a sua pasta de dados e ao arquivo ocdata execute estes comandos:

Partições Linux

`sudo chown -R root:root /patch/Nextcloud/data` `chmod 0770 /patch/Nextcloud/data`.

Partições NTFS

Execute o comando `sudo blkid -o list -w /dev/null` e anote o uuid da partição montada.
Adicione ao seu arquivo fstab `UUID=040276482A715ABE /mnt/Nextcloud ntfs-3g utf8,uid=root,gid=root,umask=0007,noatime 0 0`. Não Esqueça de Substituir o `UUID` e ponto de montagem `/mnt/Nextcloud` do exemplo acima para o uuid e ponto de montagem correspondentes a sua unidade.
 
