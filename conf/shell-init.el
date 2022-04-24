;; shell設定

;; eshell ================
;; https://github.com/daviwil/emacs-from-scratch/blob/master/show-notes/Emacs-09.org
(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  ;; (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(add-hook 'eshell-first-time-mode-hook 'efs/configure-eshell)
(eshell-git-prompt-use-theme 'multiline)
(setq eshell-toggle-height-fraction 2)

(global-set-key (kbd "C-M-;") 'eshell-toggle)
(setq eshell-toggle-use-projectile-root t)

;; esh-autosuggest ================
(add-hook 'eshell-first-time-mode-hook 'esh-autosuggest-mode)
(setq esh-autosuggest-delay 0.5)

;; vterm ================
(setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
(setq vterm-toggle-scope 'project)
(setq vterm-toggle-project-root t)
(setq vterm-max-scrollback 10000)
;; toggle
(global-set-key [f9] 'vterm-toggle)
(global-set-key (kbd "C-M-:") 'vterm-toggle)
(global-set-key [C-f9] 'vterm-toggle-cd)

(setq vterm-toggle-fullscreen-p nil)
(add-to-list 'display-buffer-alist
             '((lambda(bufname _) (with-current-buffer bufname
                                    (or (equal major-mode 'vterm-mode)
                                        (string-prefix-p vterm-buffer-name bufname))))
                (display-buffer-reuse-window display-buffer-at-bottom)
                ;;(display-buffer-reuse-window display-buffer-in-direction)
                ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                ;;(direction . bottom)
                ;;(dedicated . t) ;dedicated is supported in emacs27
                (reusable-frames . visible)
                (window-height . 0.3)))
