;; HELM ================
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 40)
(setq helm-follow-mode-persistent t)
(setq helm-source-names-using-follow
   '("Time World List" "Major Mode Bindings:" "Recentf" "Imenu" "Buffers" "Git Grep" "Visible bookmarks"))

(helm-autoresize-mode 1)
(helm-descbinds-mode)
(helm-mode 1)

;; helmキーバインド ================
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-l") 'helm-all-mark-rings)
(global-set-key (kbd "C-x C-u") 'helm-resume)
(global-set-key (kbd "C-x l") 'helm-mark-ring)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c h") 'helm-man-woman)
(global-set-key (kbd "C-c f") 'helm-find)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-c g") 'helm-surfraw)
(global-set-key (kbd "C-c y") 'helm-yas-complete)
(global-set-key [delete] 'helm-apropos)
(global-set-key [insert] 'helm-info)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)
(setq helm-surfraw-default-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; GTAGS ================
(require 'helm-gtags)
(helm-gtags-mode t)
;; (setq helm-gtags-auto-update t)

;; grep ================
(require 'helm-git-grep)

(global-set-key (kbd "C-x C-g") 'helm-git-grep)

;; migemo ================
(helm-migemo-mode 1)

;; helm-swoop ================
(setq helm-swoop-speed-or-color t)
