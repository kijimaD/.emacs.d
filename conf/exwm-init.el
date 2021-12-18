;; https://github.com/daviwil/emacs-from-scratch/blob/39f63fe133cd4c41e13bbd1551c6517162851411/show-notes/Emacs-Desktop-03.org

;; exwm ================
(require 'exwm)
(require 'exwm-config)

;; Automatically move EXWM buffer to current workspace when selected
(setq exwm-layout-show-all-buffers t)

;; Display all EXWM buffers in every workspace buffer list
(setq exwm-workspace-show-all-buffers t)

(setq mouse-autoselect-window nil
        focus-follows-mouse t
        exwm-workspace-warp-cursor t
        exwm-workspace-number 5)

(add-hook 'exwm-update-class-hook
          (lambda ()
            (exwm-workspace-rename-buffer exwm-class-name)))
(add-hook 'exwm-update-title-hook
          (lambda ()
            (pcase exwm-class-name
              ("qutebrowser" (exwm-workspace-rename-buffer (format "Qutebrowser: %s" exwm-title)))
              ("chrome" (exwm-workspace-rename-buffer (format "Chrome: %s" exwm-title))))))

(defun kd/set-init ()
  "Window Manager関係の各種プログラムを起動する."
  (interactive)
  (kd/set-background)
  (start-process-shell-command "compton" nil "compton -b --config ~/dotfiles/.config/compton/compton.conf")
  (start-process-shell-command "dunst" nil "dunst")
  ;; (start-process-shell-command "polybar" nil "~/dotfiles/.config/polybar/launch.sh")

  ;; org-alert
  ;; requireするとexwmのy/n選択ができないため
  (require 'org-alert)
  (setq alert-default-style 'notifications)
  (setq org-alert-interval 300)
  (setq org-alert-notification-title "Reminder")
  (org-alert-enable))

(defun kd/set-background ()
  "背景をセットする."
  (interactive)
  (start-process-shell-command "fehbg" nil "~/dotfiles/.fehbg"))

(define-key exwm-mode-map (kbd "C-M-:") 'vterm-toggle)
(define-key exwm-mode-map (kbd "C-M-<right>") 'persp-next)
(define-key exwm-mode-map (kbd "C-M-<left>") 'persp-prev)

(when window-system
  (progn
    (exwm-config-example)
    ;; (exwm-init)
    ;; (kd/set-background)
    ))
