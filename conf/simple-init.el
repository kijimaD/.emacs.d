;; デフォルトで入ってる設定を書く。

;; 文字コード
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)

(server-start)

;; 表示系 ================
;; *scratch*で最初に描画されるメッセージを消す
(setq initial-scratch-message "")

;; メニューバーを消す
(menu-bar-mode 0)

;;カーソルのある列をハイライト
(global-hl-line-mode t)

;;対応する括弧をハイライト
(show-paren-mode t)

;;起動時のメッセージ非表示
(setq inhibit-startup-message t)

;;font-lockをどこでも有効にする
(global-font-lock-mode t)

;; タイトルにフルパス表示
(setq frame-title-format "%f")

(setq ring-bell-function 'ignore)

;; キーバインド ================

(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)))

;; endキーをaproposに割当
(global-set-key [end] 'helm-apropos)

;; キーボード入れ替えーーバックスペースをC-hで。
(keyboard-translate ?\C-h ?\C-?)

;;ワードカウントをC-x p に割当
(global-set-key "\C-xp" 'count-words)

;; homeキーをpop-tag-mark(戻る)に割当
(global-set-key [home] 'pop-tag-mark)

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

;; 最適化 ================

;;ガベッジコレクションを実行するまでの割当メモリの閾値を増やす
(setq gc-cons-threshold (* 100 gc-cons-threshold))

;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)

;; splash screenを無効にする
(setq inhibit-splash-screen t)

;; 行番号の表示
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; ハイライトの表示を遅くする
(require 'hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
(cancel-timer global-hl-line-timer)

;; ツール系 ================

;; ediffを１ウィンドウで表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; コーディング ================

;; 補完可能なものを随時表示
(icomplete-mode 1)

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
