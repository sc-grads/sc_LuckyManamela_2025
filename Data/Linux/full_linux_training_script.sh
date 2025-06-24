#!/bin/bash

# ==========================================================
# COMBINED LINUX COMMANDS TRAINING SCRIPT
# Author: Lucky Manamela
# Description: This script demonstrates essential Linux
#              commands organized by topic.
# ==========================================================



# ==========================================================
# SECTION: Intro Shell
# ==========================================================

# Introduction to the Linux Shell

# The shell is a command-line interface to interact with the OS
pwd  # Print current working directory
whoami  # Show current user


# ==========================================================
# SECTION: Users
# ==========================================================

# Types of Users in Linux

whoami  # Show current user
sudo -l  # List available sudo commands
su -  # Switch to root or another user


# ==========================================================
# SECTION: Navigate Fs
# ==========================================================

# Navigating the Filesystem

pwd
cd ~  # Home directory
cd ..  # Up one directory
cd -  # Previous directory


# ==========================================================
# SECTION: List Files
# ==========================================================

# Listing and Understanding Files

ls -l  # Long listing format
ls -a  # Show hidden files
ls -lh  # Human-readable sizes


# ==========================================================
# SECTION: Directories
# ==========================================================

# Working with Directories

mkdir my_folder # Creating a folder
rmdir my_folder # Removing a folder (Note this command rmdir cannot be used if the folder contains content) 
rm -rf my_folder # Used to remove folders that contains content (removing a folder recursively)


# ==========================================================
# SECTION: File Content
# ==========================================================

# Viewing and Manipulating File Content

cat file.txt           # Display the full content of the file
head file.txt          # Show the first 10 lines of the file
tail file.txt          # Show the last 10 lines of the file
echo 'Hello' > file.txt  # Write 'Hello' to file.txt, replacing existing content
echo 'World' >> file.txt # Append 'World' to file.txt without deleting existing content


# ==========================================================
# SECTION: Man Pages
# ==========================================================

# Understanding and Using Man Pages

man ls                 # Open the manual page for the 'ls' command
man -k search          # Search the manual page database for 'search'
ls --help              # Display help options for the 'ls' command


# ==========================================================
# SECTION: Env Path
# ==========================================================

# Environment Variables and the PATH

echo $PATH             # Display the current PATH environment variable
export MYVAR='value'   # Create a new environment variable named MYVAR
echo $MYVAR            # Print the value of MYVAR


# ==========================================================
# SECTION: Help Linux
# ==========================================================

# Getting Help in Linux

man command            # Open the manual page for a specified command
command --help         # Display help options for a command (if supported)
which ls               # Show the full path of the 'ls' command
man -k keyword         # Search the manual pages for a specific keyword


# ==========================================================
# SECTION: Web Browsers
# ==========================================================

# Browsing the Web from Terminal

links https://example.com  # Open website using the 'links' text browser
lynx https://example.com   # Open website using the 'lynx' text browser
w3m https://example.com    # Open website using the 'w3m' text browser


# ==========================================================
# SECTION: Compare Files
# ==========================================================

# Comparing Files

diff file1 file2       # Compare file1 and file2 line by line
sdiff file1 file2      # Show a side-by-side comparison of file1 and file2
vimdiff file1 file2    # Open both files in vim showing differences highlighted


# ==========================================================
# SECTION: Io Redirection
# ==========================================================

# Input/Output and Redirection

echo 'Text' > file.txt       # Overwrite file.txt with 'Text'
echo 'More' >> file.txt      # Append 'More' to file.txt
wc -l < file.txt             # Count number of lines in file.txt using input redirection
command > out.txt 2>&1       # Redirect both stdout and stderr of a command to out.txt


# ==========================================================
# SECTION: File Ops
# ==========================================================

# Working with Files

cp file1 file2           # Copy contents of file1 to file2
mv old.txt new.txt       # Rename or move old.txt to new.txt
rm file.txt              # Delete file.txt
sort data.txt | uniq     # Sort lines in data.txt and remove duplicates


