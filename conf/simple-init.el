;; デフォルトで入ってる設定を書く。

;; 文字コード
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)

(server-start)

;; 表示系 ================
;; *scratch*で最初に描画されるメッセージを消す
(setq initial-scratch-message "")

;; 終了時に確認しない
(setq confirm-kill-processes nil)

;; メニューバーを消す
(menu-bar-mode 0)

;;カーソルのある列をハイライト
(global-hl-line-mode 0)

;;対応する括弧をハイライト
(show-paren-mode t)

;;起動時のメッセージ非表示
(setq inhibit-startup-message t)

;;font-lockをどこでも有効にする
(global-font-lock-mode t)

;; タイトルにフルパス表示
(setq frame-title-format "%f")

(setq ring-bell-function 'ignore)

(toggle-frame-fullscreen)

(require 'scroll-bar)
(scroll-bar-mode 0)
(show-paren-mode t)
(require 'tool-bar)
(tool-bar-mode 0)
(tooltip-mode 0)

;; キーバインド ================

(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)))

;; キーボード入れ替えーーバックスペースをC-hで。
(keyboard-translate ?\C-h ?\C-?)

;;ワードカウントをC-x p に割当
(global-set-key "\C-xp" 'count-words)

;; windowの大きさ変更
(global-set-key (kbd "C-M-{") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-}") 'enlarge-window-horizontally)

;; yesかnoではなく、yかnかで答えられるようにする
(defalias 'yes-or-no-p 'y-or-n-p)

;;括弧の補完
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

;; オートセーブ関連 ================

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

;; オートセーブ
(setq auto-save-timeout 2)
(setq auto-save-visited-interval 2)
(setq auto-save-no-message t)
(auto-save-visited-mode)

;; 最適化 ================

;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)

;; splash screenを無効にする
(setq inhibit-splash-screen t)

;; 行番号の表示
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; ツール系 ================

;; ediffを１ウィンドウで表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; コーディング ================

;; オートインデントでスペースを使う
(setq-default indent-tabs-mode nil)

;; クリップボードと同期
(setq x-select-enable-primary t)

;; 空白を自動削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 選択状態で入力すると上書き
(delete-selection-mode t)

;; ウィンドウ移動 ================

;; メジャーモードのC-tキーバインドを無効化する
(eval-after-load "django-mode"
  '(progn
     (define-key django-mode-map (kbd "C-t") nil)))
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map (kbd "C-t") nil)))
(eval-after-load "vterm"
  '(progn
     (define-key vterm-mode-map (kbd "C-t") nil)
     (define-key vterm-mode-map (kbd "M-<right>") nil)
     (define-key vterm-mode-map (kbd "M-<left>") nil)
     (define-key vterm-mode-map (kbd "<f9>") nil)
     (define-key vterm-mode-map (kbd "C-<f9>") nil)))
(eval-after-load "magit"
  '(progn
     (mapc (lambda (i)
             (define-key magit-mode-map (kbd (format "M-%d" i)) nil))
           (number-sequence 1 4))))

;; インクリメンタルサーチの挙動変更 ================

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

;; マウスホイールの挙動
(setq
 ;; ホイールでスクロールする行数を設定
 mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control)))
 ;; 速度を無視する
 mouse-wheel-progressive-speed nil)

(setq scroll-preserve-screen-position 'always)
