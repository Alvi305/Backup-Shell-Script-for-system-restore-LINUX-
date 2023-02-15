# Backup-Shell-Script-for-system-restore-LINUX-

## Description

A shell script executable on Ubuntu terminal that can copy files from the system to an external USB drive, given that the files meet certain conditions. In addition, it copies system critical information to the external drive so the system can be recovered to its former state. The script has two modules:

## Module 1: File Copy

This module copies all the files within the drives accessible from the Ubuntu OS to the connected external USB drive, but only if the following conditions are met:

•	The file is not located in a directory blacklisted in the configuration.
•	The file extension is included in a whitelist of file extensions.

The whitelist and blacklist can be easily configured by the user, and the original directory tree will be preserved during the copy process.  Additionally, informative command-line logging is provided to enhance the user experience. 

## Module 2: System Backup

This module copies system-critical information of the Ubuntu OS to the external drive so the system can be recovered to its former state even if the OS undergoes a clean reinstall after a catastrophic system failure. This information includes:

•	System configuration files
•	List of installed packages (from apt, conda, and another commonly used package manager)
•	System logs and command history.

## Usage
1.	Connect an external USB drive to your Ubuntu system.
2.	In the destination directory, the following directories will need to be made: 
     - /usr/local/
     - /usr/share/keyrings
     - /proc/sys/kernel
4.	Open a terminal window and navigate to the directory where the script is located.
5.	Run the script using the following command: `sudo ./Backup_Script.sh`. Sudo is required since it copies system critical information to destination directory.
 
## Configuration
Input required file extensions into the whitelist extension text file and the blacklist directories the blacklist directories text file. These text files are located in the repository named as [whitelist_ext.txt](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/whitelist_ext.txt) and [blacklist.txt](https://github.com/Alvi305/Backup-Shell-Script-for-system-restore-LINUX-/blob/main/blacklist.txt).
```
# destination directory for SystemLog backup --CHANGE THIS

dest_syslog="/home/alvi/SystemLogs"
dest_home="/home/alvi/SystemLogs/home"
usr_local="/home/alvi/SystemLogs/usr"
keyrings_dir="/home/alvi/SystemLogs/usr/share/keyrings"
sys_usr_kernel="/home/alvi/SystemLogs/proc/sys/kernel"

# variables for text files to store system critical info --CHANGE THIS

sys_log="/syslog.txt"
kernel="/kernellog.txt"
apt_cache="/apt_cache_pkgs.txt"
apt_manual="/apt_manual_pkgs.txt"
snap="/snap_pkgs.txt"
conda="/conda_pkgs.txt"
history="/history.txt"
```
This provides users flexibility on what to backup and what not to.

## Logging
The script provides informative command-line logging during the copy process to enhance the user experience. This logging includes what directory is being copies, indication of the copy progress and any errors that may occur.




