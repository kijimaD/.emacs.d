;; shell設定
;; https://github.com/daviwil/emacs-from-scratch/blob/master/show-notes/Emacs-09.org
(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(add-hook 'eshell-first-time-mode-hook 'efs/configure-eshell)
(eshell-git-prompt-use-theme 'powerline)
