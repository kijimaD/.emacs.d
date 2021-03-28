[![CI](https://github.com/kijimaD/.emacs.d/actions/workflows/test.yml/badge.svg)](https://github.com/kijimaD/.emacs.d/actions/workflows/test.yml)

# .emacs.d
Emacs settings

## package install

```
git clone https://github.com/cask/cask ~/.cask
PATH="$HOME/.cask/bin:$PATH"
echo 'export PATH="$HOME/.cask/bin:$PATH"' >> ~/.bash_profile

cd ~/.emacs.d
cask install
sudo apt-get install emacs-mozc cmigemo
```

## emacs27

```
sudo add-apt-repository --remove ppa:kelleyk/emacs
sudo apt --purge remove emacs27
sudo apt --purge remove emacs
sudo apt --purge remove emacs-common
sudo apt --fix-broken install
sudo apt autoremove
sudo apt install emacs27
emacs --version
```

## connect sql

M-x `customize-variable` RET `sql-connection-alist` RET ...
M-x `sql-connect`
open buffer...
M-x `sql-mode`
M-x `sql-set-sqli-buffer` RET
`sql-send-buffer` (`C-c C-b`)
`sqlup-capitalize-keywords-in-region` (`C-c u`)
