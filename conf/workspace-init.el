;; workspace
;; ワークスペース ================
(require 'perspective)
(persp-mode 1)

;; ワークスペース生成
(mapc (lambda (i)
        (persp-switch (int-to-string i)))
      (number-sequence 0 4))

;;;; キーに登録する関数を返す関数
;;(defun local-switch-workspace (i)
;;  (lexical-let ((index i))
;;    (lambda ()
;;      (interactive)
;;      (persp-switch (int-to-string index)))))

;;
;; 更新 2020/04/28
;;
(defun local-switch-workspace (index)
  `(lambda ()
     (interactive)
     (persp-switch (int-to-string ,index))))

;; キーバインドの登録を行う
(mapc (lambda (i)
        (global-set-key (kbd (format "M-%d" i)) (local-switch-workspace i)));;
      (number-sequence 0 4))
(persp-switch "0")
