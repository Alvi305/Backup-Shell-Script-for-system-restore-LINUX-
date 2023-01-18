#! /bin/bash

echo -e "This is for testing purporse"

file="/home/alvi/Tasks/blacklist.txt"  #blacklistfile
file2="/home/alvi/Tasks/whitelist_ext.txt" #whitelist extension text file

blk_arr=() #array for holding blacklistfiles
white_arr=() #array for whitelist file extension


#Read blklist dirs into array
while IFS= read -r line; do
	blk_arr+=("$line")
done < $file

echo -e "-------------------------------------------- "


echo "blacklist dirs are:"

for i in ${blk_arr[@]}; do
	echo $i
done

#Read whitelist exts into array
while IFS= read -r line; do
	white_arr+=("$line")
done < $file2

echo -e "-------------------------------------------- "


echo "whitelist extensions are:"

for k in ${white_arr[@]}; do
	echo $k
done

echo -e "------------------------------------------- "

#see if subdirectories of pwd matches with blklist dirs

echo -e "------------FILE COPY STARTS---------------"

for i in  `ls -d /home/alvi/Tasks/testfolder/ImageNetModel/*`

do
 
if [ -d "$i" ]
then
 echo "$i is a directory"
 
 #cd "$i"
 #echo -e "inside $i"
 
 if [ "$(ls -A $i)" ]; then
    echo "$i is not empty"
    fi
    
    if [[ ! " ${blk_arr[*]} " =~ " ${i} " ]]; then
     
    cd "$i"
    echo -e "inside $i"
    fi
    
    
    
    for j in `ls -d $i/*`
    do
    echo -e "$j"
     if [ -f "$j" ]; then
        for k in ${white_arr[@]};
        do
         find "$i" -name '*$k' -execdir cp --parents  '{}' '/home/alvi/Tasks/desttest' && echo -e "COPYING $j..." ';'
        done
        fi
     
    done
    cd ..

     
    elif [ -f "$i" ]
 then
     echo  -e "------------------------ "
     echo -e "COPYING FILE $i... "
     #cp -R "$i" /home/alvi/Tasks/desttest
     
fi  
done 

