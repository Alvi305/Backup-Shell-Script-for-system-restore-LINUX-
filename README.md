# Backup-Shell-Script-for-system-restore-LINUX-

## Description

A shell script executable on Ubuntu terminal that can copy files from the system to an external USB drive, given that the files meet certain conditions. In addition, it copies system critical information to the external drive so the system can be recovered to its former state. The script has two modules:

## Module 1: File Copy
Copies all the files within the drives accessible from the Ubuntu OS to the connected external USB drive, but only if the following conditions are met:

-	The file is not located in a directory blacklisted in the configuration.
-	The file extension is included in a whitelist of file extensions.




## Module 2: System Backup

Copies system-critical information of the Ubuntu OS to the external drive so the system can be recovered to its former state even if the OS undergoes a clean reinstall after a catastrophic system failure. This information includes:

-	System configuration files
-	List of installed packages (from apt, conda, and another commonly used package manager)
-	System logs and command history.


The following variables are used to make text files to store system critical information of the system.

```
# variables for text files to store system critical info

sys_log="/syslog.txt"
kernel="/kernellog.txt"
apt_cache="/apt_cache_pkgs.txt"
apt_manual="/apt_manual_pkgs.txt"
snap="/snap_pkgs.txt"
conda="/conda_pkgs.txt"
history="/history.txt"

```
- sys_log: name of text file to store systel logs

- kernel: name of text file to store kernel logs

- apt_cache: name of text file to store names apt packages installed automatically

- apt_manual:  name of text file to store names of apt packages installed manually

- snap: name of text file to store names of snap packages installed

- conda: name of text file to store conda packages installed

- history: name of text file to store terminal command history

## How to Use
1.	Connect an external USB drive to your Ubuntu system.
2.	Clone the repository using `git clone https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-`
3.	Open a terminal window and navigate to the directory where the repository is located.
5.	Run the script using the following command: `sudo ./Backup_Script.sh`. Sudo is required since it copies system critical information to destination directory.
 
## Configuration

### Blacklist Directories
Input the blacklist directories into the blacklist directories text file. The text file is located in the repository named [blacklist.txt](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/blacklist.txt).

### Whitelist Extensions
Input required file extensions into the whitelist extension text file. The text file is located in the repository named as [whitelist_ext.txt](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/whitelist_ext.txt).

### Source Directory
Default source directory from where to copy files for backup is the user's home. Change the directory as required by editing the directory path, highlighted in brackets below, in the following code snippet of the [Backup_Script.sh](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/Backup_Script.sh):

```
# MODULE 1 

# INPUT SRC DIRECTORY TO COPY FROM  --CHANGE THIS

src_dir=`ls -dR (/home/*)` 

```

### Destination Directories

Both the destination directories for user's file backups and system critical information are created within the repository by default. Change user's file backups as needed by specifying the preferred directory path in the  varibale **dest_dir** of  [Backup_Script.sh](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/Backup_Script.sh). Path that needs to edited is hightled between brackets below:

```
dest_dir="($repository_path/Backups)"

```

Change system critical information directory as needed by specifying the preferred directory path in the  varibale **dest_syslog** of  [Backup_Script.sh](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/Backup_Script.sh). Path that needs to edited is hightled betwwen brackets below:

```
dest_syslog="($repository_path/SystemLogs)"

```

## Logging
The script provides informative command-line logging during the copy process to enhance the user experience. This logging includes what directory is being copies, indication of the copy progress and any errors that may occur.




