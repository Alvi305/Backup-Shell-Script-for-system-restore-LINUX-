#! /bin/bash

echo -e "This is for testing purpose"




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

for i in  `ls -dR /home/alvi/Tasks/testfolder/ImageNetModel/*`

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
    
    
    for j in `ls -dR $i/*` # check 2nd depth of subdirectory 
    do
    echo -e " 2nd depth dir $j"
    
     #if [ -d "$j" ]; then
        for k in ${white_arr[@]}; # go throu
        do
        
          echo -e "copying files with $k extension"   
          echo "$j"
          find "$j" -name "*$k" -exec cp --parents {} ~/Tasks/desttest \;
   
        done
      #fi
      
    done 

     fi
        
  fi
 
     
     
    #done
    #cd ..

   
    elif [ -f "$i" ]
 then
     echo  -e "------------------------ "
     echo -e "COPYING FILE $i... "
     #cp -R "$i" /home/alvi/Tasks/desttest
   
fi
       
done 

