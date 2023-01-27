#! /bin/bash

echo -e "This is for testing purpose"

src=`ls -dR /home/alvi/Tasks/testfolder/ImageNetModel/*` # INPUT SRC DIRECTORY TO COPY FROM

file="/home/alvi/Tasks/blacklist.txt"  #blacklistfile
file2="/home/alvi/Tasks/whitelist_ext.txt" #whitelist extension text file

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
 
if [ -d "$i" ]
then
 echo -e "$i is a directory"
 
 #cd "$i"
 #echo -e "inside $i"
 
 if [ "$(ls -A $i)" ]; then # check to see if dir is empty 
    echo -e "$i is not empty"
    
    
    if [[ ! " ${blk_arr[*]} " =~ " ${i} " ]]; then # if  1st depth directory is not a blacklist directory then
     
    #cd "$i"
    #echo -e "inside $i"
    echo -e "$i is not blacklisted"
    
    echo -e "Copying required files from main and sub directories of $i....."
    
    for j in `ls -dR $i/*` # check 2nd depth of subdirectory 
    do
    #echo -e " Copying files from 2nd depth dir $j ...."
    
     #if [ -d "$j" ]; then
        for k in ${white_arr[@]}; # go through whitelist extensions
        do
        
         
          find "$j" -name "*$k" -exec cp --parents {} ~/Tasks/desttest \;
   
     done # whitelist extension
     
     
      
    done  # for 2nd depth of directory

     fi # blklist if condition
        
  fi # empty dir if condition
 
 
         
    elif [ -f "$i" ]
 then
     echo  -e "------------------------ "
     
     echo -e "Copying File(s) from 1st depth directory : $i"
     
     for k in ${white_arr[@]}; # go through whitelist extensions
        do     
          find "$i" -type f -name "*$k" -exec cp --parents {} ~/Tasks/desttest \;
   
        done
       
fi #dir or file if condition
       
done 

