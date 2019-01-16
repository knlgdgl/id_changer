#!/system/bin/sh
path=/data/system/users/0/settings_ssaid.xml

grep -o -n 'package="[a-zA-Z\.]*"*' $path
printf "\nSelect package : "
read p_num
printf "\nCurrent ID is : "
curr_id=$(sed -n "$p_num"p $path | grep -o 'value="[a-zA-Z0-9]*"*' | cut -d '"' -f2)
printf $curr_id

printf "\n\n1)Custom ID\n2)Random ID\nEnter choice : "
read ch
case $ch in
  1 )
    printf "\nEnter new ID : "
    read new_id
    sed -i -e "s/$curr_id/$new_id/g" $path
    printf "\nNew ID set!\n"
    ;;
  2 )
    printf "\nGenerating random ID..."
    new_id=$(dd if=/dev/urandom count=256 bs=1 | tr -dc 'a-z0-9' | fold -w 16 | head -n 1)
    printf "\nNew ID is : $new_id"
    sed -i -e "s/$curr_id/$new_id/g" $path
    printf "\nNew id set!\n"
    ;;
esac
