#!/bin/bash

echo "This script allows U to do the check the states of ports of specified program, make whois requests"
read -p "Enter the process name or PID: " process_name
#Change the process name to lowercase
process_name="${process_name,,}"
read -p "Please enter the amount of lines for output (1 to 99): " lines
reg='^[0-9]{1,2}$' #Accept only numbers from 0 till 99
while [[ ! $lines =~ $reg ]]; do
  echo "Wrong answer, enter the value from 1 to 99: "
  read lines
done

#Checking the input of user, regarding additional states of connections
while true; do
  read -p "Do U want to view additional states of connections? (yes/no)" yn
  case $yn in
  [Yy]*)
    add_states="y"
    break
    ;;
  [Nn]*)
    add_states="n"
    break
    ;;
  *) echo "Please answer yes or no" ;;
  esac
done

#Checking the input of user, regarding should the program run with sudo privileges
while true; do
  read -p "Do U want to run the program with sudo privileges? (yes/no)" yn
  case $yn in
  [Yy]*)
    run_as_admin="y"
    break
    ;;
  [Nn]*)
    run_as_admin="n"
    break
    ;;
  *) echo "Please answer yes or no." ;;
  esac
done

#Standart whois filter
whois_filter="^Organization"

#functions, which shows U additinal states of ports of specified program
function show_add_info {
  echo "U can find the other states of connection at the below table"
  netstat -tunapl | awk '/'$process_name'/ ''{print $5 "             " $6}'
  echo -e "_________________________________________________________________\n"
}

#function, which shows information by whois service
function show_whois {
  if [[ "$run_as_admin" == "y" ]]; then
    echo "Enter your admin credentials"
    sudo netstat -tunapF | awk '/'$process_name'/ ''{print $5}' |
      cut -d: -f1 | sort | uniq -c | sort | tail -n"$lines" | grep -oP '(\d+\.){3}\d+' | while read IP; do whois $IP |
        awk -F':' '/'$whois_filter'/ ''{print $2}'; done | uniq -c
  else
    netstat -tunapF | awk '/'$process_name'/ ''{print $5}' |
      cut -d: -f1 | sort | uniq -c | sort | tail -n"$lines" | grep -oP '(\d+\.){3}\d+' | while read IP; do whois $IP |
        awk -F':' '/'$whois_filter'/ ''{print $2}'; done | uniq -c
  fi
}

if [[ "$add_states" == "y" ]]; then
  show_add_info
  read -p 'Press [Enter] to continue...'
  show_whois
else
  show_whois
fi

#Allow u to make another whois request by another filter
while true; do
  read -p "Would U like to process the same whois request, but by different filter? (y/n) " yn
  case $yn in
  [Yy]*)
    run_again="y"
    break
    ;;
  [Nn]*)
    run_again="n"
    break
    ;;
  *) echo "Please answer yes or no" ;;
  esac
done

if [[ "$run_again" == "y" ]]; then
  read -p "Enter new whois text filter: " whois_filter
  show_whois
fi
