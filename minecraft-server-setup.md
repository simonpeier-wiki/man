# Minecraft Server Setup

This manual explains how to install, update and backup a Minecraft server on a Linux (Debian) machine.

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

### Update packages

* Update and upgrade packages on server. This is not required but highly recommended, as it patches errors and bugs and may also improve the packages.

  ```bash
  apt update
  apt upgrade
  ```

### Install Java
* Install [Java](https://openjdk.java.net/). For Minecraft versions 1.12 through 1.17, Java 8 (or newer) is required. It is recommended to install Java 8 for these Minecraft versions, as the majority of plugins for these Minecraft versions are written in Java 8.

  ```bash
  apt install openjdk-8-jre-headless
  ```

  For Minecraft version 1.18 and up, Java 17 or newer is required. It is recommended to use Long-Term Supported (LTS) version. For a guide on how to install the latest, please visit the [official documentation](https://docs.papermc.io/misc/java-install) of PaperMC.

  
### Set up environment
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

### Install and set up minecraft server
* Install PaperMC. To check what the latest available build and Minecraft version is, go to their [download page](https://papermc.io/downloads). Then copy the following template and replace `<mc-version>` with the Minecraft version and `<build-version>` with the build version.

  ```bash
  # Template
  wget https://api.papermc.io/v2/projects/paper/versions/<mc-version>/builds/<build-version>/downloads/paper-<mc-version>-<build-version>.jar
  
  # Example
  wget https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/212/downloads/paper-1.21.4-212.jar
  ```

  * To check if it was successfully installed you can list the current directories content with `ls`.

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

* Go to PaperMC's [download page](https://papermc.io/downloads/paper) and check what the newest download is.

* Go to the directory on your server, where you installed the Minecraft server.

* Install the newest version on your server with wget.

  ```bash
  wget https://api.papermc.io/v2/projects/paper/versions/<mc-version>/builds/<download-version>/downloads/paper-<mc-version>-<download-version>.jar
  ```

  * Replace `<mc-version>` with the used Minecraft version e.g. 1.21.4 and `<download-version>` with the newest download e.g. 213.

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


## Recommended Plugins
The following list includes plugins, that I personally like to use on my servers to enhance the user experience with additional features: 

* [Dynmap](https://www.spigotmc.org/resources/dynmap%C2%AE.274/): A Google Maps-like map for your Minecraft server that can be viewed in a browser.
* [LuckPerms](https://www.spigotmc.org/resources/luckperms.28140/): Permissions plugin, that allows server admins to control what features players can use by creating groups and assigning permissions. It is required, for example, to give players permission to use the commands of the PlayTimes plugin.
* [PlayTimes](https://www.spigotmc.org/resources/playtimes-track-player-playtime.58858/): Allows players to view their and other players playtime on the server using custom commands.
* [Sleepmost](https://www.spigotmc.org/resources/sleep-most-1-8-1-21-x-the-most-advanced-sleep-plugin-available-percentage-animations.60623/): Allows the server admin to configure how many people have to sleep before it turns back into daytime.
* [Timber](https://www.spigotmc.org/resources/timber-1-14-%E2%87%BE-1-21-4.113160/): Quite controversial amongst players, this plugin allows to fell trees with a single axe chop.
