# MODULE 2

# enables storing terminal command 
HISTFILE=~/.bash_history
set -o history

# destination directory for SystemLog backup --CHANGE THIS

dest_syslog="/home/alvi/SystemLogs"
dest_home="/home/alvi/SystemLogs/home"
usr_local="/home/alvi/SystemLogs/usr"
keyrings_dir="/home/alvi/SystemLogs/usr/share/keyrings"
sys_usr_kernel="/home/alvi/SystemLogs/proc/sys/kernel"

# variables for text files to store system critical info

sys_log="/syslog.txt"
kernel="/kernellog.txt"
apt_cache="/apt_cache_pkgs.txt"
apt_manual="/apt_manual_pkgs.txt"
snap="/snap_pkgs.txt"
conda="/conda_pkgs.txt"
history="/history.txt"




# system log
journalctl --system --since "7 days ago" > $dest_syslog$sys_log

# kernel log
journalctl -t kernel --since "7 days ago" > $dest_syslog$kernel


# list apt_packages -- CHANGE THIS
 
  #auto installed packages  
  apt-cache pkgnames > $dest_syslog$apt_cache
  
  #manually installed packages 
  apt-mark showmanual > $dest_syslog$apt_manual
  
  #snap packages
  snap list > $dest_syslog$snap
  
  #conda packages
  conda list --export > $dest_syslog$conda


# copying system config files using rsync

#/etc directory
rsync -az --progress /etc $dest_syslog

#/var directory
rsync -az --progress /var $dest_syslog

#/srv directory
rysnc -az --progress /srv $dest_syslog

 #/opt directory
rsync -az --progress /opt $dest_syslog

#/usr/local directory
rsync -az --progress /usr/local/ $usr_local

# /boot directory
rsync -az --progress /boot $dest_syslog

# /root directory
rsync -az --progress /root $dest_syslog

# for CUDA public private keys
rsync -az --progress /usr/share/keyrings $keyrings_dir

#kernel
rsync -az --progress /proc/sys/kernel $sys_usr_kernel

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
history > $dest_syslog$history
