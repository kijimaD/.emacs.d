;; (define-key my-henkan-keymap (kbd "SPC") 'lsp-ui-doc-show)
;; (define-key my-henkan-keymap (kbd "i") 'lsp-ui-imenu)
;; (define-key my-henkan-keymap (kbd "<henkan> f") 'forge-pull)
;; (define-key my-henkan-keymap (kbd "<henkan> t") 'forge-list-topics)
;; (define-key my-henkan-keymap (kbd "<henkan> i") 'forge-list-assigned-issues)
;; (define-key my-henkan-keymap (kbd "<henkan> p") 'forge-list-assigned-pullreqs)
;; (define-key my-henkan-keymap (kbd "<henkan> o") 'forge-list-owned-issues)
;; (define-key my-henkan-keymap (kbd "<henkan> l") 'magit-log)

(defun local-switch-exwm-workspace (index)
  `(lambda ()
     (interactive)
     (exwm-workspace-switch-create ,index)))

;; 新しい行追加
(defun my-new-line ()
  (interactive)
  (open-line 1)
  (newline)
  (indent-for-tab-command)
  )

;; 前のマークに戻る
(defun my-exchange-point-and-mark ()
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark))
(global-set-key (kbd "C-x C-x") 'my-exchange-point-and-mark)

;; カーソルのあるword削除
(fset 'my-kill-word
   "\300\C-w")
(global-set-key (kbd "M-d") 'my-kill-word)

;; カーソルのあるsexp削除
(fset 'my-kill-sexp
   "\200\C-w")
(global-set-key (kbd "C-M-d") 'my-kill-sexp)

(global-set-key (kbd "C-c C-k") 'kill-whole-line)

;; カレントパス取得
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

;; 時間計測
(defun my-clock()
  (interactive)
  (org-clock-out)
  (org-clock-in))
(define-key org-mode-map (kbd "<menu>") 'my-clock)

;; i-searchで逆側にカーソルをセットする
(defun my-isearch-done-opposite (&optional nopush edit)
  "End current search in the opposite side of the match."
  (interactive)
  (funcall #'isearch-done nopush edit)
  (when isearch-other-end (goto-char isearch-other-end)))

;; 短距離ジャンプ
;; 絶対2ストロークなので意外と旨味はない…微調整が必要。
;; - これだけ使用キーをいじる
;; - 範囲設定を変数化
(defun my-avy-jump-short ()
  (interactive)
  (avy-jump avy-goto-word-0-regexp :beg (- (point) 200) :end (+ (point) 200))
)

(defun my-next-line ()
  (interactive)
  (next-line)
  (recenter))

(defun my-previous-line ()
  (interactive)
  (previous-line)
  (recenter))

(global-set-key (kbd "<up>") 'my-previous-line)
(global-set-key (kbd "<down>") 'my-next-line)

(eval-after-load "eww"
  '(progn
     (define-key eww-mode-map (kbd "<mouse-1>") 'my-next-line)
     (define-key eww-mode-map (kbd "<mouse-2>") 'define-word-at-point)
     (define-key eww-mode-map (kbd "<mouse-4>") 'my-previous-line)
     (define-key eww-mode-map (kbd "<down-mouse-4>") 'nil)
     (define-key eww-mode-map (kbd "<mouse-5>") 'my-next-line)
     (define-key eww-mode-map (kbd "<down-mouse-5>") 'nil)
     (define-key eww-mode-map (kbd "<mouse-3>") 'my-previous-line)
     (define-key eww-mode-map (kbd "<mouse-8>") 'backward-word)
     (define-key eww-mode-map (kbd "<mouse-9>") 'forward-word)))

;; マウス左クリック無効化
;; (dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]))
;;   (global-unset-key k))

;; 起動時の設定
;; (defun startup()
;;   (toggle-frame-maximized)
;;   (make-frame-command)
;;   (other-frame 0))
;; (add-hook 'after-init-hook 'startup)

(defun my-persp-save ()
  (interactive)
  (persp-state-save "~/.emacs.d/persp"))
(defun my-persp-load ()
  (interactive)
  (persp-state-load "~/.emacs.d/persp"))

(defun kd/opt-git ()
  "Gitの不要なファイル整理."
  (interactive)
  (start-process-shell-command "git-opt" nil "git gc && git fetch --prune"))

(defun kd/mint-volume-up ()
  "Linux Mintでの音量アップ."
  (interactive)
  (start-process-shell-command "volume up" nil "pactl set-sink-volume @DEFAULT_SINK@ +5%"))

(defun kd/mint-volume-down ()
  "Linux Mintでの音量ダウン."
  (interactive)
  (start-process-shell-command "volume up" nil "pactl set-sink-volume @DEFAULT_SINK@ -5%"))

(use-package ej-dict
  :straight (:host github :repo "kijimaD/ej-dict"))
;; (ej-dict-install-dict)

(defun kd/cancel-last-timer ()
  (interactive)
  (cancel-timer (car (last timer-list))))

;; Emacs C source directory
(let ((src-dir "~/ProjectOrg/emacs/src"))
  (if (file-directory-p src-dir)
      (setq source-directory src-dir)))

;; change polybar color by network ================
(defun kd/online-p ()
  (let ((command (string-trim (shell-command-to-string "ip -o link show enp0s31f6 | awk '{print $9}'"))))
    (cond ((string= command "UP") t)
          ((string= command "DOWN") nil))))

(defvar kd/last-online t)

(defun kd/change-network-p ()
  (let ((result))
   (if (eq kd/last-online (kd/online-p))
       (setq result nil)
     (progn
       (setq result t)
       (setq kd/last-online (kd/online-p))))
   result))

(defun kd/bar-color ()
  (if (kd/online-p) "#E50914"
    "#FFFFFF"))
