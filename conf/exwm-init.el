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

(defun kd/set-background ()
  (interactive)
  (start-process-shell-command
   "compton" nil "compton -b --config $HOME/dotfiles/.config/compton/compton.conf")
  (start-process-shell-command
   "fehbg" nil "~/dotfiles/.fehbg"))

;; (when window-system
;;   (progn
;;     (exwm-init)
;;     (kd/set-background)))
