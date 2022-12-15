;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 100 1024 1024))
(setq read-process-output-max (* 1024 1024))

(when (or (require 'cask "~/.cask/cask.el")
          (require 'cask nil))
  (cask--initialize))

(ignore-errors (guix-emacs-autoload-packages))

;; straight.el
;; fail in other system environments
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(add-to-list 'load-path "~/.emacs.d/conf" user-emacs-directory)
(setq load-path (cons "conf/" load-path))
(ignore-errors (load "local-init-example"))
(ignore-errors (load "local-init"))
(load "org-init")
(load "agenda-init")
(load "pomodoro-init")
(load "ob-rust")
(load "ob-scala")
(load "font-init")
(load "simple-init")
(load "package-init")
(load "rails-init")
(load "go-init")
(load "python-init")
(load "haskell-init")
(load "web-mode-init")
(load "lsp-init")
(load "corfu-init")
(load "ivy-init")
(load "shell-init")
(load "theme-init")
(load "exwm-init")
(load "hydra-init")

(org-babel-load-file "~/.emacs.d/README.org")

;; 環境変数を読み込む
;; (exec-path-from-shell-initialize)

;; モードラインからマイナーモードを消す
;; (describe-minor-mode-from-indicator) で調べる。
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

;; ;; customが書き込まれないようにする
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
