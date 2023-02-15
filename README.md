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

Text files, which are used to store system critical information, are created  in the destination directory within the repository when you run the script . The  default path for the destination directory is the SystemLogs folder.

Description of the text files is given below:

- syslog.txt: stores system logs

- kernellog.txt: stores kernel logs

- apt_cache_pkgs.txt: stores names apt packages installed automatically

- apt_manual_pkgs.txt:  stores names of apt packages installed manually

- snap_pkgs.txt: stores names of snap packages installed

- conda_pkgs.txt: stores conda packages installed

- history.txt: stores terminal command history

## How to Use
1.	Connect an external USB drive to your Ubuntu system.
2.	Clone the repository using `git clone https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-`
3.	Open a terminal window and navigate to the directory where the repository is located.
5.	Run the script using the following command: `sudo ./Backup_Script.sh`. Sudo is required since it copies system-critical information to the destination directory.
 
## Configuration

You need to change the contents of the following files: [blacklist.txt](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/blacklist.txt) and  [whitelist_ext.txt](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/whitelist_ext.txt). Further details are given below.





#### Blacklist Directories
Input the blacklist directories into the blacklist directories text file. The text file is located in the repository  and named  as [blacklist.txt](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/blacklist.txt).

#### Whitelist Extensions
Input required file extensions into the whitelist extension text file. The text file is located in the repository and named  as [whitelist_ext.txt](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/whitelist_ext.txt).

You may also change the source directory and destination directories mentioned in the script to your preference to something other than the default paths provided.Details are provided below.

#### Source Directory
The default source directory from where to copy files for backup is the user's home. Change the directory as required by editing the directory path, highlighted in brackets below, on **line 8** of the  [Backup_Script.sh](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/Backup_Script.sh):

```
# MODULE 1 

# INPUT SRC DIRECTORY TO COPY FROM  --CHANGE THIS

src_dir=`ls -dR (/home/*)` 

```

### Destination Directories

Both the destination directories for the user's file backups and system critical information are created within the repository by default. Change the user's file backup directory as needed by specifying the preferred directory path in the  variable **dest_dir** on **line 17** of  [Backup_Script.sh](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/Backup_Script.sh). The path that needs to edited is highlighted between brackets below:

```
dest_dir="($repository_path/Backups)"

```

Change system-critical information directory as needed by specifying the preferred directory path in the  variable **dest_syslog** on line 162 of  [Backup_Script.sh](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/Backup_Script.sh). The path that needs to edited is hightled between brackets below:

```
dest_syslog="($repository_path/SystemLogs)"

```

## Logging
The script provides informative command-line logging during the copy process to enhance the user experience. This logging includes what directory is being copied, an indication of the copy progress, and any errors that may occur.




