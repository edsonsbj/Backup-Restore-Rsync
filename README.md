### **Backup and restore script using Rsync**

Backup and restore scripts that use `rsync` and `tar` as a way to backup and restore your files and settings.

These scripts assume that you will be backing up to an external media with a considerable amount of space to store your backups.

**Performing Backup**

1. install Git if it is not installed.
2. Clone this Repository` git clone,` or download and unzip the zip file.
3. Copy the `backup.sh Configs and include-lst` files to a folder of your choice.
4. Change the variables in the `Configs` file to suit your needs. 
5. Add the path to the `Configs` file in the `backup.sh` and `restore.sh` scripts in the `CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs"` part.
6. Go to the folder where you placed the scripts and make them executable with the command `sudo chmod a+x`.
7. Run the backup: `sudo /path/to/backup.sh`.
8. Schedule the backup in Cron: `00 00 * * * sudo /path/to/backup.sh`

**Restore**

1. edit `backup.sh` with editor of your choice and where is `"$DIR01" "$DESTINATIONDIR"` and change it to the following `"$DESTINATIONDIR" "$DIR01".

## **Backup & Restore Nextcloud Servers**

This Script performs Backup and Restore of a `Nextcloud` server installed via `snap`. 

**Performing Backup**

1. install Git if not already installed.
2. Clone this Repository `git clone,` or download and unzip the zip file.
3. Copy the files from the Nextcloud Folder to a folder of your choice. 
4. Change the variables in the `Configs` file to suit your needs.
5. Do not change the Variable `NEXTCLOUD_CONFIG` and `TAR_NEXTCLOUD_CONFIG` in your `Configs` file.
6. Add the path to the `Configs` file in the `backup.sh` and `restore.sh` scripts in the `CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs"` part.
7. Include the files you do not want to backup from your `./Nextcloud/data` folder in the `exclude-lst` file. If you want to backup only some folders or users, include them in the `include-lst` file and change the command in the script from `--exclude-from` to `--files-from.`.
8. Make the `backup.sh.` and `restore.sh.` scripts executable.

**Performing Restore**

1. Make sure your distribution already has snap support enabled, if not do so.
2. install the nextcloud snap.
3. Run the script `restore.sh.`

## **Backup & Restore Nextcloud and PLEX Servers**

This Script performs Backup and Restore of `Nexcloud` and `Plexmediaserver` configurations installed through `snap` packages. This script also backs up your `/Nextcloud/data.` folder.

**Performing Backup**

1. install Git if it is not installed.
2. Clone this Repository `git clone,` or download and unzip the zip file.
3. Copy the files from the Nextcloud Plex Folder to a folder of your choice. 
4. Change the variables in the `Configs` file to suit your needs.
5. Do not change the variables `NEXTCLOUD_CONFIG.` ` `PLEX_CONFIG` `TAR_NEXTCLOUD_CONFIG` `TAR_EPLEX_CONFIG.` The Paths for these variables are already backed up and restored correctly for a snap configuration backup.
6. Add the path to the `Configs` file to the `backup.sh` and `restore.sh` scripts in the `CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs"` part.
7. Include the files you do not want to backup from your `./Nextcloud/data` folder in the `exclude-lst` file. If you want to backup only some folders or users, include them in the `include-lst` file and change the command in the script from `--exclude-from` to `--files-from.`. 
8. Make the `backup.sh.` and `restore.sh.` scripts executable.

**Performing Restore**

1. Make sure your distribution already has snap support enabled, if not do so.
2. install the nextcloud snap.
3. Install the plexmediaserver snap 
4. Run the script `restore.sh.`

## **Backup & Restore Nextcloud and Emby Servers (Jellyfn)**

This Script performs Backup and Restore of your `Nextcloud` and `emby` server settings. This script also backs up your `/Nextcloud/data.` folder.

**Performing Backup**

1. install Git if it is not installed.
2. Clone this Repository `git clone,` or download and unzip the zip file.
3. Copy the files from the Nextcloud Plex Folder to a folder of your choice. 
4. Change the variables in the `Configs` file to suit your needs.
5. Do not change the variables `NEXTCLOUD_CONFIG.` ` `EMBY_CONFIG` `TAR_NEXTCLOUD_CONFIG` `TAR_EMBY_CONFIG`. The Paths referring to these variables are already backed up and restored correctly for a backup of snap settings and default emby (jellyfn) installations.
6. Add the path to the `Configs` file in the `backup.sh` and `restore.sh` scripts in the `CONFIG="/Path/to/Nextcloud-Backup-Restore/Configs"` part.
7. Include the files you do not want to backup from your `./Nextcloud/data` folder in the `exclude-lst` file. If you want to backup only some folders or users, include them in the `include-lst` file and change the command in the script from `--exclude-from` to `--files-from`.
8. Make the `backup.sh.` and `restore.sh.` scripts executable

**Performing Restore**

1. Make sure your distribution already has snap support enabled, if not do so.
2. install the nextcloud snap.
3. Install emby
4. Run the script `restore.sh.`

# **Some Notes**

**For Installations run Nextcloud snap and Plex together**.

. Use this other script https://github.com/edsonsbj/Nextcloud-Plex-Onlyoffice-Aria2c-qBitorrent to perform the installation and configuration of the packages.

. If after the restore appears any error related to your data folder and ocdata file run these commands:

Linux Partitions

`sudo chown -R root:root /patch/Nextcloud/data` `chmod 0770 /patch/Nextcloud/data`.

NTFS partitions

Run the command `sudo blkid -o list -w /dev/null` and note the uuid of the mounted partition.
Add to your fstab file `UUUID=040276482A715ABE /mnt/Nextcloud ntfs-3g utf8,uid=root,gid=root,umask=0007,noatime 0 0`. Don't Forget to Replace the `UUUID` and mountpoint `/mnt/Nextcloud` from the example above to the uuid and mountpoint corresponding to your drive.
