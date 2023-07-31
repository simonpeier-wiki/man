# Minecraft Server Setup

This manual explains how to install, update and backup a Minecraft server on a Linux machine.

## Table of Contents
- [Components](#components)
- [Installation](#installation)
- [Update](#update)
- [Backup](#backup)

## Components

* [PaperMC](https://papermc.io/), Minecraft server software, a highly optimized fork of Spigot. All Spigot and Bukkit are compatible with paper.
* [Java](https://openjdk.java.net/), required to run Minecraft.
* [Screen](https://wiki.ubuntuusers.de/Screen/), required to run Minecraft Server in background.



## Installation

* Update and upgrade packages on server. This is not required but highly recommended, as it patches errors and bugs and may also improve the packages.

  ```bash
  apt update
  apt upgrade
  ```

* Install [Java](https://openjdk.java.net/). For Minecraft versions 1.12 through 1.17, Java 8 (or newer) is required. It is recommended to install Java 8 for these Minecraft versions, as the majority of plugins for these Minecraft versions are written in Java 8.

  ```bash
  apt install openjdk-8-jre-headless
  ```

  For Minecraft version 1.18 and up, Java 17 or newer is required. It is recommended to stick with Java 17, as it is the lates Long-Term Supported (LTS) version.

  1. Install java-common package
      ```bash
      sudo apt-get update && sudo apt-get install java-common
      ```
  2. Download the Linux .deb file
      ```bash
      wget https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.deb
      ``` 
  3. Install the .deb file
      ```bash
      sudo dpkg --install amazon-corretto-17-aarch64-linux-jdk.deb
      ```

  To verify your installation, run the following command
  ```bash
  java -version
  ```
  
* Install [Screen](https://wiki.ubuntuusers.de/Screen/). It allows to run your Minecraft Server in the background.

  ```bash
  apt install screen
  ```

* Create a new user. It is not required but recommended, as you should not run your websites and servers with the root user.

  ```bash
  sudo adduser minecraft
  ```

  When being asked for user information, you can just hit enter a couple of times as these infos are unnecessary.

* If you created a new user you need to change the current user.

  ```bash
  su minecraft
  ```

* Switch to your home directory.

  ```bash
  cd
  ```

* Install PaperMC. To check what the latest available build and Minecraft version is, go to https://papermc.io/downloads. Then copy the following template and replace `<mc-version>` with the Minecraft version and `<build-version>` with the build version.

  ```bash
  # Template
  wget https://papermc.io/api/v2/projects/paper/versions/<mc-version>/builds/<build-version>/downloads/paper-<mc-version>-<build-version>.jar
  
  # Example
  wget https://papermc.io/api/v2/projects/paper/versions/1.20.1/builds/69/downloads/paper-1.20.1-69.jar
  ```

  * To check if it was successfully installed you can list the current directory content with `ls`.

* Create a script to start the server.

  * Create the file with `touch start.sh`. This creates a new bash file named "start"
  * Paste the following command to the file:

  ```bash
  screen -AmdS minecraft java -Xms6500M -Xmx6500M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar /home/minecraft/paper-<mc-version>-<build-version>.jar nogui
  ```

  * You can check the used screen options in the in the [manual (man)](https://linux.die.net/man/1/screen).
  * The command uses some highly optimized flags from Daniel Ennis (Aikar). For more details visit his [website](https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft/).
  * It is important, that you adjust the `Xms` and `Xmx` flags to your available RAM. **Important:** Do not use all the memory, as your OS itself needs some too. E.g. if you have 8GB use around 6.5GB.

* Before starting the server for the first time, you have to accept the license agreement. To do so create a file that flags the eula as accepted.

  ```bash
  echo "eula = true" > eula.txt
  ```

* You can now start the server with your script.

  ```bash
  sh start.sh
  ```

* To stop the server you can use the following command.

  ```bash
  screen -r minecraft -X quit
  ```

  * As an alternative you can create a script to stop the server.

    ```bash
    echo "screen -r minecraft -X quit" > stop.sh
    ```

  * Stop the server with the script.

    ```bash
    sh stop.sh
    ```



## Update

* Go to https://papermc.io/downloads and check what the newest download is.

* Go to the directory on your server, where you installed the Minecraft server.

* Install the newest version on your server with wget.

  ```bash
  wget https://papermc.io/api/v2/projects/paper/versions/<mc-version>/builds/<download-version>/downloads/paper-<mc-version>-<download-version>.jar
  ```

  * Replace `<mc-version>` with the used Minecraft version e.g. 1.20.1 and `<download-version>` with the newest download e.g. 70.

* Stop the Minecraft server.

* Delete the old jar file.

* Update the Minecraft version and the build version in the start script.

* Start the server.



## Backup

* For a backup of a Minecraft world, only the world, world_nether and the world_the_end folder are required. If you use a whitelist, you should consider backing up the `whitelist.json` file as well.

* To backup, copy the necessary files into a zip folder.

  ```bash
  tar -czvf backup.tar.gz world world_nether/ world_the_end/
  ```

  * This copies the files to a zip folder called backup.

* If you want to, you can copy the backup to your local machine. To do so, open a terminal on your local machine and download the backup with scp (Secure Copy).

  ```bash
  scp minecraft@<server-ip>:/home/minecraft/backup.tar.gz ~/Downloads/
  ```

  * Replace the `<server-ip>` with the IP of your server.
  * The example downloads the backup to the Downloads folder, but you can replace it with any path.

