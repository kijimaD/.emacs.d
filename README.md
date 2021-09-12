[![CI](https://github.com/kijimaD/.emacs.d/actions/workflows/test.yml/badge.svg)](https://github.com/kijimaD/.emacs.d/actions/workflows/test.yml)

# .emacs.d
Emacs settings

## package install

```shell
git clone https://github.com/cask/cask ~/.cask
PATH="$HOME/.cask/bin:$PATH"
echo 'export PATH="$HOME/.cask/bin:$PATH"' >> ~/.bash_profile

cd ~/.emacs.d
cask install
sudo apt-get install emacs-mozc cmigemo ripgrep
sudo apt-get install ttf-ancient-fonts # emoji

gem install pry pry-doc # Ruby doc server

cp eiji_utf8.txt ~/.emacs.d/ # english-japanese dictionary
```

```
M-x (all-the-icons-install-fonts)
```

## emacs27

```shell
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt --purge remove emacs27
sudo apt --purge remove emacs
sudo apt --purge remove emacs-gtk
sudo apt --purge remove emacs-common
sudo apt --fix-broken install
sudo apt autoremove
sudo apt install emacs27
emacs --version # 27
```
