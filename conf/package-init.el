;; パッケージ管理 ====
(require 'package)

(setq package-archives
      '(("elpy" . "https://jorgenschaefer.github.io/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;; セッション保存 ================
;; 自動保存 auto-save-buffers-enhanced
(require 'auto-save-buffers-enhanced)

;; 2秒後に保存
(setq auto-save-buffers-enhanced-interval 2)

;; 特定のファイルのみ有効にする
(setq auto-save-buffers-enhanced-include-regexps '(".+")) ;全ファイル

;; not-save-fileと.ignoreは除外する
(setq auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$"))

;; Wroteのメッセージを抑制
(setq auto-save-buffers-enhanced-quiet-save-p t)

;; *scratch*も ~/.emacs.d/scratch に自動保存
(setq auto-save-buffers-enhanced-save-scratch-buffer-to-file-p t)
(setq auto-save-buffers-enhanced-file-related-with-scratch-buffer
      (locate-user-emacs-file "scratch"))
(auto-save-buffers-enhanced t)

;;セッションの永続化 ================
(psession-mode 1)

;; 履歴保存
(savehist-mode 1)
;;; 永続化する変数を新たに追加する
(push 'compile-command savehist-additional-variables)
;;; 永続化しないミニバッファ履歴の変数を追加する
(push 'command-history savehist-ignored-variables)

;; コーディング外観  ================
(require 'rainbow-delimiters)
(rainbow-delimiters-mode t)
;; (require 'cl-lib)
;; (require 'color)
;; (cl-loop
;;  for index from 1 to rainbow-delimiters-max-face-count
;;  do
;;  (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
;;    (cl-callf color-saturate-name (face-foreground face) 30)))

(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(ahs-set-idle-interval 0.4)

;; ahs-modeのキーバインドを無効化する
(define-key auto-highlight-symbol-mode-map (kbd "M-<right>") nil)
(define-key auto-highlight-symbol-mode-map (kbd "M-<left>") nil)

;; インデント可視化
(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

;; スペース可視化
(require 'whitespace)
;; 空白
(set-face-foreground 'whitespace-space nil)
(set-face-background 'whitespace-space "gray33")
;; ファイル先頭と末尾の空行
(set-face-background 'whitespace-empty "gray33")
;; タブ
(set-face-foreground 'whitespace-tab nil)
(set-face-background 'whitespace-tab "gray33")
;; ???
(set-face-background 'whitespace-trailing "gray33")
(set-face-background 'whitespace-hspace "gray33")
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         empty          ; 先頭/末尾の空行
                         spaces         ; 空白
                         ;; space-mark     ; 表示のマッピング
                         tab-mark))
;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")
;; タブの表示を変更
(setq whitespace-display-mappings
      '((tab-mark ?\t [?\xBB ?\t])))
(global-whitespace-mode 1)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)))

;; 編集箇所を強調表示
(volatile-highlights-mode t)

;; 外観(非コーディング) ================
;; 現在行をハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "Purple4"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

(nyan-mode)

(setq beacon-size 20) ; default 40
(setq beacon-color "LavenderBlush1")
(setq beacon-blink-when-focused t)
(beacon-mode)

;; window移動 ================
;; 分割した画面間をShift+矢印で移動
(setq windmove-wrap-around t)
(windmove-default-keybindings)

(window-numbering-mode 1)

;; ブックマーク ================
(setq-default bm-buffer-persistence nil)
(setq bm-restore-repository-on-load t)
(require 'bm)
(add-hook 'find-file-hook 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)

;;; helm-bm.el設定
(require 'helm-bm)
(push '(migemo) helm-source-bm)
;; annotationをオフに
(setq helm-source-bm (delete '(multiline) helm-source-bm))

(defun bm-toggle-or-helm ()
  "2回連続で起動したらhelm-bmを実行させる"
  (interactive)
  (bm-toggle)
  (when (eq last-command 'bm-toggle-or-helm)
    (helm-bm)))
(global-set-key (kbd "C-M-SPC") 'bm-toggle-or-helm)

;; カーソル移動 ================
(require 'ace-jump-mode)
(setq ace-jump-mode-gray-background nil)
(setq ace-jump-word-mode-use-query-char nil)
(setq ace-jump-mode-move-keys
      (append "asdfghjkl;:]qwertyuiop@zxcvbnm,." nil))
;; (global-set-key (kbd "C-o") 'ace-jump-word-mode)

(ace-link-setup-default)

(require 'avy)
(global-set-key (kbd "C-j") 'avy-goto-char-timer)
(global-set-key (kbd "M-j") 'avy-goto-word-1)

(back-button-mode 1)

(global-set-key (kbd "C-c <left>") 'goto-last-change)
(global-set-key (kbd "C-x <right>") 'goto-last-change-reverse)

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

;; バージョン管理 ================
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(with-eval-after-load 'magit
  (require 'forge))

;; Gitの差分情報を表示する
(global-git-gutter+-mode 1)
;; modify された箇所で実行すると、diff を inline で見ることができる
(global-set-key (kbd "C-c C-v") 'git-gutter+-show-hunk-inline-at-point)

;; 文字入力 ================
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")

(global-set-key (kbd "C-SPC") 'toggle-input-method)

(require 'mozc-popup)
(setq mozc-candidate-style 'popup)

(add-hook 'input-method-activate-hook
          (lambda() (set-cursor-color "Green")))
(add-hook 'input-method-inactivate-hook
          (lambda() (set-cursor-color "magenta")))
(setq default-input-method "japanese-mozc")

;; 固有サイトモード ================
(require 'twittering-mode)

(global-set-key (kbd "<f2>") 'devdocs-search)

;; コンソールモード ================
(require 'fish-mode)

;; テンプレート ================
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/insert/")
;; (define-auto-insert "\\.rb$" "ruby-template.rb")
;; (define-auto-insert "\\.md$" "markdown-template.rb")
(setq auto-insert-alist
      (append '(
                ("\\.rb$" . "ruby-template.rb")
                ("\\.js$" . "js-template.js")
                ("\\.org$" . "org-template.org")
                ("\\.md$" . "markdown-template.md")
                ) auto-insert-alist))

(yatemplate-fill-alist)
(auto-insert-mode 1)
(yas-global-mode 1)
(setq yas-prompt-functions '(yas-ido-prompt))

(define-key yas-minor-mode-map (kbd "C-x y i") 'yas-insert-snippet)
(define-key yas-minor-mode-map (kbd "C-x y n") 'yas-new-snippet)
(define-key yas-minor-mode-map (kbd "C-x y v") 'yas-visit-snippet-file)

;; プロジェクト ================
(require 'projectile)
(projectile-global-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; 再読込 ================
(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))

(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)

;; 変更があったら自動で更新
(global-auto-revert-mode 1)

;; SSH ================
(require 'tramp)
(setq tramp-default-method "ssh")

;; スペルチェック ================
;; (add-hook 'prog-mode-hook 'flyspell-mode)

;; ispell の後継である aspell を使う。
;; CamelCase でもいい感じに spellcheck してくれる設定を追加
;; See: https://stackoverflow.com/a/24878128/8888451

;; (setq-default ispell-program-name "aspell")
;; (eval-after-load "ispell"
;;   '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;; (setq ispell-program-name "aspell"
;;       ispell-extra-args
;;       '("--sug-mode=ultra" "--lang=en_US" "--run-together" "--run-together-limit=5" "--run-together-min=2"))

;; シンタックスチェック ================

(require 'flycheck)
(setq flycheck-indication-mode 'right-fringe)
(add-hook 'flycheck-mode-hook #'flycheck-set-indication-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-cask-setup))

(add-hook 'emacs-lisp-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'ruby-mode-hook 'flycheck-mode)

;; 自動起動
(setq flycheck-check-syntax-automatically
      '(save idle-change mode-enabled))

;; コード変更後、2秒後にチェックする
(setq flycheck-idle-change-delay 2)

;; ヘルプ ================
(which-key-mode)
(which-key-setup-side-window-bottom)

;; dired ================
(require 'dired-single)
(defun my-dired-init ()
  "Bunch of stuff to run for dired, either immediately or when it's
   loaded."
  ;; <add other stuff here>
  (define-key dired-mode-map [remap dired-find-file]
    'dired-single-buffer)
  (define-key dired-mode-map [remap dired-mouse-find-file-other-window]
    'dired-single-buffer-mouse)
  (define-key dired-mode-map [remap dired-up-directory]
    'dired-single-up-directory))

;; if dired's already loaded, then the keymap will be bound
(if (boundp 'dired-mode-map)
    ;; we're good to go; just add our bindings
    (my-dired-init)
  ;; it's not loaded yet, so add our bindings to the load-hook
  (add-hook 'dired-load-hook 'my-dired-init))

;; 定義元ジャンプ ================
(setq dumb-jump-mode t)
(global-set-key (kbd "C-c d") 'dumb-jump-go)

;; easy-kill ================
(require 'easy-kill)
(require 'easy-kill-extras)
;; easy-kill-extras
;; Upgrade `mark-word' and `mark-sexp' with easy-mark
;; equivalents.
(global-set-key (kbd "M-@") 'easy-mark-word)
(global-set-key (kbd "C-M-@") 'easy-mark-sexp)

;; `easy-mark-to-char' or `easy-mark-up-to-char' could be a good
;; replacement for `zap-to-char'.
(global-set-key [remap zap-to-char] 'easy-mark-to-char)

;; Integrate `expand-region' functionality with easy-kill
(define-key easy-kill-base-map (kbd "o") 'easy-kill-er-expand)
(define-key easy-kill-base-map (kbd "i") 'easy-kill-er-unexpand)

;; Add the following tuples to `easy-kill-alist', preferrably by
;; using `customize-variable'.
(add-to-list 'easy-kill-alist '(?^ backward-line-edge ""))
(add-to-list 'easy-kill-alist '(?$ forward-line-edge ""))
(add-to-list 'easy-kill-alist '(?b buffer ""))
(add-to-list 'easy-kill-alist '(?< buffer-before-point ""))
(add-to-list 'easy-kill-alist '(?> buffer-after-point ""))
(add-to-list 'easy-kill-alist '(?f string-to-char-forward ""))
(add-to-list 'easy-kill-alist '(?F string-up-to-char-forward ""))
(add-to-list 'easy-kill-alist '(?t string-to-char-backward ""))
(add-to-list 'easy-kill-alist '(?T string-up-to-char-backward ""))

;; Emacs 24.4+ comes with rectangle-mark-mode.
;; (define-key rectangle-mark-mode-map (kbd "C-. C-,") 'mc/rect-rectangle-to-multiple-cursors)
;; (define-key cua--rectangle-keymap   (kbd "C-. C-,") 'mc/cua-rectangle-to-multiple-cursors)

;; log-mode ================
(require 'command-log-mode)
(global-command-log-mode)

(setq clm/log-command-exceptions*
      '(mozc-handle-event self-insert-command))

;; chrome edit ================
(edit-server-start)
(setq edit-server-new-frame-alist
      '((name . "Edit with Emacs FRAME")
        (top . 200)
        (left . 200)
        (width . 80)
        (height . 25)
        (minibuffer . t)
        (menu-bar-lines . t)
        (window-system . x)))

;; RSS ================

(setq elfeed-feeds
      '(
        ;; programming
        ("https://news.ycombinator.com/rss" hacker)
        ("https://www.heise.de/developer/rss/news-atom.xml" heise)
        ("https://www.reddit.com/r/emacs.rss" emacs)))

;; Google検索 ================
(require 'google-this)
(google-this-mode 1)
(global-set-key (kbd "<insert>") 'google-this)
(setq google-this-location-suffix "co.jp")

;; 辞書 ================
(require 'define-word)
(global-set-key (kbd "<end>") 'define-word-at-point)
(global-set-key (kbd "<henkan>") 'define-word-at-point)

;; eww ================
;; 改行するようにする
(defun shr-insert-document--for-eww (&rest them)
  (let ((shr-width 70)) (apply them)))
(defun eww-display-html--fill-column (&rest them)
  (advice-add 'shr-insert-document :around 'shr-insert-document--for-eww)
  (unwind-protect
      (apply them)
    (advice-remove 'shr-insert-document 'shr-insert-document--for-eww)))
(advice-add 'eww-display-html :around 'eww-display-html--fill-column)

;; 色設定
(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))

;; デフォルトエンジン
(setq eww-search-prefix "https://www.google.co.jp/search?q=")

;; 校正ツール ================
(require 'markdown-mode)
(define-key markdown-mode-map (kbd "C-c C-j") nil)

(flycheck-define-checker textlint
  "A linter for Markdown."
  :command ("textlint" "--format" "unix" source)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": "
     (id (one-or-more (not (any " "))))
     (message (one-or-more not-newline)
       (zero-or-more "\n" (any " ") (one-or-more not-newline)))
     line-end))
  :modes (text-mode markdown-mode gfm-mode))

(add-hook 'markdown-mode-hook
          '(lambda ()
             (setq flycheck-checker 'textlint)
             (current-word-highlight-mode)
             (flycheck-mode 1)))

(with-eval-after-load 'markdown-mode
  (add-hook 'markdown-mode-hook #'add-node-modules-path))

;; 正規表現 ================
(global-set-key (kbd "C-M-%") 'vr/query-replace)
