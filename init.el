(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("816bacf37139d6204b761fea0d25f7f2f43b94affa14aa4598bce46157c160c2" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "5cd0afd0ca01648e1fff95a7a7f8abec925bd654915153fb39ee8e72a8b56a1f" "06ffa2bf4e891580bfe6a5ce68d0909ed9c4278e5234ede6b3ba459ef35d9a1b" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "62c80c6889010c3f0656e81ae201754058fd44743076f8dc56c595c2b9b5e298" "e1994cf306356e4358af96735930e73eadbaf95349db14db6d9539923b225565" "357d5abe6f693f2875bb3113f5c031b7031f21717e8078f90d9d9bc3a14bcbd8" "e8825f26af32403c5ad8bc983f8610a4a4786eb55e3a363fa9acb48e0677fe7e" "cdd26fa6a8c6706c9009db659d2dffd7f4b0350f9cc94e5df657fa295fffec71" "18a33cdb764e4baf99b23dcd5abdbf1249670d412c6d3a8092ae1a7b211613d5" "fe243221e262fe5144e89bb5025e7848cd9fb857ff5b2d8447d115e58fede8f7" "66881e95c0eda61d34aa7f08ebacf03319d37fe202d68ecf6a1dbfd49d664bc3" "b9293d120377ede424a1af1e564ba69aafa85e0e9fd19cf89b4e15f8ee42a8bb" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "251348dcb797a6ea63bbfe3be4951728e085ac08eee83def071e4d2e3211acc3" "6db9acac88c82f69296751e6c6d808736d6ff251dcb34a1381be86efc14fef54" "64ca5a1381fa96cb86fd6c6b4d75b66dc9c4e0fc1288ee7d914ab8d2638e23a9" "721bb3cb432bb6be7c58be27d583814e9c56806c06b4077797074b009f322509" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "ace9f12e0c00f983068910d9025eefeb5ea7a711e774ee8bb2af5f7376018ad2" "55d31108a7dc4a268a1432cd60a7558824223684afecefa6fae327212c40f8d3" default)))
 '(fci-rule-color "#2e2e2e")
 '(fringe-mode 0 nil (fringe))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(line-number-mode nil)
 '(nrepl-message-colors
   (quote
    ("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c")))
 '(org-agenda-files (quote ("")))
 '(org-log-into-drawer nil)
 '(org-pomodoro-expiry-time 120000)
 '(org-pomodoro-finished-sound
   "~/.emacs.d/elpa/org-pomodoro-20161119.226/resources/alert3.wav")
 '(org-pomodoro-long-break-frequency 120000)
 '(org-pomodoro-short-break-sound
   "~/.emacs.d/elpa/org-pomodoro-20161119.226/resources/alert3.wav")
 '(org-pomodoro-start-sound
   "~/.emacs.d/elpa/org-pomodoro-20161119.226/resources/bell.wav")
 '(org-pomodoro-ticking-sound
   "~/.emacs.d/elpa/org-pomodoro-20161119.226/resources/tick.wav")
 '(org-pomodoro-ticking-sound-states (quote (:pomodoro :short-break :long-break)))
 '(org-startup-indented t)
 '(org2blog/wp-buffer-template
   "#+DATE: %s
#+OPTIONS: toc:nil num:nil todo:nil pri:nil tags:nil ^:nil \\n:t
#+CATEGORY: %s
#+TAGS:
#+DESCRIPTION:
#+TITLE: %s

