;; https://github.com/daviwil/emacs-from-scratch/blob/39f63fe133cd4c41e13bbd1551c6517162851411/show-notes/Emacs-Desktop-03.org

;; exwm ================
(require 'exwm)
(require 'exwm-config)

;; Automatically move EXWM buffer to current workspace when selected
(setq exwm-layout-show-all-buffers t)

;; Display all EXWM buffers in every workspace buffer list
(setq exwm-workspace-show-all-buffers t)

;; Run compton
(defun kd/set-compton ()
  (interactive)
  (start-process-shell-command
   "compton" nil "compton -b --config $HOME/dotfiles/.config/compton/compton.conf"))

(when window-system
  (progn
    (exwm-config-example)
    (kd/set-compton)))
