#! /bin/bash


# MODULE 1 

# INPUT SRC DIRECTORY TO COPY FROM  --CHANGE THIS
src_dir=`ls -dR /home/alvi/TAKS/testfolder/*` 

# DESTINATION DIRECTORY TO COPY FILES TO
dest_dir="/home/alvi/TAKS/desttest"

 #blacklistfile   --CHANGE THIS
blacklist_file="/home/alvi/TAKS/blacklist.txt" 

#whitelist extension text file   --CHANGE THIS
whitelist_file="/home/alvi/TAKS/whitelist_ext.txt" 

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
