# Bash Cheatsheet

## Pipes

```bash
a | b # pipe: inject a command output into b command input
a > file.txt # save output of command a into file.txt (overwrite)
a >> file.txt # save output of command a into file.txt (append)
echo "Hello!" | xargs echo # injects the output of the first command as an argument of the second command
```

## Search for files

```bash
ind . -name hello.txt # finds a file called "hello.txt" in the current directory
find /home/joe/Downloads -name *.pdf # finds PDF files in the Downloads folder
find / -executable -atime -10 # find an executable file in the root directory that was accessed less than 10 minutes ago
find ~ -newer reference.txt # find a file in the home directory edited after the file "reference.txt"
```

## Running Processes

```bash
ps # shows the processes running right now on this terminal session
ps aux # shows all the processes running on the computer
htop # display an activity monitor in the termina
```

## Change Users

```bash
su # change current user to root
su - # change current user and local variables to root
su maria # change current user to "maria"
sudo nano # runs command "nano" as root user
```

## Download a file

```bash
wget https://somewebpage.com/somefile.zip # download the file hosted in the specified URL to the current directory
```

## Read files

```bash
# grep: filter by lines
grep 455 sales.txt # print the lines where there is a 455

# cut: show some columns
cut -f 3 sales.txt # print only the third column
cut -f 2-3 sales.txt # print only the 2nd and 3rd columns
cut -c 9-19 sales.txt # for each line, print only from the 9th to the 19th character
cut -f 1 -d ';' clients.txt # the file clients.txt uses ';' as delimiter, instead a tab

# awk: the same than cut, but more flexible with delimiters, with more filters, and more computacionally complex
awk '{print $3}' sales.txt # print only the 3rd column
awk '{print $2 ", " $3}' sales.txt # print the 2nd and 3rd columns, separated with a comma
awk '{print $2 + $3}' sales.txt # print the sum of the 2nd and 3rd columns
awk 'length($0) > 20' sales.txt # print those lines whose length is longer than 20 characters
awk '$2 > 100' sales.txt # print those lines where the value of the second column is greater than 100

# wc
wc sales.txt # print the number of lines, words, and characters in the text file
ls -1 | wc # print the number of lines, words, and characters for each of the files in the current directory

# sort: sort the lines of a file according an alphabetic criteria
sort sales.txt # sort the lines of the file
sort -r sales.txt # sort the lines in reverse order
sort -R sales.txt # sort the lines in random order
sort -t $'\t' -k 3n,3 sales.txt # sort the lines numerically according the 3rd column

# uniq: shows the consecutive non-repeated or duplicated lines of a file
uniq hello.txt # skips consecutive duplicated lines
uniq -d hello.txt # show only consecutive duplicated lines
uniq -u hello.txt # show only lines that are not duplicated
uniq -c hello.txt # for each line, show the number of times it is duplicated
```

## Random Commands

```bash
uname -a # shows info about the system (kernel, architecture...)
sudo lshw # (only Linux) list all the hardware components
sudo lshw -short # (only Linux) list a summary table with the hardware components
lscpu # (only Linux) show information about the CPU
lsusb # (only Linux) list the plugged USB devices
date # print the current date and time
sha256sum file.txt # calculate the SHA256 checksum for a file
```

