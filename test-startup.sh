#!/bin/sh -e
# based on https://github.com/purcell/emacs.d

echo "Attempting startup..."

${EMACS:=emacs} -nw --batch \
                --eval '(progn (setq debug-on-error t)
                               (setq url-show-status nil)
                               (setq user-emacs-directory default-directory)
                               (setq user-init-file (expand-file-name "init.el"))
                               (setq load-path (delq default-directory load-path))
                               (load-file user-init-file)
                               (run-hooks (quote after-init-hook)))'

echo "Startup successful"
