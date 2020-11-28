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

