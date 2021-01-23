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
(defun my-kill-word ()
  (interactive)
  (easy-mark-word 0)
  (backward-delete-char 1))
(global-set-key (kbd "M-d") 'my-kill-word)

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
