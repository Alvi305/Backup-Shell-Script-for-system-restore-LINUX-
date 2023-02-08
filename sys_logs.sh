#! /bin/bash

HISTFILE=~/.bash_history

set -o history

dest=`/home/alvi/Tasks/System_logs/Backup`

# system log
journalctl --system --since "7 days ago" > syslog.txt

# kernel log
journalctl -t kernel --since "7 days ago" > kernellog.txt

# for getting history of terminal commands with timestamps
history -a > history.txt


# list apt_packages
  #auto installed packages
  
  apt-cache pkgnames > apt_cache_pkgs.txt
  
  #manually installed packages
  
  apt-mark showmanual > apt_manual_pkgs.txt
  
  #snap packages
  
  snap list > snap_pkgs.txt
  
  #conda packages
  
  conda list --export > conda_pkgs.txt

# copying system config files

rsync -az --progress /etc /home/alvi/Tasks/System_logs/Backup #/etc directory
rsync -az --progress /var /home/alvi/Tasks/System_logs/Backup #/var directory
rysnc -az --progress /srv /home/alvi/Tasks/System_logs/Backup #/srv directory
rsync -az --progress /opt /home/alvi/Tasks/System_logs/Backup #/opt directory
rsync -az --progress /usr/local/ /home/alvi/Tasks/System_logs/Backup #/usr/local directory
rsync -az --progress /boot /home/alvi/Tasks/System_logs/Backup # /boot directory
rsync -az --progress /root /home/alvi/Tasks/System_logs/Backup # /root directory
rsync -az --progress /usr/share/keyrings /home/alvi/Tasks/System_logs/Backup  # for CUDA public private keys
rsync -az --progress /proc/sys/kernel/directory /home/alvi/Tasks/System_logs/Backup # kernel

# files in home directory 

rsync -az --progress ~/.bashrc /home/alvi/Tasks/System_logs/Backup/home
rsync -az --progress ~/.bash_aliases /home/alvi/Tasks/System_logs/Backup/home
rsync -az --progress ~/.vimrc /home/alvi/Tasks/System_logs/Backup/home
rsync -az --progress ~/task.rc /home/alvi/Tasks/System_logs/Backup/home
rsync -az --progress ~/.profile /home/alvi/Tasks/System_logs/Backup/home
rsync -az --progress ~/.xinitrc /home/alvi/Tasks/System_logs/Backup/home
rsync -az --progress ~/.gitconfig /home/alvi/Tasks/System_logs/Backup/home
rsync -az --progress ~/.ssh/config /home/alvi/Tasks/System_logs/Backup/home
rsync -az --progress ~/.profile /home/alvi/Tasks/System_logs/Backup/home
rsync -az --progress ~/.editor /home/alvi/Tasks/System_logs/Backup/home


#cp ~/.bash_history  /home/alvi/Tasks/System_logs/Backup 

