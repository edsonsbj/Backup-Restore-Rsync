### **Script de backup e restauração usando Rsync**

Scripts de backup e restauração que utiliza o `rsync` e `tar`como forma de backup e restauração de seus arquivos e configurações. 

**Realizando Backup**

1. Instale o Git se não estiver instalado.
2. Clone este Repositório` git clone,`ou baixe e descompacte o arquivo zip.
3. Copie os arquivos `backup.sh Configs e include-lst` para uma pasta de sua preferencia.
4. Altere as variáveis do arquivo  `Configs`conforme suas necessidades. 
5. Vá para a pasta onde colocou os scripts e os torne executáveis com o comando `sudo chmod a+x`.
6. Execute o backup: `sudo /path/to/backup.sh`.
7. Agende o backup no Cron: `00 00** * sudo /path/to/backup.sh`

**Restauração**

1. Edite o `backup.sh` com editor de sua preferencia e onde estiver `"$DIR01" "$DESTINATIONDIR"`e altere para o seguinte `"$DESTINATIONDIR" "$DIR01".`

## **Backup & Restauração Servidores Nextcloud**

Este Script realiza o Backup e a Restauração de um servidor `Nextcloud` instalado via `snap` 

**Realizando Backup**

1. Instale o Git se não estiver instalado.
2. Clone este Repositório `git clone,` ou baixe e descompacte o arquivo zip.
3. Copie os arquivos da Pasta Nextcloud para uma pasta de sua preferencia. 
4. Altere as variáveis do arquivo `Configs` conforme suas necessidades.
5. Inclua os arquivos que não queira fazer backup de sua pasta `./Nextcloud/data` no arquivo `exclude-lst`. Se a intensão for realizar backup somente de algumas pastas ou usúarios, inclua os no arquivo `include-lst` e altere o comando no script de `--exclude-from` para `--files-from`.
6. Não Altere a Variável `NEXTCLOUD_CONFIG.`
7. Torne os scripts `backup.sh.` e `restore.sh.` executáveis

**Realizando Restauração**

1. Certifique-se que sua distribuição já esteja habilitado o suporte a snap, se não o faça.
2. instale o snap nextcloud.
3. Execute o script `restore.sh.`

## **Backup & Restauração Servidores Nextcloud e PLEX**

Este Script realiza o Backup e a Restauração das configurações do `Nexcloud` e do `Plexmediaserver` instalados por meio de pacotes `snap`. Este script tambem faz backup de sua pasta `/Nextcloud/data.`

**Realizando Backup**

1. Instale o Git se não estiver instalado.
2. Clone este Repositório `git clone,` ou baixe e descompacte o arquivo zip.
3. Copie os arquivos da Pasta Nextcloud para uma pasta de sua preferencia. 
4. Altere as variáveis do arquivo `Configs` conforme suas necessidades.
5. Inclua os arquivos que não queira fazer backup de sua pasta `./Nextcloud/data` no arquivo `exclude-lst`. Se a intensão for realizar backup somente de algumas pastas ou usúarios, inclua os no arquivo `include-lst` e altere o comando no script de `--exclude-from` para `--files-from`.
6. Não Altere as variáveis `NEXTCLOUD_CONFIG.` `PLEX_CONFIG` `CONFIG_NC_RESTORE` `CONFIG_PLEX_RESTORE`. Os Caminhos referente a estas variáveis já estão com seus caminhos de backup e restauração corretos para um backup de configurações snap.
7. Torne os scripts `backup.sh.` e `restore.sh.` executáveis

**Realizando Restauração**

1. Certifique-se que sua distribuição já esteja habilitado o suporte a snap, se não o faça.
2. instale o snap nextcloud.
3. Instale o snap plexmediaserver 
4. Execute o script `restore.sh.`
