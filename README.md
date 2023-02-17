# Backup-Shell-Script-for-system-restore-LINUX-

## Description

A shell script for backing up the Ubuntu system. It has two modules:
1. a customizable full directory backup
2. a system-critical information backup


### Module 1: File Backup
Module 1 copies all files from a source directory to a destination directory ( See [Configuration — Module 1](#module-1) for customizable parameters

### Module 2: System-Critical Information Backup

Module 2 copies all system-critical information of the Ubuntu OS to a destination directory ( See [Configuration — Module 2](#module-2) for editing the path to the destination directory). This includes: 

1. System configuration files

     - All system files from the following folders:
     
        - `/etc`
        - `/var`
        - `/srv`
        - `/opt`
        - `/usr/local/`
        - `/boot`
        - `/root`
        - `/usr/share/keyrings`
        - `/proc/sys/kernel`
        
      - All the following system files from the current user account:
      
        - `.bashrc`
        - `.bash_aliases`
        - `.vimrc`
        - `task.rc`
        - `.profile`
        - `.xinitrc`
        - `.gitconfig`
        - `.ssh/config`
        - `.editor`
       
  2. List of installed packages (from apt, conda, and snap)
  
   - apt_cache_pkgs.txt: A list of all installed apt packages (manually installed packages and    automatically installed package dependencies)
   
  - apt_manual_pkgs.txt: A list of all manually installed apt packages without dependencies
  - snap_pkgs.txt: A list of all installed snap packages
  - conda_pkgs.txt: A list of all installed conda packages
  
 3. System logs and command history
 
     - syslog.txt: System logs
     - kernellog.txt: Kernel logs
     - history.txt: Terminal command history of the current user
     
  ## Configuration
  
  ### Module 1

  1. Source Directory
     
     Change the value of `src_dir` from [line 8 of Backup_Script.sh](Backup_Script.sh#L8) to the directory you would copy the files from. (Default source directory: The home directories of all user accounts)
     
 2. Destination Directory
 
    Change the value of `dest_dir` from [line 17 of Backup_Script.sh](Backup_Script.sh#L17) to the directory you would copy the files to. In most use cases, the destination directory should lie within an external drive. (Default destination directory: A subdirectory `/Backups/` will be created within this repository.)
    
3. Blacklisted subdirectories

   Edit  [`blacklist.txt`](blacklist.txt) to list the absolute paths of directories not to be copied to the destination directory. Any path that is not a subdirectory of `src_dir` will not affect the shell script.
   
   
4. Whitelisted extensions

   Edit [`whitelist_ext.txt`](whitelist_ext.txt) to list the file extensions of files to be copied to the destination directory. If all files are to be copied regardless of file extensions, replace the contents of [`whitelist_ext.txt`](whitelist_ext.txt) with a single `*`. (Default: only .py and .md files.)
   
### Module 2

1. Destination Directory

   Change the value of the variable `dest_syslog` from [line 162 of Backup_Script.sh](Backup_Script.sh#L162) to the directory where you would copy the system files to. In most use cases, the destination directory should lie within an external drive. (Default: A subdirectory `/SystemLogs/` will be created within this repository.)
   
   
## Requirements

This script can only run on a Ubuntu OS.

## Installation

No installation or compilation is required.

## How to Use
1.	Clone the repository.
2.  Edit the configuration parameters as necessary.
3.	Navigate to the repository in the terminal.
4.	Run the script with administrator privileges: `sudo ./Backup_Script.sh`.






