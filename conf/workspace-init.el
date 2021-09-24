;; workspace
(require 'perspective)
(setq persp-initial-frame-name "1")
(setq persp-modestring-dividers '("" "" " "))
(persp-mode 1)

;; ワークスペース生成
(mapc (lambda (i)
        (persp-switch (int-to-string i)))
      (number-sequence 1 9))

(persp-switch "1")

(defun local-switch-workspace (index)
  `(lambda ()
     (interactive)
     (persp-switch (int-to-string ,index))))

;; キーバインドの登録を行う
(mapc (lambda (i)
        (global-set-key (kbd (format "M-%d" i)) (local-switch-workspace i))
        (define-key exwm-mode-map (kbd (format "M-%d" i)) (local-switch-workspace i)))
      (number-sequence 1 9))

(global-set-key (kbd "C-M-<right>") 'persp-next)
(global-set-key (kbd "C-M-<left>") 'persp-prev)
