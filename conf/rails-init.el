;;; ruby_on_railsモード
(require 'projectile-rails)
(projectile-rails-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)

;; Rspecの実行結果をスクロールして出力する
(setq compilation-scroll-output t)

;; Dockerのときの設定。プロジェクトごとに設定したいが…
;; (setq rspec-use-docker-when-possible 1)
;; (setq rspec-docker-container "web")
;; (setq rspec-docker-cwd "")

;; シンタックスチェック ================
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

(require 'rinari)
(add-hook 'ruby-mode-hook 'rinari-minor-mode)

;; rspec-mode 用の snippet を認識させる
(require 'rspec-mode)
(eval-after-load 'rspec-mode
  '(rspec-install-snippets))

;; 補完 ================
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda ()
                             (ruby-electric-mode t)))

;; robe-modeの有効化とcompanyとの連携
(require 'robe)
(require 'company)
(global-company-mode)

;; (global-set-key (kbd "C-c y") 'company-yasnippet)
(add-hook 'ruby-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 '((company-dabbrev-code company-yasnippet)))))

(add-hook 'inf-ruby-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 '((company-dabbrev-code company-yasnippet)))))

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
(setq company-minimum-prefix-length 1) ; デフォルトは4
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

;; 実行環境 ================
(require 'quickrun)
(global-set-key (kbd "<f7>") 'quickrun)
(atomic-chrome-start-server)

;; pry
(require 'inf-ruby)
(setq inf-ruby-default-implementation "pry")
(setq inf-ruby-eval-binding "Pry.toplevel_binding")
;; riなどのエスケープシーケンスを処理し、色付けする
(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

;; slim-mode ================
(unless (package-installed-p 'slim-mode)
  (package-refresh-contents) (package-install 'slim-mode))
(add-to-list 'auto-mode-alist '("\\.slim?\\'" . slim-mode))

;; Macの設定 ================
;; (require 'rbenv)
;; (global-rbenv-mode)
;; (setq rbenv-installation-dir "~/.rbenv")
;; (setenv "PATH" (concat (expand-file-name "~/.rbenv/shims:") (getenv "PATH")))

;; マジックコメントを挿入しない
(setq ruby-insert-encoding-magic-comment nil)