# ==========================================================
# SECTION: Gui Editors
# ==========================================================

# Graphical Editors

gedit file.txt           # Open file.txt using the Gedit graphical editor
emacs file.txt           # Open file.txt in the Emacs editor (GUI or terminal-based)
kate file.txt            # Open file.txt using the Kate editor (KDE-based)

# ==========================================================
# SECTION: Find Files
# ==========================================================

# Finding Files and Directories

find . -name 'file.txt'     # Search recursively for file.txt from the current directory
locate passwd               # Quickly find files using indexed database (requires updatedb)


# ==========================================================
# SECTION: Permissions
# ==========================================================

# Understanding Permissions and Umask

ls -l                       # Show detailed file permissions and attributes
chmod 755 script.sh         # Set permissions to rwxr-xr-x (owner can write, others can read/execute)
umask 022                   # Set default permissions (files: 644, dirs: 755)


# ==========================================================
# SECTION: Aliases
# ==========================================================

# Using Aliases

alias cls='clear'           # Create alias 'cls' to run 'clear'
unalias cls                 # Remove alias 'cls'
alias                       # List all current aliases


# ==========================================================
# SECTION: Prompt
# ==========================================================

# Customizing the Shell Prompt

export PS1="[\u@\h \W]\\$ "  # Customize prompt to show [user@host current-dir]$


# ==========================================================
# SECTION: Transfer Network
# ==========================================================

# Transferring and Copying Files Over the Network

scp file user@host:/dest     # Securely copy 'file' to remote host
sftp user@host               # Open secure FTP session to host
ftp host                     # Start traditional FTP session (not secure)


# ==========================================================
# SECTION: Scp Sftp
# ==========================================================

# SCP and SFTP Clients

# Use GUI tools like FileZilla, WinSCP, or Cyberduck to transfer files using SCP/SFTP protocols.
# These allow drag-and-drop and visual management.


# ==========================================================
# SECTION: Search Pipes
# ==========================================================

# Searching in Files and Using Pipes

grep 'pattern' file.txt       # Search for lines containing 'pattern' in file.txt
cat file | grep bob | cut -d: -f1 | sort  # Find entries with 'bob', extract username field, sort


# ==========================================================
# SECTION: Install Software
# ==========================================================

# Installing Software and Managing Packages

sudo apt update               # Refresh available package list
sudo apt install nginx        # Install NGINX web server
sudo apt remove nginx         # Uninstall NGINX


# ==========================================================
# SECTION: History
# ==========================================================

# Shell History and Autocompletion

history                       # Show command history
!!                            # Repeat last command
!grep                         # Repeat last command starting with 'grep'
!$                            # Use last argument of previous command


# ==========================================================
# SECTION: Switch Users
# ==========================================================

# Switching Users and Running Commands as Others

whoami                        # Show current username
sudo command                  # Run a command with root privileges
su - otheruser                # Switch to another user account


# ==========================================================
# SECTION: Cron Jobs
# ==========================================================

# Scheduling Repeated Jobs with Cron

crontab -e                    # Edit crontab file for current user
echo '0 * * * * /script.sh' | crontab -  # Run /script.sh every hour on the hour


# ==========================================================
# SECTION: Processes
# ==========================================================

# Managing Processes and Jobs

ps -ef                        # Show all running processes in full detail
top                           # Show real-time resource usage and process info
bg                            # Resume a suspended job in the background
fg                            # Bring a background job to the foreground
jobs                          # List background jobs
kill -9 PID                   # Force kill a process using its PID


# ==========================================================
# SECTION: Wordpress
# ==========================================================

# Installing WordPress on Ubuntu

sudo apt install nginx php mysql-server  # Install web server, PHP, and MySQL
curl -O https://wordpress.org/wordpress-5.6.tar.gz  # Download WordPress archive
tar xvf wordpress-5.6.tar.gz              # Extract WordPress contents