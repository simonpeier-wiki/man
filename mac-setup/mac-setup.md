# Mac setup

## Install [Homebrew](https://brew.sh/)

Install homebrew via terminal with the following command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

For infos about how to use it visit [docs.brew.sh](https://docs.brew.sh/)

To browse all available packages visit [formulae.brew.sh](https://formulae.brew.sh/)

## Install Applications

### Applications with brew

To install the applications via homebrew start the brew_installation.sh:

```bash
sh brew_installation.sh
```

This includes

- Firefox 
- Brave
- iTerm2
- JetBrains Toolbox
- Sublime Text
- Obsidian
- Notion
- Insomnia
- Spotify
- Rectangle
- VLC media player
- Microsoft Word
- Microsoft Powerpoint
- Microsoft Excel

### Other Applications e.g. from App Store 

- [CopyClip](https://apps.apple.com/de/app/copyclip-clipboard-history/id595191960?mt=12)
- FinderGo
- Docker
- PDFGear

## Set up ZSH

Download Oh My Zsh with `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
If you already used oh-my-zsh replace the .zshrc in the `~/` directory with the .zshrc file from your old computer.

### Custom theme (agnoster)
To use the agnoster theme, you first have to install the powerline fonts. Follow the installation guide on their [GitHub](https://github.com/powerline/fonts). Then you have to set the font in iTerm2. To do so open the preferences and go to _Profiles > Text > Font_ and select a powerline font.
To change the theme, open the iTerm2 preferences and go to _Profiles > Colors > Color Preset_ and select "Solarized".
To shorten the name, displayed at the start of each terminal line, add the following script to your .zshrc file. It excludes the device name which will result in only the username being displayed.
```bash
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}
```

### Plugins
Certain plugins require additional installation.
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions\n
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting\n
```

## Set up SSH

### Import existing keys

To import your old key pair, go to your users root directory and copy the .ssh/ directory to a drive

```bash
cp -a ~/.ssh /Volumes/<your-drive>
```

On your new device copy the directory to your users directory

```bash
cp /Volumes/<your-drive>/.ssh ~/
```

Make sure, that the file permissions are restricted:

![Permissions](permissions.png)

If they are not change them with:

```bash
chmod 600 id_rsa
chmod 644 id_rsa.pub
chmod 644 known_hosts
```

### Create new keys

To generate a new pair of SSH keys you can use the following command. Before generating the pair, please check if this is the latest and most secure technology

```bash
ssh-keygen -t ed25519 -C <username>@simonpeier.net
```

