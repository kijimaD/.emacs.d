;; https://qiita.com/takaxp/items/2fde2c119e419713342b

;; ivy ================
;; M-o を ivy-hydra-read-action に割り当てる．
(when (require 'ivy-hydra nil t)
  (setq ivy-read-action-function #'ivy-hydra-read-action))

;; Magit
(setq magit-completing-read-function 'ivy-completing-read)

;; `ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める．
(setq ivy-use-virtual-buffers t)

;; ミニバッファでコマンド発行を認める
(when (setq enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode 1)) ;; 何回層入ったかプロンプトに表示．

;; ESC連打でミニバッファを閉じる
(define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

;; プロンプトの表示が長い時に折り返す（選択候補も折り返される）
(setq ivy-truncate-lines nil)

;; リスト先頭で `C-p' するとき，リストの最後に移動する
(setq ivy-wrap t)

(setq ivy-count-format "%d╳%d ")

;; アクティベート
(ivy-mode 1)

;; (setq ivy-initial-inputs-alist
;;       '((org-agenda-refile . "^")
;;         (org-capture-refile . "^")
;;         ;; (counsel-M-x . "^") ;; 削除．必要に応じて他のコマンドも除外する．
;;         (counsel-describe-function . "^")
;;         (counsel-describe-variable . "^")
;;         (Man-completion-table . "^")
;;         (woman . "^")))

;; counsel ================
(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x C-r") 'counsel-recentf)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x C-l") 'counsel-mark-ring)
(global-set-key (kbd "C-x C-u") 'ivy-resume)
(global-set-key (kbd "C-x C-g") 'counsel-git-grep)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "M-i") 'swiper-thing-at-point)
(global-set-key (kbd "C-c f") 'counsel-ag)
(global-set-key (kbd "C-c i") 'counsel-imenu)
(global-set-key (kbd "C-c y") 'ivy-yasnippet)
(global-set-key (kbd "C-c h") 'counsel-find-library)
(global-set-key [delete] 'counsel-apropos)
;; bm

(counsel-mode 1)

;; eldoc ================
(with-eval-after-load "eldoc"
  (defun ad:eldoc-message (f &optional string)
    (unless (active-minibuffer-window)
      (funcall f string)))
  (advice-add 'eldoc-message :around #'ad:eldoc-message))

;; 履歴 ================
(when (require 'smex nil t)
  (setq smex-history-length 35)
  (setq smex-completion-method 'ivy))

(with-eval-after-load "ivy"
  ;; counsel-mark-ring のリストをソートさせない
  (setf (alist-get 'counsel-mark-ring ivy-sort-functions-alist) nil))

(all-the-icons-ivy-rich-mode 1)
(ivy-rich-mode 1)

;; 外観 ================
(custom-set-faces
 '(ivy-current-match
   ((((class color) (background light))
     :background "#FFF3F3" :distant-foreground "#000000")
    (((class color) (background dark))
     :background "#404040" :distant-foreground "#abb2bf")))
 '(ivy-minibuffer-match-face-1
   ((((class color) (background light)) :foreground "#666666")
    (((class color) (background dark)) :foreground "#999999")))
 '(ivy-minibuffer-match-face-2
   ((((class color) (background light)) :foreground "#c03333" :underline t)
    (((class color) (background dark)) :foreground "#e04444" :underline t)))
 '(ivy-minibuffer-match-face-3
   ((((class color) (background light)) :foreground "#8585ff" :underline t)
    (((class color) (background dark)) :foreground "#7777ff" :underline t)))
 '(ivy-minibuffer-match-face-4
   ((((class color) (background light)) :foreground "#439943" :underline t)
    (((class color) (background dark)) :foreground "#33bb33" :underline t))))

;; agのデフォルト入力値をthing-at-pointにする
(defun ad:counsel-ag (f &optional initial-input initial-directory extra-ag-args ag-prompt caller)
  (apply f (or initial-input (ivy-thing-at-point))
         (unless current-prefix-arg
           (or initial-directory default-directory))
         extra-ag-args ag-prompt caller))

(advice-add 'counsel-ag :around #'ad:counsel-ag)
