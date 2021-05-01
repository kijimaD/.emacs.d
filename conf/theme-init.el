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

;; モードライン ================
(doom-modeline-mode)

;; 縦調整
(defun my-doom-modeline--font-height ()
  (- (frame-char-height) 20))
(advice-add #'doom-modeline--font-height :override #'my-doom-modeline--font-height)
(setq doom-modeline-height 10)

;; 表示項目の設定
(setq doom-modeline-buffer-file-name-style 'truncate-with-project)
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon nil)
(setq doom-modeline-minor-modes nil)
(line-number-mode 0)
(column-number-mode 0)
(doom-modeline-def-modeline
  'my-simple-line
  '(bar window-number matches buffer-info remote-host buffer-position)
  '(misc-info input-method major-mode process vcs checker))

(defun setup-custom-doom-modeline ()
   (doom-modeline-set-modeline 'my-simple-line 'default))
(add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)

(setup-custom-doom-modeline)
