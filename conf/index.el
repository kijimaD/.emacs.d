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
        eshell-scroll-to-bottom-on-input t
        eshell-git-prompt-use-theme 'multiline
        eshell-toggle-height-fraction 2
        eshell-toggle-use-projectile-root t))
(add-hook 'eshell-first-time-mode-hook 'efs/configure-eshell)

(global-set-key (kbd "C-M-;") 'eshell-toggle)

(add-hook 'eshell-first-time-mode-hook 'esh-autosuggest-mode)
(setq esh-autosuggest-delay 0.5)

(when window-system
  (require 'vterm)
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
                 (window-height . 0.3))))

(require 'doom-themes)
(doom-themes-org-config)
(setq custom-safe-themes t)
(setq-default custom-enabled-themes '(modus-operandi))

(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes)))
  (efs/org-font-setup)
  ;; (kd/set-modus-face)
  )

(add-hook 'after-init-hook 'reapply-themes)

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
(setq doom-modeline-height 20)

(defun setup-custom-doom-modeline ()
  (doom-modeline-set-modeline 'my-simple-line 'default))
(add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)

(setup-custom-doom-modeline)

(defun kd/set-modus-face ()
  (setq modus-themes-slanted-constructs t
        modus-themes-bold-constructs t
        modus-themes-no-mixed-fonts t
        modus-themes-subtle-line-numbers t
        modus-themes-mode-line '(moody borderless)
        modus-themes-syntax 'faint
        modus-themes-paren-match 'intense-bold
        modus-themes-region 'bg-only
        modus-themes-diffs 'deuteranopia
        modus-themes-org-blocks 'gray-background
        modus-themes-variable-pitch-ui t
        modus-themes-variable-pitch-headings t
        modus-themes-scale-headings t
        modus-themes-scale-1 1.1
        modus-themes-scale-2 1.15
        modus-themes-scale-3 1.21
        modus-themes-scale-4 1.27
        modus-themes-scale-title 1.33)

  (set-face-foreground 'vertical-border "gray")

  (set-face-attribute 'mode-line nil
                      :background nil
                      :overline "black"
                      :underline nil
                      :box nil)

  (set-face-attribute 'mode-line-inactive nil
                      :background "white"
                      :overline "gray"
                      :underline nil
                      :box nil)

  (window-divider-mode 0))

(kd/set-modus-face)

(setq my-hidden-minor-modes
      '(
        abbrev-mode
        auto-highlight-symbol-mode
        auto-revert-mode
        back-button-mode
        beacon-mode
        command-log-mode
        ctags-auto-update-mode
        eldoc-mode
        flyspell-mode
        global-whitespace-mode
        google-this-mode
        highlight-indent-guides-mode
        magit-auto-revert-mode
        projectile-mode
        projectile-rails-mode
        rinari-minor-mode
        robe-mode
        rubocop-mode
        ruby-electric-mode
        undo-tree-mode
        which-key-mode
        yas-minor-mode
        ))
(mapc (lambda (mode)
        (setq minor-mode-alist
              (cons (list mode "") (assq-delete-all mode minor-mode-alist))))
      my-hidden-minor-modes)

