#! /bin/bash

# MODULE 1

echo -e "This is for testing purpose"

src=`ls -dR /home/alvi/TAKS/testfolder/*` # INPUT SRC DIRECTORY TO COPY FROM --CHANGE THIS

file="/home/alvi/TAKS/blacklist.txt"  #blacklistfile - CHANGE THIS
file2="/home/alvi/TAKS/whitelist_ext.txt" #whitelist extension text file  --CHANGE THIS

blk_arr=() #array for holding blacklistfiles
white_arr=() #array for whitelist file extension


# Read blklist dirs into array
while IFS= read -r line; do
	blk_arr+=("$line")
done < $file

echo -e "-------------------------------------------- "


# print out blklist directories
echo "blacklist dirs are:"

for i in ${blk_arr[@]}; do
	echo $i
done

# Read whitelist exts into array
while IFS= read -r line; do
	white_arr+=("$line")
done < $file2

echo -e "-------------------------------------------- "


# print out whitelist exts
echo "whitelist extensions are:"

for k in ${white_arr[@]}; do
	echo $k
done

echo -e "------------------------------------------- "


#see if subdirectories of pwd matches with blklist dirs

echo -e "------------FILE COPY STARTS---------------"

for i in  $src

do
 
  if [ -d "$i" ];then
        echo -e "$i is a directory"
 
 	if [ "$(ls -A $i)" ]; then # check to see if dir is empty 
    	echo -e "$i is not empty"
    
    
    	if [[ ! " ${blk_arr[*]} " =~ " ${i} " ]]; then # if  1st depth directory is not a blacklist directory then
        
    	  echo -e "$i is not blacklisted"
    
    	  echo -e "Copying required files from main and sub directories of $i....."
    
    	  for j in `ls -dR $i/*` # check 2nd depth of subdirectory 
    	   do
   	
        	for k in ${white_arr[@]}; # go through whitelist extensions
       	 do
          		find "$j" -name "*$k" -exec cp --parents {} /home/alvi/TAKS/desttest \; # --CHANGE THIS
   
     		 done # whitelist extension
     
     
      
    	  done  # for 2nd depth of directory

     	fi # blklist if condition
     	
   else echo -e "$i is empty directory"
        
   fi # empty dir if condition
 
 
         
   elif [ -f "$i" ]
    then
     	echo  -e "------------------------ "
     
     	echo -e "Copying File(s) from 1st depth directory : $i"
     
     	for k in ${white_arr[@]}; # go through whitelist extensions
        	do     
          		find "$i" -type f -name "*$k" -exec cp --parents {} /home/alvi/TAKS/desttest \;
   
        	done
       
fi #dir or file if condition
echo -e "Copying Done"
done 




# MODULE 2

# enables storing terminal command 
HISTFILE=~/.bash_history
set -o history

# destination directory for SystemLog backup --CHANGE THIS

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
