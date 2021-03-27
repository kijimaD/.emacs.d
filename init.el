(when (or (require 'cask "~/.cask/cask.el" t)
      (require 'cask nil t))
  (cask-initialize))

(add-to-list 'load-path (expand-file-name "conf" user-emacs-directory))
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

;; Mac用(day job用)設定
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super))
  (setq ruby-insert-encoding-magic-comment nil)
  (setq ctags-auto-update-mode nil)
  (setq public-directory "dropbox")
  (setq my-migemo-command "/usr/local/bin/cmigemo")
  (setq my-migemo-dictionary "/usr/local/Cellar/cmigemo/HEAD-5c014a8/share/migemo/utf-8/migemo-dict")
  )
(when (eq system-type 'gnu/linux)
  (setq public-directory "Dropbox")
  (setq my-migemo-command "cmigemo")
  (setq my-migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
  )

;; 環境変数を読み込む
(exec-path-from-shell-initialize)

;; 端末依存で使う変数(my-migemo-command, public-directory)を必要とするものが残っているためとりあえずここに書く.

;; インクリメンタルサーチ ================
(require 'migemo)
(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq migemo-command my-migemo-command)
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary my-migemo-dictionary)
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)
  )

;; 日誌 ================
(require 'org-journal)
(setq org-journal-date-format "%Y-%m-%d")
(setq org-journal-time-format "%R ")
(setq org-journal-file-format "%Y%m%d.org")
(setq org-journal-dir (concat "~/" public-directory "/junk/diary/org-journal"))
(setq org-journal-find-file 'find-file)
(setq org-journal-hide-entries-p nil)
(setq org-startup-folded 'showeverything)

;; 使い捨てのファイルを開く ================
(require 'open-junk-file)
(setq open-junk-file-format (concat "~/" public-directory "/junk/%Y-%m-%d-%H%M%S."))
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;; 文字コード ================
;;ターミナルの文字コード
(set-terminal-coding-system 'utf-8)
;;キーボードから入力される文字コード
(set-keyboard-coding-system 'utf-8)
;;ファイルのバッファのデフォルト文字コード
(set-buffer-file-coding-system 'utf-8)
;;バッファのプロセスの文字コード
(setq default-buffer-file-coding-system 'utf-8)
;;ファイルの文字コード
(setq file-name-coding-system 'utf-8)
;;新規作成ファイルの文字コード
(set-default-coding-systems 'utf-8)

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