")
 '(org2blog/wp-default-categories nil)
 '(org2blog/wp-show-post-in-browser nil)
 '(package-selected-packages
   (quote
    (rinari helm-flyspell diminish rjsx-mode back-button powerline npm-mode outline-magic dired-single list-packages-ext ag which-key devdocs ob-elixir slim-mode exec-path-from-shell migemo yatemplate atomic-chrome quickrun bm window-numbering ddskk-posframe rspec-mode tabbar company robe ctags-update rubocop auto-highlight-symbol ruby-electric smooth-scrolling auto-complete-exuberant-ctags helm-gtags git-gutter-fringe+ dokuwiki org-journal-list org-journal dumb-jump dokuwiki-mode django-mode company-jedi markdown-mode jedi org-plus-contrib elscreen hiwin org org-brain zenburn-theme web-mode wc-goal-mode w3m typing twittering-mode summarye speed-type sound-wav solarized-theme smooth-scroll rainbow-delimiters psession projectile-rails powerline-evil pomodoro perl-completion paredit package-utils org-pomodoro open-junk-file noctilux-theme mozc-popup mozc-im maxframe magit lispxmp jdee helm-migemo helm grandshell-theme google-translate github-theme forest-blue-theme flatland-theme fish-mode firecode-theme fcitx farmhouse-theme eww-lnum espresso-theme elisp-slime-nav eldoc-extension eclipse-theme debug-print ddskk col-highlight chess autumn-light-theme auto-save-buffers-enhanced auto-install auto-complete anzu anything-project anti-zenburn-theme ample-zen-theme ample-theme afternoon-theme ace-jump-mode 2048-game)))
 '(pdf-view-midnight-colors (quote ("#232333" . "#c7c7c7")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vc-annotate-background "#3b3b3b")
 '(vc-annotate-color-map
   (quote
    ((20 . "#dd5542")
     (40 . "#CC5542")
     (60 . "#fb8512")
     (80 . "#baba36")
     (100 . "#bdbc61")
     (120 . "#7d7c61")
     (140 . "#6abd50")
     (160 . "#6aaf50")
     (180 . "#6aa350")
     (200 . "#6a9550")
     (220 . "#6a8550")
     (240 . "#6a7550")
     (260 . "#9b55c3")
     (280 . "#6CA0A3")
     (300 . "#528fd1")
     (320 . "#5180b3")
     (340 . "#6380b3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(wc-goal-modeline-format "WC[%C%c/%tc]")
 '(when
      (or
       (not
	(boundp
	 (quote ansi-term-color-vector)))
       (not
	(facep
	 (aref ansi-term-color-vector 0))))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Menlo" :slant normal :weight normal :height 90 :width normal :foundry "PfEd")))))

(set-fontset-font t 'japanese-jisx0208 (font-spec :family "ヒラギノ 角ゴ ProN"))
;; (set-fontset-font t
;; 		  'japanese-jisx0208
;; 		  (font-spec :family "Noto Sans CJK JP"))

;; (setq dired-default-file-coding-system 'utf-8-unix)
;; (setq default-buffer-file-coding-system 'utf-8-unix)
;; (set-buffer-file-coding-system 'utf-8-unix)
;; (set-terminal-coding-system 'utf-8-unix);; (set-keyboard-coding-system 'utf-8-unix)
;; (set-clipboard-coding-system 'utf-8-unix)

;; (set-default-coding-systems 'utf-8-unix)
;; (setq locale-coding-system 'utf-8)

;; ==================================================
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

;; キーボード入れ替えーーバックスペースをC-hで。
(keyboard-translate ?\C-h ?\C-?)

;;ワードカウントをC-x p に割当
(global-set-key "\C-xp" 'count-words)

;;; homeキーをpop-tag-mark(戻る)に割当
(global-set-key [home] 'pop-tag-mark)

;;; endキーをaproposに割当
(global-set-key [end] 'helm-apropos)

;; aproposをdeleteキーに割当
(global-set-key [delete] 'apropos)

;; (global-set-key "\C-j" '
;; 		(lambda (&optional arg)
;; 		  "Keyboard macro."
;; 		  (interactive "p")
;; 		  (kmacro-exec-ring-item
;; 		   (quote(" " 0 "%d"))arg)))



;; 移動を楽にする
(windmove-default-keybindings)

;; 補完可能なものを随時表示
(icomplete-mode 1)

;; yesかnoではなく、yかnかで答えられるようにする
(defalias 'yes-or-no-p 'y-or-n-p)

;; 外観 ====

;; *scratch*で最初に描画されるメッセージを消す
(setq initial-scratch-message "")

;;; メニューバーを消す
(menu-bar-mode 0)

;;カーソルのある列をハイライト
(global-hl-line-mode t)

;;対応する括弧をハイライト
(show-paren-mode t)

;;起動時のメッセージ非表示
(setq inhibit-startup-message t)

;;なんだっけ・
(setq x-select-enable-primary t)

;;括弧の補完
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
;; (global-set-key (kbd "<") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

;;インデント
(c-set-offset 'statement-case-intro '+)
(c-set-offset 'statement-case-open '+)

;;font-lockをどこでも有効にする
(global-font-lock-mode t)

;; 軽量化 ====
;;ガベッジコレクションを実行するまでの割当メモリの閾値を増やす
(setq gc-cons-threshold (* 100 gc-cons-threshold))

;;ログの記録量
(setq message-log-max 1000)

;;履歴存数
(setq history-length 500)

;;重複する履歴は保存しない
(setq history-delete-duplicates t)

;;バックアップファイルを作らない
(setq backup-inhibited t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;;終了時にオートセーブファイルを削除
(setq delete-auto-save-files t)

;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)

;; splash screenを無効にする
(setq inhibit-splash-screen t)

;;orgモード ====
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'org-install)

;; 拡張子がorgのファイルを開いた時，自動的にorg-modeにする
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; org-modeでの強調表示を可能にする
(add-hook 'org-mode-hook 'turn-on-font-lock)

;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)

;; org-default-notes-fileのディレクトリ
(setq org-directory "~/org/")

;; org-default-notes-fileのファイル名
(setq org-default-notes-file "notes.org")
(setq org-log-done 'time)

;;org-modeで行末で折り返しをする
(setq org-startup-truncated nil)
(defun change-truncation()
  (interactive)
  (cond ((eq truncate-lines nil)
         (setq truncate-lines t))
        (t
         (setq truncate-lines nil))))


;;パッケージの追加を楽にする ====
(package-initialize)
(add-to-list 'package-archives '("melpa"."http://melpa.org/packages/") t)

;;ace-jump-mode ====
(require 'ace-jump-mode)
(setq ace-jump-mode-gray-background nil)
(setq ace-jump-word-mode-use-query-char nil)
(setq ace-jump-mode-move-keys
(append "asdfghjkl;:]qwertyuiop@zxcvbnm,." nil))
;; (global-set-key (kbd "C-o") 'ace-jump-word-mode)
(global-set-key (kbd "C-M-;") 'ace-jump-line-mode)

;;HELM ====
(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 40)
(helm-autoresize-mode 1)

(helm-mode 1)

;;軽量化 =================================
;;行番号の表示
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;;ハイライトの表示を遅くする
(require 'hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
(cancel-timer global-hl-line-timer)

;; 括弧に色付け
(rainbow-delimiters-mode t)
(require 'cl-lib)
(require 'color)
(cl-loop
 for index from 1 to rainbow-delimiters-max-face-count
 do
 (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
   (cl-callf color-saturate-name (face-foreground face) 30)))

(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiter-mode)

;; 自動保存 auto-save-buffers-enhanced ====
(require 'auto-save-buffers-enhanced)

;;; 3秒後に保存
(setq auto-save-buffers-enhanced-interval 3)
;;; 特定のファイルのみ有効にする
(setq auto-save-buffers-enhanced-include-regexps '(".+")) ;全ファイル
;; not-save-fileと.ignoreは除外する
(setq auto-save-buffers-enhanced-exclude-regexps '("^not-save-file" "\\.ignore$"))
;;; Wroteのメッセージを抑制
(setq auto-save-buffers-enhanced-quiet-save-p t)
;;; *scratch*も ~/.emacs.d/scratch に自動保存
(setq auto-save-buffers-enhanced-save-scratch-buffer-to-file-p t)
(setq auto-save-buffers-enhanced-file-related-with-scratch-buffer
      (locate-user-emacs-file "scratch"))
(auto-save-buffers-enhanced t)

;; バージョン管理
(add-to-list 'load-path "~/src/magit") ; magit.elが存在するディレクトリを指定する
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; emacs-mozc======
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")

(global-set-key (kbd "C-SPC") 'toggle-input-method)

(require 'mozc-popup)
(setq mozc-candidate-style 'popup)
;; (setq mozc-candidate-style 'overlay)
;; (setq mozc-candidate-style 'echo-area)

;; 文字コード
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)

;; ediffを１ウィンドウで表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; twitterモード
(require 'twittering-mode)

;; fish
(require 'fish-mode)

;; 自動コンパイルを無効にするファイル名の正規表現
;; (setq auto-async-byte-compile-exclude-files-regexp "/junk/")
;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
;; (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
;; (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
;; (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
;; (setq eldoc-idle-delay 0.2)
;; (setq eldoc-minor-mode-string "")

;; ;; eldocの設定
;; (require 'eldoc)
;; (require 'eldoc-extension)
;; (setq eldoc-idle-delay 0.05)
;; ;; (setq eldoc-minor-mode-string "")
;; (add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
;; (add-hook 'lisp-interaction-mode-hook 'eldoc-mode)
;; (add-hook 'lisp-mode-hook 'eldoc-mode)
;; (add-hook 'ielm-mode-hook 'eldoc-mode)
;; (setq eldoc-echo-area-use-multiline-p t)

;; elispの括弧の対応を保持して編集する設定
;; (require 'paredit)
;; (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;; (add-hook 'lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook 'enable-paredit-mode)

(require 'powerline)
(powerline-default-theme)
;; (powerline-center-theme)

(set-face-attribute 'powerline-active1 nil
                    :foreground "white"
                    :background "darkViolet"
                    :inherit 'mode-line)

(set-face-attribute 'powerline-active0 nil
                    :foreground "black"
                    :background "limegreen"
                    :inherit 'mode-line)

;;; テンプレート自動挿入
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
(add-hook 'markdown-mode-hook 'yas-insert-snippet)

(require 'projectile)
(projectile-global-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;;; ruby_on_railsモード
(require 'projectile-rails)
(projectile-rails-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)

;; rspec
(setq compilation-scroll-output t)

;;; いちいち出るメッセージを出さないように
(defun ask-user-about-supersession-threat (fn)
  "blatantly ignore files that changed on disk"
  )
(defun ask-user-about-lock (file opponent)
  "always grab lock"
  t)

(prefer-coding-system 'utf-8)

;; Emacsを終了してもファイルを編集してた位置やminibuffer への入力内容を覚えててくれます。 ====
(when (require 'session nil t)
(setq session-initialize '(de-saveplace session keys menus places)
      session-globals-include '((kill-ring 50)
                                (session-file-alist 500 t)
                                (file-name-history 10000)))
;; これがないと file-name-history に500個保存する前に max-string に達する
(setq session-globals-max-string 100000000)
;; ;; デフォルトでは30
(setq history-length t)
(add-hook 'after-init-hook 'session-initialize))

;セッションの永続化
(psession-mode 1)

;; tabサイズ
(setq default-tab-width 4)

;; タイトルにフルパス表示
(setq frame-title-format "%f")

(require 'package)
 (setq package-archives
    '(("elpy" . "https://jorgenschaefer.github.io/packages/")
      ("melpa" . "https://melpa.org/packages/")
      ("gnu" . "https://elpa.gnu.org/packages/")
      ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(unless (package-installed-p 'org-plus-contrib)
  (package-refresh-contents)
  (package-install 'org-plus-contrib))
(require 'org)

;; Python開発環境 ====
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(jedi:setup)
;; (define-key jedi-mode-map (kbd "<C-tab>") nil) ;;C-tabはウィンドウの移動に用いる
(setq jedi:complete-on-dot t)
(setq ac-sources
      (delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;;jediの補完候補だけでいい
(add-to-list 'ac-sources 'ac-source-filename)
(add-to-list 'ac-sources 'ac-source-jedi-direct)

(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "C-o") 'other-frame)

(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)

;;; 分割した画面間をShift+矢印で移動
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;; helmキーバインド
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key "\M-j" 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h") 'helm-semantic-or-imenu)
(global-set-key (kbd "C-c f") 'helm-find)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)
 (setq helm-surfraw-default-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")


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

;; 空白を自動削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 環境変数を読み込む
(exec-path-from-shell-initialize)

;; migemo
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

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . dokuwiki-mode))
(setq web-mode-engines-alist
'(("php"    . "\\.phtml\\'")
  ("blade"  . "\\.blade\\.")))

; django-modeのC-tキーバインドを無効化する
(eval-after-load "django-mode"
  '(progn
     (define-key django-mode-map (kbd "C-t") nil)
     ))
;; dired
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map (kbd "C-t") nil)
     ))

; org-modeで日誌バッファ作成とかぶるので無効化
(define-key org-mode-map (kbd "C-c C-j") nil)
(define-key org-mode-map (kbd "<S-left>") nil)
(define-key org-mode-map (kbd "<S-right>") nil)
(define-key org-mode-map (kbd "<S-up>") nil)
(define-key org-mode-map (kbd "<S-down>") nil)
(define-key org-mode-map (kbd "M-<left>") nil)
(define-key org-mode-map (kbd "M-<right>") nil)

(org-babel-do-load-languages 'org-babel-load-languages
    '(
        (shell . t)
        (python . t)
        (ruby . t)
        (emacs-lisp . t)))

;; 日誌 ====
(require 'org-journal)
(setq org-journal-date-format "%Y-%m-%d")
(setq org-journal-time-format "%R ")
(setq org-journal-file-format "%Y%m%d.org")
(setq org-journal-dir (concat "~/" public-directory "/junk/diary/org-journal"))
(setq org-journal-find-file 'find-file)
(setq org-journal-hide-entries-p nil)
(setq org-startup-folded 'showeverything)

;; 使い捨てのファイルを開く ====
(require 'open-junk-file)
(setq open-junk-file-format (concat "~/" public-directory "/junk/%Y-%m-%d-%H%M%S."))
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;; SSH ====
(require 'tramp)
(setq tramp-default-method "ssh")

;; Gitの差分情報を表示する ====
(global-git-gutter+-mode 1)

;; 変更があったら自動で更新 ====
(global-auto-revert-mode 1)

(require 'gtags)
(require 'helm-gtags)
(helm-gtags-mode t)
;; (setq helm-gtags-auto-update t)

(defadvice isearch-mode (around isearch-mode-default-string (forward &optional regexp op-fun recursive-edit word-p) activate)
  (if (and transient-mark-mode mark-active (not (eq (mark) (point))))
      (progn
        (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
        (deactivate-mark)
        ad-do-it
        (if (not forward)
            (isearch-repeat-backward)
          (goto-char (mark))
          (isearch-repeat-forward)))
    ad-do-it))

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

(require 'flycheck)
(add-hook 'prog-mode-hook 'flyspell-mode)

(add-hook 'emacs-lisp-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'ruby-mode-hook 'flycheck-mode)

;; 自動起動
(setq flycheck-check-syntax-automatically
  '(save idle-change mode-enabled))

;; コード変更後、3秒後にチェックする
(setq flycheck-idle-change-delay 3)

;; Rails ====
;; flycheck と rubocop を連携させる
(require 'rubocop)
(add-hook 'ruby-mode-hook 'rubocop-mode)
(add-hook 'ruby-mode-hook
  '(lambda ()
    (setq flycheck-checker 'ruby-rubocop)))
;; See: https://qiita.com/watson1978/items/debafdfc49511fb173e9
;; 独自に checker を定義する（お好みで）
(flycheck-define-checker ruby-rubocop
"A Ruby syntax and style checker using the RuboCop tool."
  :command ("rubocop" "--format" "emacs"
    (config-file "--config" flycheck-rubocoprc) source)
  :error-patterns
    ((warning line-start
      (file-name) ":" line ":" column ": " (or "C" "W") ": " (message) line-end)
    (error line-start
          (file-name) ":" line ":" column ": " (or "E" "F") ": " (message) line-end))
  :modes (ruby-mode motion-mode))


;; JavaScript ====
;; See: https://qiita.com/kwappa/items/6bde1fe2bbeedc85023e
;; .js, .jsx を web-mode で開く
(add-to-list 'auto-mode-alist '("\\.js[x]?$" . web-mode))

;; .js でも JSX 編集モードに
(defvar web-mode-content-types-alist
  '(("jsx" . "\\.js[x]?\\'")))

;; コメントアウトの設定
(add-hook 'web-mode-hook
  '(lambda ()
     (add-to-list 'web-mode-comment-formats '("jsx" . "//" ))))

;; ESlint ====
;; eslint 用の linter を登録
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; 作業している project の node-module をみて、適切に
;; linter の設定を読み込む
(eval-after-load 'web-mode
  '(add-hook 'web-mode-hook #'add-node-modules-path))

;; 自動補完
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda ()
          (ruby-electric-mode t)))

;; 補完機能
;; robe-modeの有効化とcompanyとの連携
(require 'robe)
(require 'company)
(add-hook 'ruby-mode-hook 'robe-mode)
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
(eval-after-load 'company
  '(push 'company-robe company-backends))

(add-hook 'ruby-mode-hook (lambda()
      (company-mode)
      (setq company-auto-expand t)
      (setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
      (setq company-idle-delay 0) ; 遅延なしにすぐ表示
      (setq company-minimum-prefix-length 1) ; 何文字打つと補完動作を行うか設定
      (setq company-selection-wrap-around t) ; 候補の最後の次は先頭に戻る
      (setq completion-ignore-case t)
      (setq company-dabbrev-downcase nil)
      (global-set-key (kbd "C-M-i") 'company-complete)
      ;; C-n, C-pで補完候補を次/前の候補を選択
      (define-key company-active-map (kbd "C-n") 'company-select-next)
      (define-key company-active-map (kbd "C-p") 'company-select-previous)
      (define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
      (define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
      (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
      ))

;; companyの色
(set-face-attribute 'company-tooltip nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil
                    :foreground "white" :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil
                    :foreground "black" :background "steelblue")
(set-face-attribute 'company-preview-common nil
                    :background nil :foreground "lightgrey" :underline t)
(set-face-attribute 'company-scrollbar-fg nil
                    :background "orange")
(set-face-attribute 'company-scrollbar-bg nil
                    :background "gray40")

(define-key robe-mode-map (kbd "M-.") nil)

(setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 3) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq completion-ignore-case t)
(setq company-dabbrev-downcase nil)
(global-set-key (kbd "C-M-i") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next) ;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
(define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map (kbd "C-f") 'company-complete-selection) ;; C-fで候補を設定
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う

;; yasnippetとの連携
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;; 履歴保存
(savehist-mode 1)
;;; 永続化する変数を新たに追加する
(push 'compile-command savehist-additional-variables)
;;; 永続化しないミニバッファ履歴の変数を追加する
(push 'command-history savehist-ignored-variables)

; ahs-modeのキーバインドを無効化する
(define-key auto-highlight-symbol-mode-map (kbd "M-<right>") nil)
(define-key auto-highlight-symbol-mode-map (kbd "M-<up>") 'ahs-backward)
(define-key auto-highlight-symbol-mode-map (kbd "M-<left>") nil)
(define-key auto-highlight-symbol-mode-map (kbd "M-<down>") 'ahs-forward)

(window-numbering-mode 1)


;; bm ====
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


;; quickrun ====

(require 'quickrun)
(global-set-key (kbd "<f7>") 'quickrun)
(atomic-chrome-start-server)

(global-set-key (kbd "<f2>") 'devdocs-search)

(defun my-line ()
  (interactive)
  (open-line 1)
  (newline)
  (indent-for-tab-command)
)

(global-set-key (kbd "C-<return>") 'my-line)
(global-set-key (kbd "C-j") 'ace-jump-mode)
(global-set-key (kbd "M-j") 'ace-jump-mode-pop-mark)

;; pry
(require 'inf-ruby)
(setq inf-ruby-default-implementation "pry")
(setq inf-ruby-eval-binding "Pry.toplevel_binding")
;; riなどのエスケープシーケンスを処理し、色付けする
(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

;; slim
(unless (package-installed-p 'slim-mode)
  (package-refresh-contents) (package-install 'slim-mode))
(add-to-list 'auto-mode-alist '("\\.slim?\\'" . slim-mode))

;; which-key
(which-key-mode)
(which-key-setup-side-window-bottom)

;; dired-single
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

;; server
(server-start)

(require 'npm-mode)

(add-hook 'input-method-activate-hook
          (lambda() (set-cursor-color "Green")))
(add-hook 'input-method-inactivate-hook
          (lambda() (set-cursor-color "magenta")))
(setq default-input-method "japanese-mozc")

(back-button-mode 1)
(defun my-exchange-point-and-mark ()
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark))
(global-set-key (kbd "C-x C-x") 'my-exchange-point-and-mark)

(defface hlline-face
  '((((class color)
      (background dark))
     (:background "black"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
    ()))
"*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

(delete-selection-mode t)
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)))

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
           (error-message-string "Fail to get path name.")
           ))))

(setq ring-bell-function 'ignore)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; モードラインからマイナーモードを消す
;; (describe-minor-mode-from-indicator) で調べる。
(setq my-hidden-minor-modes
      '(
        abbrev-mode
	auto-complete-mode
	auto-highlight-symbol-mode
	auto-revert-mode
	back-button-mode
	company-mode
	ctags-auto-update-mode
        eldoc-mode
	flycheck-mode
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
	))

(mapc (lambda (mode)
	(setq minor-mode-alist
	      (cons (list mode "") (assq-delete-all mode minor-mode-alist))))
      my-hidden-minor-modes)

(require 'rinari)
(add-hook 'ruby-mode-hook 'rinari-minor-mode)

;; rspec-mode 用の snippet を認識させる
(eval-after-load 'rspec-mode
  '(rspec-install-snippets))

(setq dumb-jump-mode t)
(global-set-key [hiragana-katakana] 'dumb-jump-go)
