#!/bin/sh -e
# From https://github.com/purcell/emacs.d

git clone https://github.com/cask/cask ~/.cask
PATH="$HOME/.cask/bin:$PATH"
cask upgrade
cd ~/.emacs.d
cask install

echo "Attempting startup..."
${EMACS:=emacs} -nw --batch \
                --eval '(let ((debug-on-error t)
                              (url-show-status nil)
                              (user-emacs-directory default-directory)
                              (user-init-file (expand-file-name "init.el"))
                              (load-path (delq default-directory load-path)))
                           (load-file user-init-file)
                           (run-hooks (quote after-init-hook)))'
echo "Startup successful"
