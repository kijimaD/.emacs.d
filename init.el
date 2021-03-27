(when (or (require 'cask "~/.cask/cask.el" t)
      (require 'cask nil t))
  (cask-initialize))

(add-to-list 'load-path (expand-file-name "conf" user-emacs-directory))
(ignore-errors (load "local-init-example")
               (load "local-init"))
(load "font-init")
(load "simple-init")
(load "package-init")
(load "rails-init")
(load "python-init")
(load "web-mode-init")
(load "org-init")
(load "helm-init")
(load "theme-init")
(load "my-function-init")

;; 環境変数を読み込む
(exec-path-from-shell-initialize)

;; モードラインからマイナーモードを消す
;; (describe-minor-mode-from-indicator) で調べる。
(setq my-hidden-minor-modes
      '(
        abbrev-mode
        auto-highlight-symbol-mode
        auto-revert-mode
        back-button-mode
        company-mode
        ctags-auto-update-mode
        eldoc-mode
        helm-mode
        helm-gtags-mode
        magit-auto-revert-mode
        projectile-mode
        projectile-rails-mode
        robe-mode
        ruby-electric-mode
        rubocop-mode
        which-key-mode
        yas-minor-mode
        undo-tree-mode
        git-gutter+-mode
        flyspell-mode
        command-log-mode
        global-whitespace-mode
        google-this-mode
        ))
(mapc (lambda (mode)
        (setq minor-mode-alist
              (cons (list mode "") (assq-delete-all mode minor-mode-alist))))
      my-hidden-minor-modes)

;; ;; customが書き込まれないようにする
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