(require 'exwm)
(require 'exwm-config)

(setq exwm-replace t)

(setq exwm-layout-show-all-buffers t)

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
    (call-process-shell-command "blueberry")

    (exwm-workspace-switch-create 2)
    (start-process-shell-command "google-chrome" nil "google-chrome")
    (start-process-shell-command "firefox" nil "firefox")
    (start-process-shell-command "spotify" nil "spotify")

    (message "please wait...")
    (sleep-for 2)

    (exwm-workspace-switch-create 0)
    (persp-switch "1")
    (delete-other-windows)
    (org-journal-new-entry nil)
    (vterm-toggle)
    (vterm-toggle)
    (persp-switch "2")
    (find-file "~/roam")
    (vterm-toggle)
    (vterm-toggle)
    (org-agenda nil "z")
    (persp-switch "3")
    (split-window-right)
    (switch-to-buffer "firefox")
    (persp-switch "4")
    (switch-to-buffer "firefox")
    (vterm-toggle)
    (vterm-toggle)
    (persp-switch "5")
    (find-file "~/dotfiles")
    (vterm-toggle)
    (vterm-toggle)
    (magit-status)
    (persp-switch "6")
    (find-file "~/.emacs.d/conf")
    (vterm-toggle)
    (vterm-toggle)
    (magit-status)
    (persp-switch "7")
    (find-file "~/ProjectOrg")
    (persp-switch "8")
    (find-file "~/Project")
    (persp-switch "9")
    (elfeed)

    (exwm-workspace-switch-create 1)
    (persp-switch "1")
    (persp-switch "2")
    (find-file "~/roam")
    (org-agenda nil "z")
    (persp-switch "4")
    (switch-to-buffer "Google-chrome")
    (persp-switch "8")
    (find-file "~/Project")

    (exwm-workspace-switch-create 2)
    (switch-to-buffer "Spotify")

    (exwm-workspace-switch-create 0)
    (persp-switch "4")

    (message "settings done!")))

(defun kd/set-background ()
  "背景をセットする."
  (interactive)
  (start-process-shell-command "compton" nil "compton --config ~/dotfiles/.config/compton/compton.conf")
  (start-process-shell-command "fehbg" nil "~/dotfiles/.fehbg"))

