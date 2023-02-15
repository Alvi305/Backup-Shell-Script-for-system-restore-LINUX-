# Backup-Shell-Script-for-system-restore-LINUX-

## Description

A shell script executable on the Ubuntu terminal that copies files from the system to an external USB drive, given that the files meet certain conditions, and copies system critical information to the external drive so the system can be recovered to its former state. The script has two modules: Module 1 and Module 2.

## Module 1: File Copy
This module copies all the files within the drives accessible from the Ubuntu OS to the connected external USB drive, but only if the following conditions are met:

-	The file is not located in a directory blacklisted in the configuration.
-	The file extension is included in a whitelist of file extensions.




## Module 2: System Backup

This module copies system-critical information of the Ubuntu OS to the external drive so the system can be recovered to its former state even if the OS undergoes a clean reinstall after a catastrophic system failure. This information includes:

-	System configuration files
-	List of installed packages (from apt, conda, and snap)
-	System logs and command history.


The following variables are used to make text files to store system critical information about the system. The text files created are stored in the destination directory for system critical information which by default is the SystemLogs folder created within the repository when you run the script.

Description of the variables are as follows:

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
The variable declaration can be found at line 171 of [Backup_Script.sh](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/Backup_Script.sh). 

Description of the variables is given below:

- sys_log: name of the text file used to store system logs

- kernel: name of the text file used to store kernel logs

- apt_cache: name of the text file used to store names apt packages installed automatically

- apt_manual:  name of the  text file used to store names of apt packages installed manually

- snap: name of the text file used to store names of snap packages installed

- conda: name of the text file used to store conda packages installed

- history: name of the text file used to store terminal command history

## How to Use
1.	Connect an external USB drive to your Ubuntu system.
2.	Clone the repository using `git clone https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-`
3.	Open a terminal window and navigate to the directory where the repository is located.
5.	Run the script using the following command: `sudo ./Backup_Script.sh`. Sudo is required since it copies system-critical information to the destination directory.
 
## Configuration

### Blacklist Directories
Input the blacklist directories into the blacklist directories text file. The text file is located in the repository  and named  as [blacklist.txt](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/blacklist.txt).

### Whitelist Extensions
Input required file extensions into the whitelist extension text file. The text file is located in the repository and named  as [whitelist_ext.txt](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/whitelist_ext.txt).

### Source Directory
The default source directory from where to copy files for backup is the user's home. Change the directory as required by editing the directory path, highlighted in brackets below, on line 8 of the  [Backup_Script.sh](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/Backup_Script.sh):

```
# MODULE 1 

# INPUT SRC DIRECTORY TO COPY FROM  --CHANGE THIS

src_dir=`ls -dR (/home/*)` 

```

### Destination Directories

Both the destination directories for the user's file backups and system critical information are created within the repository by default. Change the user's file backup directory as needed by specifying the preferred directory path in the  variable **dest_dir** on line 17 of  [Backup_Script.sh](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/Backup_Script.sh). Path that needs to edited is highlighted between brackets below:

```
dest_dir="($repository_path/Backups)"

```

Change system-critical information directory as needed by specifying the preferred directory path in the  variable **dest_syslog** on line 162 of  [Backup_Script.sh](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/Backup_Script.sh). Path that needs to edited is hightled between brackets below:

```
dest_syslog="($repository_path/SystemLogs)"

```

## Logging
The script provides informative command-line logging during the copy process to enhance the user experience. This logging includes what directory is being copied, an indication of the copy progress, and any errors that may occur.




