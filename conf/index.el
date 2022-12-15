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