(define-key exwm-mode-map (kbd "C-M-:") 'vterm-toggle)
(define-key exwm-mode-map (kbd "C-M-<right>") 'persp-next)
(define-key exwm-mode-map (kbd "C-M-<left>") 'persp-prev)
(define-key exwm-mode-map (kbd "<henkan>") 'pretty-hydra-henkan/body)

(when window-system
  (progn
    (exwm-config-example)
    ;; (kd/set-init)
    ;; (kd/set-background)
    ))

(defvar kd/polybar-process nil
  "Holds the process of the running Polybar instance, if any")

(defun kd/start-panel ()
  (interactive)
  (kd/kill-panel)
  (setq kd/polybar-process (start-process-shell-command "polybar" nil "~/dotfiles/.config/polybar/launch.sh")))

(defun kd/kill-panel ()
  (interactive)
  (when kd/polybar-process
    (ignore-errors
      (kill-process kd/polybar-process)))
  (setq kd/polybar-process nil))

(defun kd/polybar-exwm-workspace ()
  (pcase exwm-workspace-current-index
    (0 "%{F#797D7F}Work%{F-} Home")
    (1 "Work %{F#797D7F}Home%{F-}")
    (2 "")
    (3 "")
    (4 "")
    (9 "")))

(defun kd/send-polybar-exwm-workspace ()
  (kd/send-polybar-hook "exwm-workspace" 1))

(defun kd/send-polybar-hook (module-name hook-index)
  (start-process-shell-command "polybar-msg" nil (format "polybar-msg hook %s %s" module-name hook-index)))

(add-hook 'exwm-workspace-switch-hook #'kd/send-polybar-exwm-workspace)

(require 'perspective)
(setq persp-initial-frame-name "1")
(setq persp-modestring-dividers '("" "" " "))
(persp-mode 1)

(mapc (lambda (i)
        (persp-switch (int-to-string i)))
      (number-sequence 1 9))
(persp-switch "1")

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define pretty-hydra-henkan (:color blue :foreign-keys warn :title "Convenient Tools")
    ("Media"
     (("<prior>" kd/mint-volume-up "up")
      ("<next>" kd/mint-volume-down "down")
      ("<pause>" kd/player-stop "stop"))

     "Find"
     (("a" counsel-apropos "apropos")
      ("f" counsel-ag "ag")
      ("h" counsel-find-library "lib")
      ("i" counsel-imenu "imenu")
      ("r" counsel-register "register")
      ("b" counsel-bookmark "bookmark")
      ("p" persp-ivy-switch-buffer "persp-buffer")
      ("w" swiper-all-thing-at-point "all"))

     "Execute"
     (("e" counsel-linux-app "run")
      ("c" recompile "recompile")
      ("s" counsel-search "google"))

     "Git"
     (("g" magit-blame)
      (">" git-gutter+-next-hunk)
      ("<" git-gutter+-previous-hunk)
      ("@" git-timemachine)
      ("l" git-link))

     "Edit"
     (("q" query-replace "replace")
      ("y" ivy-yasnippet "yas"))

     "Window"
     (("1" (lambda nil (interactive) (persp-switch (int-to-string 1))) "Journal")
      ("2" (lambda nil (interactive) (persp-switch (int-to-string 2))) "Roam")
      ("3" (lambda nil (interactive) (persp-switch (int-to-string 3))) "Browser(Half)")
      ("4" (lambda nil (interactive) (persp-switch (int-to-string 4))) "Browser(Full)")
      ("5" (lambda nil (interactive) (persp-switch (int-to-string 5))) "Dotfiles")
      ("6" (lambda nil (interactive) (persp-switch (int-to-string 6))) "Emacs")
      ("7" (lambda nil (interactive) (persp-switch (int-to-string 7))) "Sub")
      ("8" (lambda nil (interactive) (persp-switch (int-to-string 8))) "Main")
      ("9" (lambda nil (interactive) (persp-switch (int-to-string 9))) "Blueberry"))))

  (define-key projectile-rails-mode-map (kbd "C-c r") 'pretty-hydra-projectile-rails-find/body)
  (define-key global-map (kbd "<henkan>") 'pretty-hydra-henkan/body))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define pretty-hydra-projectile-rails-find (:color blue :foreign-keys warn :title "Projectile Rails")
    ("Current"
     (("M" projectile-rails-find-current-model      "Current model")
      ("V" projectile-rails-find-current-view       "Current view")
      ("C" projectile-rails-find-current-controller "Current controller")
      ("H" projectile-rails-find-current-helper     "Current helper")
      ("P" projectile-rails-find-current-spec       "Current spec")
      ("Z" projectile-rails-find-current-serializer "Current serializer"))

     "App"
     (("m" projectile-rails-find-model           "Model")
      ("v" projectile-rails-find-view            "View")
      ("c" projectile-rails-find-controller      "Controller")
      ("h" projectile-rails-find-helper          "Helper")
      ("@" projectile-rails-find-mailer          "Mailer")
      ("y" projectile-rails-find-layout       "Layout")
      ("z" projectile-rails-find-serializer      "Serializer"))

     "Assets"
     (("j" projectile-rails-find-javascript  "Javascript")
      ("s" projectile-rails-find-stylesheet  "CSS"))

     "Other"
     (("n" projectile-rails-find-migration    "Migration")
      ("r" projectile-rails-find-rake-task    "Rake task")
      ("i" projectile-rails-find-initializer  "Initializer")
      ("l" projectile-rails-find-lib          "Lib")
      ("p" projectile-rails-find-spec         "Spec")
      ("t" projectile-rails-find-locale       "Translation"))

     "Single Files"
     (("R" projectile-rails-goto-routes   "routes.rb")
      ("G" projectile-rails-goto-gemfile  "Gemfile")
      ("D" projectile-rails-goto-schema   "schema.rb")))))

(global-set-key (kbd "M-SPC") #'major-mode-hydra)

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define emacs-lisp-mode nil
    ("Eval"
     (("b" eval-buffer "buffer")
      ("e" eval-defun "defun")
      ("r" eval-region "region"))
     "REPL"
     (("I" ielm "ielm"))
     "Test"
     (("t" ert "prompt")
      ("T" (ert t) "all")
      ("F" (ert :failed) "failed"))
     "Doc"
     (("f" describe-function "function")
      ("v" describe-variable "variable")
      ("i" info-lookup-symbol "info lookup")))))

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define org-agenda-mode nil
    ("pomodoro"
     (("s" org-pomodoro "start org-pomodoro")))))

(defun kd/mint-volume-up ()
  "Linux Mintでの音量アップ."
  (interactive)
  (start-process-shell-command "volume up" nil "pactl set-sink-volume @DEFAULT_SINK@ +5%"))

(defun kd/mint-volume-down ()
  "Linux Mintでの音量ダウン."
  (interactive)
  (start-process-shell-command "volume up" nil "pactl set-sink-volume @DEFAULT_SINK@ -5%"))

(defun kd/player-stop ()
  "再生停止"
  (interactive)
  (start-process-shell-command "player stop" nil "playerctl stop"))

(defun kd/up-network ()
  "ネットワーク接続"
  (interactive)
  (let ((passwd))
    (setq passwd (read-passwd "Password? "))
    (shell-command  (concat "for intf in /sys/class/net/*; do echo "
                            (shell-quote-argument passwd)
                            " | sudo -S ifconfig `basename $intf` up; done"))))
(defun kd/down-network ()
  "ネットワーク切断"
  (interactive)
  (let ((passwd))
    (setq passwd (read-passwd "Password? "))
    (shell-command  (concat "for intf in /sys/class/net/*; do echo "
                            (shell-quote-argument passwd)
                            " | sudo -S ifconfig `basename $intf` down; done"))))

;; (use-package ej-dict
;;   :straight (:host github :repo "kijimaD/ej-dict"))
;; (ej-dict-install-dict)

(defun my-exchange-point-and-mark ()
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark))
(global-set-key (kbd "C-x C-x") 'my-exchange-point-and-mark)

(global-set-key (kbd "C-c C-k") 'kill-whole-line)

(defun current-path ()
  (interactive)
  (let ((file-path buffer-file-name)
        (dir-path default-directory))
    (cond (file-path
           (kill-new (expand-file-name file-path))
           (message "Add Kill Ring: %s" (expand-file-name file-path)))
          (dir-path
           (kill-new (expand-file-name dir-path))
           (message "Add Kill Ring: %s" (expand-file-name dir-path)))
          (t
           (error-message-string "Fail to get path name.")))))

(defun my-isearch-done-opposite (&optional nopush edit)
  "End current search in the opposite side of the match."
  (interactive)
  (funcall #'isearch-done nopush edit)
  (when isearch-other-end (goto-char isearch-other-end)))

(defun my-next-line ()
  (interactive)
  (next-line)
  (recenter))
(global-set-key (kbd "<down>") 'my-next-line)

(defun my-previous-line ()
  (interactive)
  (previous-line)
  (recenter))
(global-set-key (kbd "<up>") 'my-previous-line)

(eval-after-load "eww"
  '(progn
     (define-key eww-mode-map (kbd "<mouse-1>") 'my-next-line)
     (define-key eww-mode-map (kbd "<mouse-2>") 'define-word-at-point)
     (define-key eww-mode-map (kbd "<mouse-4>") 'my-previous-line)
     (define-key eww-mode-map (kbd "<down-mouse-4>") 'nil)
     (define-key eww-mode-map (kbd "<mouse-5>") 'my-next-line)
     (define-key eww-mode-map (kbd "<down-mouse-5>") 'nil)
     (define-key eww-mode-map (kbd "<mouse-3>") 'my-previous-line)
     (define-key eww-mode-map (kbd "<mouse-8>") 'backward-word)
     (define-key eww-mode-map (kbd "<mouse-9>") 'forward-word)))

(defun kd/cancel-last-timer ()
  (interactive)
  (cancel-timer (car (last timer-list))))

;; Emacs C source directory
(let ((src-dir "~/ProjectOrg/emacs/src"))
  (if (file-directory-p src-dir)
      (setq source-directory src-dir)))
