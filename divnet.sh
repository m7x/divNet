#!/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

show_help(){
        echo "Divide network in different host files based on running services for later brute-forcing attacks"
        echo -e "\nUsage:\n$0 -f grepable_nmap_file -o output_file_name\n"
        }

# Initialize our own variables:
while getopts "h?f:o:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    f)  file=$OPTARG
        ;;
    o)  output=$OPTARG
        ;;
    esac
done
shift $((OPTIND-1))

[ "$1" = "--" ] && shift

if [ -z "$file" ] ; then
        show_help;
        exit 1;
fi

cat $file | grep -q "445/open\|139/open"
if [ $? -eq 0 ] ; then
	echo "Windows Hosts saved in $output"_windows.txt
	cat $file | grep "445/open\|139/open" | cut -d " " -f 2 > "$output"_windows.txt
fi

cat $file | grep -q "1433/open\|1434/open"
if [ $? -eq 0 ] ; then
	echo "MSSQL   Hosts saved in $output"_mssql.txt
	cat $file | grep "1433/open\|1434/open" | cut -d " " -f 2 > "$output"_mssql.txt
fi

cat $file | grep -q "3389/open"
if [ $? -eq 0 ] ; then
	echo "RDP     Hosts saved in $output"_rdp.txt
	cat $file | grep "3389/open" | cut -d " " -f 2 > "$output"_rdp.txt
fi

cat $file | grep -q "3306/open"
if [ $? -eq 0 ] ; then
	echo "MySQL   Hosts saved in $output"_mysql.txt
	cat $file | grep "3306/open" | cut -d " " -f 2 > "$output"_mysql.txt
fi

cat $file | grep -q "22/open"
if [ $? -eq 0 ] ; then
	echo "SSH     Hosts saved in $output"_ssh.txt
	cat $file | grep "22/open" | cut -d " " -f 2 > "$output"_ssh.txt
fi

cat $file | grep -q "21/open"
if [ $? -eq 0 ] ; then
	echo "FTP     Hosts saved in $output"_ftp.txt
	cat $file | grep "21/open" | cut -d " " -f 2 > "$output"_ftp.txt
fi

cat $file | grep -q "5900/open\|5800/open"
if [ $? -eq 0 ] ; then
	echo "VNC     Hosts saved in $output"_vnc.txt
	cat $file | grep "5900/open\|5800/open" | cut -d " " -f 2 > "$output"_vnc.txt
fi
