;; org-mode ================
(require 'org)

;; 拡張子がorgのファイルを開いた時，自動的にorg-modeにする
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; org-modeでの強調表示を可能にする
(add-hook 'org-mode-hook 'turn-on-font-lock)
;; (add-hook 'org-mode-hook 'current-word-highlight-mode)

;; 本文を自動インデント
(setq org-startup-indented t)

;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)
(setq org-hide-emphasis-markers t)

;; org-default-notes-fileのディレクトリ
(setq org-directory (concat "~/" public-directory "/junk/diary/org-journal"))

;; org-default-notes-fileのファイル名
(setq org-default-notes-file "notes.org")
(setq org-log-done 'time)

;; org-modeで行末で折り返しをする
(setq org-startup-truncated nil)
(defun change-truncation()
  (interactive)
  (cond ((eq truncate-lines nil)
         (setq truncate-lines t))
        (t
         (setq truncate-lines nil))))

;; blockの背景色を設定する。spacemacs-darkに合わせる
(custom-set-faces
 '(org-block
   ((t (:background "#373040" :foreground: "#827591")))))

;; スピードコマンド有効化
(setq org-use-speed-commands t)

;; キーバインド ================
;; ほかとかぶるので無効化
(define-key org-mode-map (kbd "C-c C-j") nil)
;; (define-key org-mode-map (kbd "<S-left>") nil)
;; (define-key org-mode-map (kbd "<S-right>") nil)
;; (define-key org-mode-map (kbd "<S-up>") nil)
;; (define-key org-mode-map (kbd "<S-down>") nil)
(define-key org-mode-map (kbd "M-<left>") nil)
(define-key org-mode-map (kbd "M-<right>") nil)

;; agenda ================
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(setq org-log-done t)
;; (setq org-agenda-files (list (concat "~/" public-directory "/junk/diary/org-journal/" "notes.org")))


;; スニペット ================
(org-babel-do-load-languages 'org-babel-load-languages
                             '(
                               (shell . t)
                               (python . t)
                               (ruby . t)
                               (emacs-lisp . t)))

;; 日誌 ================
(require 'org-journal)
(setq org-journal-date-format "%Y-%m-%d")
(setq org-journal-time-format "%R ")
(setq org-journal-dir (concat "~/" public-directory "/junk/diary/org-journal"))
(setq org-journal-file-format "%Y%m%d.org")
(setq org-journal-find-file 'find-file)
(setq org-journal-hide-entries-p nil)
(setq org-startup-folded 'showeverything)

;; 使い捨てのファイルを開く ================
(require 'open-junk-file)
(setq open-junk-file-format (concat "~/" public-directory "/junk/%Y-%m-%d-%H%M%S."))
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;; 見出しをいい感じにする ================
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'org-sticky-header)
(setq org-sticky-header-full-path 'full)
(setq org-sticky-header-heading-star "◉")

;; スライド ================
(global-set-key (kbd "<f6>") 'org-tree-slide-mode)
(global-set-key (kbd "S-<f6>") 'org-tree-slide-skip-done-toggle)

;; pdf ================
(pdf-tools-install t)
(add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode)
(setq-default pdf-view-display-size 'fit-page)

;; roam ================
(require 'org-roam)
(add-hook 'after-init-hook 'org-roam-mode)
(make-directory "~/roam" t)
(setq org-roam-directory "~/roam")

(define-key org-roam-mode-map (kbd "C-c n l") 'org-roam)
(define-key org-roam-mode-map (kbd "C-c n f") 'org-roam-find-file)
(define-key org-roam-mode-map (kbd "C-c n g") 'org-roam-graph)
(define-key org-mode-map (kbd "C-c n i") 'org-roam-insert)
(define-key org-mode-map (kbd "C-c n I") 'org-roam-insert-immediate)

;; テンプレート ================
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("sh" . "src sh"))
