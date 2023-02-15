#! /bin/bash


# MODULE 1 

# INPUT SRC DIRECTORY TO COPY FROM  --CHANGE THIS

src_dir=`ls -dR /home/alvi/TAKS/testfolder/*` 

# DESTINATION DIRECTORY TO COPY FILES TO

# use relative path to script

repository_script_path=$(realpath $0)
repository_path=$(dirname $repository_script_path)

dest_dir="$repository_path/Backups"




if [ -d "$dest_dir" ];then
	echo -e "Directory already exists:$dest_dir"
else 
	mkdir -p "$dest_dir"
	echo -e "Directory created $dest_dir"
fi


# Using relative paths from script to access text files

blacklistfile_name="/blacklist.txt"
whitelistfile_name="/whitelist_ext.txt"

 #blacklistfile   
blacklist_file=$repository_path$blacklistfile_name

#whitelist extension text file   --CHANGE THIS
whitelist_file=$repository_path$whitelistfile_name

#array for holding blacklist directories
black_arr=() 

#array for whitelist file extension
white_arr=() 


# Read blklist dirs into array

while IFS= read -r line; do
	black_arr+=("$line")
done < $blacklist_file



echo -e "-------------------------------------------- "


# print out blklist directories
echo "blacklist dirs are:"

for i in ${black_arr[@]}; do
	echo $i
done

# Read whitelist exts into array
while IFS= read -r line; do
	white_arr+=("$line")
done < $whitelist_file

echo -e "-------------------------------------------- "


# print out whitelist exts
echo "whitelist extensions are:"

for k in ${white_arr[@]}; do
	echo $k
done

echo -e "------------------------------------------- "


# Check Directories With Blacklist Directories

echo -e "------------FILE COPY STARTS---------------"

for i in  $src_dir

do

  #check to see if object is a directory 
  if [ -d "$i" ];then                                           
        echo -e "$i is a directory"

    #check to see if dir is empty  
 	if [ "$(ls -A $i)" ]; then                                 
    	echo -e "$i is not empty"
    
        # if  1st depth directory is not a blacklist directory then carry on
    	if [[ ! " ${black_arr[*]} " =~ " ${i} " ]]; then 
        
    	  echo -e "$i is not blacklisted"
    
    	  echo -e "Copying required files from main and sub directories of $i....."

          # list objects in 2nd Depth Directory 
    	  for j in `ls -dR $i/*` 
    	   do
   	
             # go through whitelist extensions and copy required files while maintaining directory structure
        	for k in ${white_arr[@]};
       	     do
          		find "$j" -name "*$k" -exec cp --parents {} $dest_dir \; # --CHANGE THIS
   
     		 done #(ends whitelist extension for loop)
     
     
      
    	  done  # (ends list objects in 2nd Depth Directory loop)

     	fi # (end for blklist directory if condition)
     	
   else echo -e "$i is empty directory"
        
   fi #(end for  empty dir if condition)
 
 
   # if object is a file instead then carry out the following     
   elif [ -f "$i" ]
    then
     	echo  -e "------------------------ "
     
     	echo -e "Copying File(s) from 1st depth directory : $i"
        
        # copy files with specefic whitelist extension
     	for k in ${white_arr[@]}; 
        	do     
          		find "$i" -type f -name "*$k" -exec cp --parents {} $dest_dir \;  # --CHANGE THIS
   
        	done
       
fi #( end of whether object is dir or file if condition)
echo -e "Copying Done"
done 



# MODULE 2

# enables storing terminal command 
HISTFILE=~/.bash_history
set -o history

# destination directory for SystemLog backup 

# change to preference

dest_syslog="$repository_path/SystemLogs"

dest_home="/home"
usr_local="/usr"
keyrings_dir="/share/keyrings"
sys_usr_kernel="/proc/sys/kernel"

# variables for text files to store system critical info

sys_log="/syslog.txt"
kernel="/kernellog.txt"
apt_cache="/apt_cache_pkgs.txt"
apt_manual="/apt_manual_pkgs.txt"
snap="/snap_pkgs.txt"
conda="/conda_pkgs.txt"
history="/history.txt"

# check if directory already exists or else create directory

#dest_syslog

if [ -d "$dest_syslog" ];then
  echo "Directory already exists:$dest_syslog"
else
  mkdir -p "$dest_syslog"
  echo "Directory created:$dest_syslog"
fi

#home

if [ -d "$dest_syslog$dest_home" ];then
  echo "Directory already exists:$dest_syslog$dest_home"
else
  mkdir -p "$dest_syslog$dest_home"
  echo "Directory created:$dest_syslog$dest_home"
fi

#usr_local

if [ -d "$dest_syslog$usr_local" ];then
  echo "Directory already exists:$dest_syslog$usr_local"
else
  mkdir -p "$dest_syslog$usr_local"
  echo "Directory created:$dest_syslog$usr_local"
fi

#keysrings

if [ -d "$dest_syslog$usr_local$keyrings_dir" ];then
  echo "Directory already exists:$dest_syslog$usr_local$keyrings_dir"
else
  mkdir -p "$dest_syslog$usr_local$keyrings_dir"
  echo "Directory created:$dest_syslog$usr_local$keyrings_dir"
fi

#sys_user_kernel

if [ -d "$dest_syslog$sys_usr_kernel" ];then
  echo "Directory already exists:$dest_syslog$sys_usr_kernel"
else
  mkdir -p "$dest_syslog$sys_usr_kernel"
  echo "Directory created:$dest_syslog$sys_usr_kernel"
fi



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
rsync -az --progress /usr/local/ $dest_syslog$usr_local

# /boot directory
rsync -az --progress /boot $dest_syslog

# /root directory
rsync -az --progress /root $dest_syslog

# for CUDA public private keys
rsync -az --progress /usr/share/keyrings $dest_syslog$usr_local$keyrings_dir

#kernel
rsync -az --progress /proc/sys/kernel $dest_syslog$sys_usr_kernel

# files in home directory 

rsync -az --progress ~/.bashrc $dest_syslog$dest_home


rsync -az --progress ~/.bash_aliases $dest_syslog$dest_home


rsync -az --progress ~/.vimrc $dest_syslog$dest_home


rsync -az --progress ~/task.rc $dest_syslog$dest_home


rsync -az --progress ~/.profile $dest_syslog$dest_home


rsync -az --progress ~/.xinitrc $dest_syslog$dest_home


rsync -az --progress ~/.gitconfig $dest_syslog$dest_home


rsync -az --progress ~/.ssh/config $dest_syslog$dest_home


rsync -az --progress ~/.profile $dest_syslog$dest_home


rsync -az --progress ~/.editor $dest_syslog$dest_home


#stores history of terminal commands
history > $dest_syslog$history
