;; https://qiita.com/takaxp/items/2fde2c119e419713342b
;; ivy ================
(when (require 'ivy nil t)

  ;; M-o を ivy-hydra-read-action に割り当てる．
  (when (require 'ivy-hydra nil t)
    (setq ivy-read-action-function #'ivy-hydra-read-action))

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

  ;; アクティベート
  (ivy-mode 1))

(with-eval-after-load "magit"
  (setq magit-completing-read-function 'ivy-completing-read))

(setq ivy-initial-inputs-alist
      '((org-agenda-refile . "^")
        (org-capture-refile . "^")
        ;; (counsel-M-x . "^") ;; 削除．必要に応じて他のコマンドも除外する．
        (counsel-describe-function . "^")
        (counsel-describe-variable . "^")
        (Man-completion-table . "^")
        (woman . "^")))

;; counsel ================
(when (require 'counsel nil t)

  ;; キーバインドは一例です．好みに変えましょう．
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "C-M-z") 'counsel-fzf)
  (global-set-key (kbd "C-M-r") 'counsel-recentf)
  (global-set-key (kbd "C-x C-b") 'counsel-ibuffer)
  (global-set-key (kbd "C-M-f") 'counsel-ag)

  ;; アクティベート
  (counsel-mode 1))

;; swiper ================
(when (require 'swiper nil t)

  ;; キーバインドは一例です．好みに変えましょう．
  (global-set-key (kbd "M-s M-s") 'swiper-thing-at-point))

;; eldoc ================
(with-eval-after-load "eldoc"
  (defun ad:eldoc-message (f &optional string)
    (unless (active-minibuffer-window)
      (funcall f string)))
  (advice-add 'eldoc-message :around #'ad:eldoc-message))

;; 履歴
(when (require 'smex nil t)
  (setq smex-history-length 35)
  (setq smex-completion-method 'ivy))

(with-eval-after-load "ivy"
  ;; counsel-mark-ring のリストをソートさせない
  (setf (alist-get 'counsel-mark-ring ivy-sort-functions-alist) nil))

(global-set-key (kbd "C-,") 'counsel-mark-ring)
(with-eval-after-load "flyspell"
  (define-key flyspell-mode-map (kbd "C-,") 'counsel-mark-ring))

(setq ivy-count-format "⦇%d/%d⦈ ")
(with-eval-after-load "ivy"
  (defun my-pre-prompt-function ()
    (if window-system
        (format "%s "
                (all-the-icons-faicon "sort-amount-asc")) ;; ""
      (format "%s" (make-string (1- (frame-width)) ?\x2D))))
  (setq ivy-pre-prompt-function #'my-pre-prompt-function))

(defface my-ivy-arrow-visible
  '((((class color) (background light)) :foreground "orange")
    (((class color) (background dark)) :foreground "#EE6363"))
  "Face used by Ivy for highlighting the arrow.")

(defface my-ivy-arrow-invisible
  '((((class color) (background light)) :foreground "#FFFFFF")
    (((class color) (background dark)) :foreground "#31343F"))
  "Face used by Ivy for highlighting the invisible arrow.")

(if window-system
    (when (require 'all-the-icons nil t)
      (defun my-ivy-format-function-arrow (cands)
        "Transform CANDS into a string for minibuffer."
        (ivy--format-function-generic
         (lambda (str)
           (concat (all-the-icons-faicon
                    "bolt"
                    :v-adjust -0.2 :face 'my-ivy-arrow-visible)
                   " " (ivy--add-face str 'ivy-current-match)))
         (lambda (str)
           (concat (all-the-icons-faicon
                    "bolt" :face 'my-ivy-arrow-invisible) " " str))
         cands
         "\n"))
      (setq ivy-format-functions-alist
            '((t . my-ivy-format-function-arrow))))
  (setq ivy-format-functions-alist '((t . ivy-format-function-arrow))))

;; (when (require 'all-the-icons-ivy nil t)
;;   (dolist (command '(counsel-projectile-switch-project
;;                      counsel-ibuffer))
;;     (add-to-list 'all-the-icons-ivy-buffer-commands command))
;;   (all-the-icons-ivy-setup))

(when (require 'ivy-rich nil t)
  (ivy-rich-mode 1))
