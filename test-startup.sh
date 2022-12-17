#!/bin/sh -e
# From https://github.com/purcell/emacs.d

echo "Attempting startup..."
${EMACS:=emacs} -nw --batch \
                --eval '(let ((url-show-status nil)))' \
                -l ./init.el
echo "Startup successful"
