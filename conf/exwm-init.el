;; https://github.com/daviwil/emacs-from-scratch/blob/39f63fe133cd4c41e13bbd1551c6517162851411/show-notes/Emacs-Desktop-03.org

;; exwm ================
(require 'exwm)
(require 'exwm-config)

;; not ask replace other wm
(setq exwm-replace t)

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
  (progn
    (call-process-shell-command "shepherd")
    (call-process-shell-command "~/dotfiles/.config/polybar/launch.sh")

    (exwm-workspace-switch-create 2)
    (start-process-shell-command "google-chrome" nil "google-chrome")
    (start-process-shell-command "spotify" nil "spotify")
    (sleep-for 2)

    (exwm-workspace-switch-create 0)
    (persp-switch "1")
    (org-journal-new-entry nil)
    (vterm-toggle)
    (vterm-toggle)
    (persp-switch "2")
    (find-file "~/roam")
    (vterm-toggle)
    (vterm-toggle)
    (org-agenda nil "z")
    (magit-status)
    (persp-switch "3")
    (split-window-right)
    (switch-to-buffer "Google-chrome")
    (vterm-toggle)
    (vterm-toggle)
    (persp-switch "4")
    (switch-to-buffer "Google-chrome")
    (persp-switch "5")
    (find-file "~/dotfiles")
    (vterm-toggle)
    (vterm-toggle)
    (magit-status)
    (persp-switch "6")
    (find-file "~/.emacs.d")
    (vterm-toggle)
    (vterm-toggle)
    (magit-status)
    (persp-switch "7")
    (find-file "~/ProjectOrg")
    (persp-switch "8")
    (find-file "~/Project")

    (exwm-workspace-switch-create 1)
    (persp-switch "1")
    (org-journal-new-entry nil)
    (persp-switch "2")
    (find-file "~/roam")
    (org-agenda nil "z")
    (persp-switch "4")
    (switch-to-buffer "Google-chrome")
    (persp-switch "8")
    (find-file "~/Project")

    (exwm-workspace-switch-create 2)
    (switch-to-buffer "Spotify")

    (exwm-workspace-switch-create 0)))

(defun kd/set-background ()
  "背景をセットする."
  (interactive)
  (start-process-shell-command "compton" nil "compton -b --config ~/dotfiles/.config/compton/compton.conf")
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

;; polybar================
(defvar kd/polybar-process nil
  "Holds the process of the running Polybar instance, if any")

(defun kd/kill-panel ()
  (interactive)
  (when kd/polybar-process
    (ignore-errors
      (kill-process kd/polybar-process)))
  (setq kd/polybar-process nil))

(defun kd/start-panel ()
  (interactive)
  (kd/kill-panel)
  (setq kd/polybar-process (start-process-shell-command "polybar" nil "~/dotfiles/.config/polybar/launch.sh")))
;; Not working...

(defun kd/polybar-exwm-workspace ()
  (pcase exwm-workspace-current-index
    (0 "%{F#797D7F}Work%{F-} Home")
    (1 "Work %{F#797D7F}Home%{F-}")
    (2 "")
    (3 "")
    (4 "")))

(defun kd/send-polybar-hook (module-name hook-index)
  (start-process-shell-command "polybar-msg" nil (format "polybar-msg hook %s %s" module-name hook-index)))

(defun kd/send-polybar-exwm-workspace ()
  (kd/send-polybar-hook "exwm-workspace" 1))

;; Update panel indicator when workspace changes
(add-hook 'exwm-workspace-switch-hook #'kd/send-polybar-exwm-workspace)
