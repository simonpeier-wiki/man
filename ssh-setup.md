# SSH
The Secure Shell Protocol, also known as SSH, allows secure remote communication between devices on an unsecured open network. It uses a pair of keys to initiate a secure handshake between remote parties. The pair consists of a public and private key, which can be quite confusing. Think of the public key as a "lock" and the private key as the "key". You give the lock to remote parties to encrypt ("lock") the data. This data is then opened with the private key which you hold in a secure place. <br>
An example where SSH is widely used is Git. The public key is uploaded to the server (Github, Bitbucket, etc.). That's it. After that, one can clone repositories and make changes as wished.

## Generate new keys

To generate a new pair of SSH keys use one of the following commands. Before generating the pair, please check if the used encryption algorithm is still secure.

### RSA
Generates a new key pair using the RSA algorithm. It is the most widely used and supported algorithm. Larger keys will require more time to generate compared to other algorithms.

```bash
ssh-keygen -t rsa -b 4096 -C <username>@simonpeier.ch
```

### Elliptic-curve (more secure)
Generates a new key pair using the ed25519 algorithm. The algorithm is favoured by most modern cryptographic libraries and is out to replace RSA. It provides the highest level of security compared to the key length.

```bash
ssh-keygen -t ed25519 -C <username>@simonpeier.ch
```



## Copy public key to remote server

```bash
ssh-copy-id -i ~/.ssh/<public-key>.pub <username>@<server-address>
```

## SSH Config

With SSH, it is possible to add default users, so they don't have to be entered every time I want to access a server. Instead of *"ssh user@127.0.0.1"* you only need to enter *"ssh 127.0.0.1".*

To do so, one has to create a file named *config* inside the .ssh folder.

```bash
# Adds an "alias" for 127.0.0.1
Host localhost
  HostName 127.0.0.1
  
# Adds a default user for 127.0.0.1
Host 127.0.0.1
  User username
```

