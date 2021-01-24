;; 新しい行追加
(defun my-new-line ()
  (interactive)
  (open-line 1)
  (newline)
  (indent-for-tab-command)
  )
(global-set-key (kbd "C-<return>") 'my-new-line)

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
(define-key org-mode-map (kbd "<henkan>") 'my-clock)

;; i-searchで逆側にカーソルをセットする
(defun my-isearch-done-opposite (&optional nopush edit)
  "End current search in the opposite side of the match."
  (interactive)
  (funcall #'isearch-done nopush edit)
  (when isearch-other-end (goto-char isearch-other-end)))
(define-key isearch-mode-map (kbd "C-<return>")'my-isearch-done-opposite)
