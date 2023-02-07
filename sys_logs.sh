#! /bin/bash

dest=`/home/alvi/Tasks/System_logs/Backup`

# system log
journalctl --system --since "7 days ago" > syslog.txt

# kernel log
journalctl -t kernel --since "7 days ago" > kernellog.txt


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

rsync -avz --progress /etc /home/alvi/Tasks/System_logs/Backup #/etc directory
rsync -avz --progress /var /home/alvi/Tasks/System_logs/Backup #/var directory
rysnc -avz --progress /srv /home/alvi/Tasks/System_logs/Backup #/srv directory
rsync -avz --progress /opt /home/alvi/Tasks/System_logs/Backup #/opt directory
rsync -avz --progress /usr/local/ /home/alvi/Tasks/System_logs/Backup #/usr/local directory
rsync -avz --progress /boot/grub/grub.cfg home/alvi/Tasks/System_logs/Backup # grub config file
rsync -avz --progress /root home/alvi/Tasks/System_logs/Backup # /root directory
rsync -avz --progress /usr/share/keyrings home/alvi/Tasks/System_logs/Backup  # for CUDA public private keys

# files in home directory 

rsync -avz --progress ~/.bashrc /home/alvi/Tasks/System_logs/Backup/home
rsync -avz --progress ~/.bash_aliases /home/alvi/Tasks/System_logs/Backup/home
rsync -avz --progress ~/.vimrc /home/alvi/Tasks/System_logs/Backup/home
rsync -avz --progress ~/task.rc /home/alvi/Tasks/System_logs/Backup/home

# for getting history of terminal commands with timestamp








