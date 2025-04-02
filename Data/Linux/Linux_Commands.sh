#!/bin/bash

# basic Bash script to learn common Linux commands

# Print the current working directory
echo "Current directory:"
pwd  # 'pwd' stands for 'print working directory'

# List all files and directories in the current folder
echo "List of files and directories:"
ls -l  # '-l' option lists in long format

# Create a new directory
echo "Creating a directory named 'my_folder'..."
mkdir my_folder  # 'mkdir' stands for 'make directory'

# Change into that directory
cd my_folder  # 'cd' stands for 'change directory'

# Create a new empty file
echo "Creating a file named 'hello.txt'..."
touch hello.txt  # 'touch' creates an empty file or updates timestamps

# Write some text into the file
echo "Hello, Linux World!" > hello.txt  # '>' redirects text into the file

# Display the contents of the file
echo "Contents of hello.txt:"
cat hello.txt  # 'cat' displays file contents

# Append more text to the file
echo "Appending more text to hello.txt..."
echo "Welcome to Bash scripting." >> hello.txt  # '>>' appends to a file

# Show the new contents of the file
cat hello.txt

# Move the file to a new name
echo "Renaming the file to 'welcome.txt'..."
mv hello.txt welcome.txt  # 'mv' moves or renames files

# Copy the file
echo "Copying 'welcome.txt' to 'copy_welcome.txt'..."
cp welcome.txt copy_welcome.txt  # 'cp' copies files

# Delete the copy
echo "Deleting 'copy_welcome.txt'..."
rm copy_welcome.txt  # 'rm' removes files

# Go back to the previous directory
cd ..

# Remove the created directory and its contents
echo "Cleaning up by deleting 'my_folder'..."
rm -r my_folder  # '-r' removes directories and their contents

echo "All done! You just learned basic Bash commands in Linux."
