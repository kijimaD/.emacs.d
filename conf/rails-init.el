;;; ruby_on_railsモード
(require 'projectile-rails)
(projectile-rails-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)

;; rspec ================
(require 'rspec-mode)

;; Rspecの実行結果をスクロールして出力する
(setq compilation-scroll-output t)

;; Dockerのときの設定。プロジェクトごとに設定したいが…
(setq rspec-use-docker-when-possible 1)
(setq rspec-docker-container "rails")
(setq rspec-docker-command "docker-compose -f docker-compose.yml -f docker-compose-app.yml -f docker-compose-app.override.yml exec")
(setq rspec-docker-cwd "")

;; RAILS_ENV=testを追加
(defun rspec-runner ()
  "Return command line to run rspec."
  (let ((bundle-command (if (rspec-bundle-p) "RAILS_ENV=test bundle exec " ""))
        (zeus-command (if (rspec-zeus-p) "zeus " nil))
        (spring-command (if (rspec-spring-p) "spring " nil)))
    (concat (or zeus-command spring-command bundle-command)
            (if (rspec-rake-p)
                (concat rspec-rake-command " spec")
              rspec-spec-command))))

;; (setq rspec-use-spring-when-possible nil)
(setq rspec-use-spring-when-possible t)
(defun rspec-spring-p ()
  (and rspec-use-spring-when-possible
       (stringp (executable-find "spring"))))
;; spring
;; bin/rspec

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

;; rinari
(when (require 'rinari nil 'noerror)
  (require 'rinari)
  (add-hook 'ruby-mode-hook 'rinari-minor-mode))

;; rspec-mode 用の snippet を認識させる
(when (require 'rinari nil 'noerror)
  (require 'rspec-mode)
  (eval-after-load 'rspec-mode
    '(rspec-install-snippets)))

(setq flycheck-ruby-rubocop-executable "bundle exec rubocop")

;; 補完 ================
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda ()
                             (ruby-electric-mode t)))

;; 実行環境 ================
(require 'quickrun)
(global-set-key (kbd "<f8>") 'quickrun)
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

;; yaml-mode ================
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

;; マジックコメントを挿入しない
(setq ruby-insert-encoding-magic-comment nil)

;; 対応ブロックを光らせる時間を短くする
(defcustom ruby-block-delay 0
  "*Time in seconds to delay before showing a matching paren."
  :type  'number
  :group 'ruby-block)

;; xmp(実行結果アノテーション)
(require 'rcodetools)
(define-key ruby-mode-map (kbd "C-<return>") 'xmp)

;; activate robe
;; CIでは実行しない
(when window-system
  (progn
    ;; (inf-ruby)
    ;; (robe-start)
    ))
