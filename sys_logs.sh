#! /bin/bash

# enables storing terminal command 
HISTFILE=~/.bash_history
set -o history

# destination directory for SystemLog backup
dest="/home/alvi/SystemLogs"
dest_home="/home/alvi/SystemLogs/home"

# system log
journalctl --system --since "7 days ago" > /home/alvi/SystemLogs/syslog.txt

# kernel log
journalctl -t kernel --since "7 days ago" > /home/alvi/SystemLogs/kernellog.txt


# list apt_packages
  #auto installed packages
  
  apt-cache pkgnames > /home/alvi/SystemLogs/apt_cache_pkgs.txt
  
  #manually installed packages
  
  apt-mark showmanual > /home/alvi/SystemLogs/apt_manual_pkgs.txt
  
  #snap packages
  
  snap list > /home/alvi/SystemLogs/snap_pkgs.txt
  
  #conda packages
  
  conda list --export > /home/alvi/SystemLogs/conda_pkgs.txt

# copying system config files

rsync -az --progress /etc $dest #/etc directory
rsync -az --progress /var $dest #/var directory
rysnc -az --progress /srv $dest #/srv directory
rsync -az --progress /opt $dest #/opt directory
rsync -az --progress /usr/local/ $dest #/usr/local directory
rsync -az --progress /boot $dest # /boot directory
rsync -az --progress /root $dest # /root directory
rsync -az --progress /usr/share/keyrings $dest # for CUDA public private keys
rsync -az --progress /proc/sys/kernel/directory $dest #kernel

# files in home directory 

rsync -az --progress ~/.bashrc $dest_home


rsync -az --progress ~/.bash_aliases $dest_home


rsync -az --progress ~/.vimrc $dest_home


rsync -az --progress ~/task.rc $dest_home


rsync -az --progress ~/.profile $dest_home


rsync -az --progress ~/.xinitrc $dest_home


rsync -az --progress ~/.gitconfig $dest_home


rsync -az --progress ~/.ssh/config $dest_home


rsync -az --progress ~/.profile $dest_home


rsync -az --progress ~/.editor $dest_home


#stores history of terminal commands
history > /home/alvi/SystemLogs/history.txt

