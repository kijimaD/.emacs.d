(setq custom-safe-themes t)
(setq-default custom-enabled-themes '(doom-vibrant))
;; doom-acario-light
;; doom-vibrant
;; spacemacs-dark

;; https://github.com/purcell/emacs.d
;; Ensure that themes will be applied even if they have not been customized
(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes)))
  (efs/org-font-setup))

(add-hook 'after-init-hook 'reapply-themes)

;; モードライン ================
(doom-modeline-mode)

;; 表示項目の設定
(setq doom-modeline-buffer-file-name-style 'truncate-with-project)
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-minor-modes nil)
(setq doom-modeline-buffer-encoding nil)
(line-number-mode)
(column-number-mode)
(doom-modeline-def-modeline
  'my-simple-line
  '(bar matches buffer-info remote-host input-method major-mode process buffer-position)
  '(misc-info vcs checker))

;; 縦調整
(defun my-doom-modeline--font-height ()
  (- (frame-char-height) 20))
(advice-add #'doom-modeline--font-height :override #'my-doom-modeline--font-height)
(setq doom-modeline-height 10)

(defun setup-custom-doom-modeline ()
   (doom-modeline-set-modeline 'my-simple-line 'default))
(add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)

(setup-custom-doom-modeline)
