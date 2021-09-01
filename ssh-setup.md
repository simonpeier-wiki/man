# SSH

## Create new keys

To generate a new pair of SSH keys you can use the following command. Before generating the pair, please check if this is the latest and most secure technology:

#### RSA

```bash
ssh-keygen -t rsa -b 4096 -C <username>@simonpeier.net
```

#### Elliptic-curve (more secure)

```bash
ssh-keygen -t ed25519 -C <username>@simonpeier.net
```



## Copy public key to remote server

```bash
ssh-copy-id -i ~/.ssh/<public-key>.pub <username>@<server-address>
```

## SSH Config

With ssh, it is possible to add default users, so they don't have to be entered every time I want to access a server. Instead of *"ssh user@127.0.0.1"* you only need to enter *"ssh 127.0.0.1".*

To do that, one has to create a file named *config* inside the .ssh folder.

```bash
# Adds an "alias" for 127.0.0.1
Host localhost
  HostName 127.0.0.1
  
# Adds a default user for 127.0.0.1
Host 127.0.0.1
  User username
```

