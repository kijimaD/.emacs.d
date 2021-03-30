(setq custom-enabled-themes '(doom-wilmersdorf))
(setq custom-safe-themes t)
(setq-default custom-enabled-themes '(doom-wilmersdorf))

;; https://github.com/purcell/emacs.d
;; Ensure that themes will be applied even if they have not been customized
(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

(add-hook 'after-init-hook 'reapply-themes)
(add-hook 'after-init-hook 'powerline-default-theme)
