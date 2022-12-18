(setq debug-on-error t)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 100 1024 1024))
(setq read-process-output-max (* 1024 1024))

(require 'cask "~/.cask/cask.el")
(cask--initialize)

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

(load "index")

;; 環境変数を読み込む
;; (exec-path-from-shell-initialize)

;; ;; customが書き込まれないようにする
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
