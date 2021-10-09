;; パッケージ管理 ====
(require 'package)

(setq package-archives
      '(("elpy" . "https://jorgenschaefer.github.io/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;;セッションの永続化 ================
;; (psession-mode 1)

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
;; (require 'highlight-indent-guides)
;; (setq highlight-indent-guides-auto-enabled t)
;; (setq highlight-indent-guides-responsive t)
;; (setq highlight-indent-guides-method 'character) ; column
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

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

(setq-default typescript-indent-level 2)

;; 編集箇所を強調表示
;; (volatile-highlights-mode t)

;; 外観(非コーディング) ================
;; 現在行をハイライト

;; ハイライトの表示を遅くする
(require 'hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))

(defface hlline-face
  '((((class color)
      (background dark))
     (:background "Purple4"))
    (((class color)
      (background light))
     (:background "gainsboro"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; (nyan-mode)

(setq beacon-size 20) ; default 40
(setq beacon-color "#827591")
(setq beacon-blink-when-focused t)
;; (beacon-mode)

;; window移動 ================
;; 分割した画面間をShift+矢印で移動
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;; (window-numbering-mode 1)

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
(global-set-key (kbd "C-M-SPC") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)

;; カーソル移動 ================
(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)
(global-set-key (kbd "C-t") 'other-window)

(require 'ace-jump-mode)
(setq ace-jump-mode-gray-background nil)
(setq ace-jump-word-mode-use-query-char nil)
(setq ace-jump-mode-move-keys
      (append "asdfghjkl;:]qwertyuiop@zxcvbnm,." nil))
(global-set-key (kbd "C-o") 'ace-jump-word-mode)

(ace-link-setup-default)

(require 'avy)
(global-set-key (kbd "C-j") 'avy-copy-line)
(global-set-key (kbd "M-j") 'avy-goto-line)
(global-set-key (kbd "C-M-j") 'avy-goto-whitespace-end)

(back-button-mode 1)
(global-set-key (kbd "C-c <left>") 'goto-last-change)
(global-set-key (kbd "C-c <right>") 'goto-last-change-reverse)

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
(counsel-projectile-mode)

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

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; 定義元ジャンプ ================
(dumb-jump-mode)
(global-set-key (kbd "C-c d") 'dumb-jump-go)
(setq dumb-jump-selector 'popup)
;; (setq dumb-jump-selector 'helm)

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

;; RSS ================

(setq elfeed-feeds
      '(("https://www.sanityinc.com/feed.xml" Emacs)
        ("https://sachachua.com/blog/category/weekly/feed/" Emacs)
        ("https://techracho.bpsinc.jp/feed" Ruby Rails)
        ("http://b.hatena.ne.jp/t-wada/rss" Test)
        ("https://cprss.s3.amazonaws.com/rubyweekly.com.xml" Ruby)))

;; Google検索 ================
(require 'google-this)
(google-this-mode 1)
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

(require 'cl-lib)

(defun eww-tag-pre (dom)
  (let ((shr-folding-mode 'none)
        (shr-current-font 'default))
    (shr-ensure-newline)
    (insert (eww-fontify-pre dom))
    (shr-ensure-newline)))

(defun eww-fontify-pre (dom)
  (with-temp-buffer
    (shr-generic dom)
    (let ((mode (eww-buffer-auto-detect-mode)))
      (when mode
        (eww-fontify-buffer mode)))
    (buffer-string)))

(defun eww-fontify-buffer (mode)
  (delay-mode-hooks (funcall mode))
  (font-lock-default-function mode)
  (font-lock-default-fontify-region (point-min)
                                    (point-max)
                                    nil))

(defun eww-buffer-auto-detect-mode ()
  (let* ((map '((ada ada-mode)
                (awk awk-mode)
                (c c-mode)
                (cpp c++-mode)
                (clojure clojure-mode lisp-mode)
                (csharp csharp-mode java-mode)
                (css css-mode)
                (dart dart-mode)
                (delphi delphi-mode)
                (emacslisp emacs-lisp-mode)
                (erlang erlang-mode)
                (fortran fortran-mode)
                (fsharp fsharp-mode)
                (go go-mode)
                (groovy groovy-mode)
                (haskell haskell-mode)
                (html html-mode)
                (java java-mode)
                (javascript javascript-mode)
                (json json-mode javascript-mode)
                (latex latex-mode)
                (lisp lisp-mode)
                (lua lua-mode)
                (matlab matlab-mode octave-mode)
                (objc objc-mode c-mode)
                (perl perl-mode)
                (php php-mode)
                (prolog prolog-mode)
                (python python-mode)
                (r r-mode)
                (ruby ruby-mode)
                (rust rust-mode)
                (scala scala-mode)
                (shell shell-script-mode)
                (smalltalk smalltalk-mode)
                (sql sql-mode)
                (swift swift-mode)
                (visualbasic visual-basic-mode)
                (xml sgml-mode)))
         (language (language-detection-string
                    (buffer-substring-no-properties (point-min) (point-max))))
         (modes (cdr (assoc language map)))
         (mode (cl-loop for mode in modes
                        when (fboundp mode)
                        return mode)))
    (message (format "%s" language))
    (when (fboundp mode)
      mode)))

(setq shr-external-rendering-functions
      '((pre . eww-tag-pre)))

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
  :modes (text-mode markdown-mode gfm-mode org-mode))

(add-hook 'markdown-mode-hook
          '(lambda ()
             (add-node-modules-path)
             (setq flycheck-checker 'textlint)
             (current-word-highlight-mode)
             (flycheck-mode 1)))

(add-hook 'org-mode-hook
          '(lambda ()
             (add-node-modules-path)
             (setq flycheck-checker 'textlint)
             (org-sticky-header-mode)
             (flycheck-mode 1)))

;; 正規表現 ================
(global-set-key (kbd "C-M-%") 'vr/query-replace)

;; write-room ================
(global-set-key [f7] 'writeroom-mode)

;; git-link ================
(setq git-link-default-branch nil)
(setq git-link-use-commit t)

;; undo ================
(global-undo-tree-mode)

;; eradio ================
(setq eradio-channels '(("def con - soma fm" . "https://somafm.com/defcon256.pls")
                        ("metal - soma fm"   . "https://somafm.com/metal130.pls")
                        ("cyberia - lainon"  . "https://lainon.life/radio/cyberia.ogg.m3u")
                        ("cafe - lainon"     . "https://lainon.life/radio/cafe.ogg.m3u")
                        ("ambient - HBR1.com" . "http://ubuntu.hbr1.com:19800/ambient.ogg")
                        ("ambient - RADIO ESTILO LEBLON" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us4.internet-radio.com:8193/listen.pls&t=.m3u")
                        ("ambient - Pink Noise Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk1.internet-radio.com:8004/listen.pls&t=.m3u")
                        ("ambient - Deeply Beautiful Chillout Music - A Heavenly World of Sound" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk2.internet-radio.com:31491/listen.pls&t=.m3u")
                        ("ambient - Chill Lounge Florida" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us5.internet-radio.com:8283/listen.pls&t=.m3u")
                        ("ambient - PARTY VIBE RADIO : AMBIENT" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://www.partyviberadio.com:8056/listen.pls?sid=1&t=.m3u")
                        ("healing - Healing Music Radio - The music of Peter Edwards" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us3.internet-radio.com:8169/live.m3u&t=.m3u")
                        ("ambient - Real World Sounds" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk5.internet-radio.com:8260/listen.pls&t=.m3u")
                        ("meditation - SilentZazen" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk5.internet-radio.com:8167/live.m3u&t=.m3u")
                        ("meditation - Zero Beat Zone (MRG.fm)" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://62.149.196.16:8800/listen.pls?sid=1&t=.m3u")
                        ("meditation - Meditation Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://213.239.218.99:7241/listen.pls?sid=1&t=.m3u")
                        ("ambient - AmbientRadio (MRG.fm)" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://62.149.196.16:8888/listen.pls?sid=1&t=.m3u")
                        ("jungle - Konflict Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk3.internet-radio.com:8192/live.m3u&t=.m3u")
                        ("jungle - Future Pressure Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk3.internet-radio.com:8108/listen.pls&t=.m3u")
                        ("jungle - PARTY VIBE RADIO : JUNGLE" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://www.partyviberadio.com:8004/listen.pls?sid=2&t=.m3u")
                        ("jazz - Smooth Jazz Florida" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us4.internet-radio.com:8266/listen.pls&t=.m3u")
                        ("rock - Classic Rock Florida HD" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us4.internet-radio.com:8258/listen.pls&t=.m3u")
                        ("dance - Dance UK Radio danceradiouk" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk2.internet-radio.com:8024/listen.pls&t=.m3u")
                        ("rock - Majestic Jukebox Radio #HIGH QUALITY SOUND" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk3.internet-radio.com:8405/live.m3u&t=.m3u")
                        ("ambient - LIFE CHILL MUSIC" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://aska.ru-hoster.com:8053/autodj.m3u&t=.m3u")
                        ("dance - PulseEDM Dance Music Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://pulseedm.cdnstream1.com:8124/1373_128.m3u&t=.m3u")
                        ("piano - Matt Johnson Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us2.internet-radio.com:8046/listen.pls&t=.m3u")
                        ("piano - Music Lake - Relaxation Music, Meditation, Focus, Chill, Nature Sounds" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://104.251.118.50:8626/listen.pls?sid=1&t=.m3u")
                        ("piano - Bru Zane Classical Radio - Rediscovering French Romantic Music" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://116.202.241.212:7001/listen.pls?sid=1&t=.m3u")
                        ("piano - CALMRADIO.COM - Most Beautiful Piano Ever" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://209.58.147.84:19991/listen.pls?sid=1&t=.m3u")
                        ("piano - CALMRADIO.COM - Light Jazz Piano" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://23.82.11.88:10800/listen.pls?sid=1&t=.m3u")
                        ))
;; typing game ================
(setq toe-highscore-file "~/.emacs.d/games/.toe-scores")

;; create-link ================
(setq create-link-default-format 'create-link-format-org)

;; ripgrep ================
(rg-enable-default-bindings)

;; Emacs Lisp ================
(require 'paredit)
;; (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;; (add-hook 'lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook 'enable-paredit-mode)

(require 'lispxmp)
(define-key emacs-lisp-mode-map (kbd "C-<return>") 'lispxmp)
