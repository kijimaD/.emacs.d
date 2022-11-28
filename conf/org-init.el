;; org-mode ================
(require 'org)
(require 'org-protocol)

;; System locale to use for formatting time values.
(setq system-time-locale "C")         ; Make sure that the weekdays in the
                                      ; time stamps of your Org mode files and
                                      ; in the agenda appear in English.

;; 拡張子がorgのファイルを開いた時，自動的にorg-modeにする
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(setq org-startup-folded 'content)

;; org-modeでの強調表示を可能にする
(add-hook 'org-mode-hook 'turn-on-font-lock)
;; (add-hook 'org-mode-hook 'current-word-highlight-mode)

;; 本文を自動インデント
(setq org-startup-indented t)

;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)
(setq org-hide-emphasis-markers t)

;; 画像表示
(setq org-startup-with-inline-images t)

(setq org-todo-keywords '((type "TODO" "WIP" "|" "DONE" "CLOSE")))
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "orange" :weight bold))
        ("WIP" . (:foreground "DeepSkyBlue" :weight bold))
        ("DONE" . (:foreground "green" :weight bold))
        ("CLOSE" . (:foreground "DarkOrchid" :weight bold))))

(setq org-src-fontify-natively t)
(setq org-fontify-quote-and-verse-blocks t)
(setq org-src-tab-acts-natively t)

;; 展開アイコン
;; (setq org-ellipsis "»")
;; (setq org-ellipsis "..")
;; (setq org-ellipsis "⤵")
;; (setq org-ellipsis "🢗")
;; (setq org-ellipsis "❖")
;; (setq org-ellipsis "↯")
(setq org-ellipsis "▽")
(setq org-cycle-separator-lines 2)

;; org-modeで行末で折り返しをする
(setq org-startup-truncated nil)
(defun change-truncation()
  (interactive)
  (cond ((eq truncate-lines nil)
         (setq truncate-lines t))
        (t
         (setq truncate-lines nil))))

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
(define-key org-mode-map (kbd "C-c C-x i") 'org-clock-in)
(define-key org-mode-map (kbd "C-c C-x o") 'org-clock-out)

;; org-babel ================
(org-babel-do-load-languages 'org-babel-load-languages
                             '((C . t)
                               (clojure . t)
                               (emacs-lisp . t)
                               (graphql . t)
                               (haskell . t)
                               (lisp . t)
                               (python . t)
                               (ruby . t)
                               (rust . t)
                               (scala . t)
                               (shell . t)
                               (sql . t)))

(setq org-confirm-babel-evaluate nil)
(setq org-babel-clojure-backend 'cider)
(require 'cider)

;; common lisp
(setq inferior-lisp-program "clisp")
;; clisp, sbcl,  ...

;; 日誌 ================
(require 'org-journal)
(setq org-journal-date-format "%Y-%m-%d(%a)")
(setq org-journal-time-format "%R ")
(setq org-journal-dir (concat "~/Private/junk/diary/org-journal"))
(setq org-journal-file-format "%Y%m%d.org")
(setq org-journal-find-file 'find-file)
(setq org-journal-hide-entries-p nil)

;; https://emacs.stackexchange.com/questions/17897/create-an-org-journal-template-for-daily-journal-entry/32655#32655?newreg=7c9543fa39e342cfb438c4168020447d
(defun kd/new-buffer-p ()
  (not (file-exists-p (buffer-file-name))))

(defun kd/insert-journal-template ()
  (let ((template-file (expand-file-name "~/.emacs.d/resources/journal-template.org" org-directory)))
    (when (kd/new-buffer-p)
      (save-excursion
        (goto-char (point-min))
        (insert-file-contents template-file)))))

(add-hook 'org-journal-after-entry-create-hook #'kd/insert-journal-template)

;; 使い捨てのファイルを開く ================
(require 'open-junk-file)
(setq open-junk-file-format (concat "~/Private/junk/%Y-%m-%d-%H%M%S."))
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;; 見出しをいい感じにする ================
;; (require 'org-bullets)
;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

;; org-modern
;; (add-hook 'org-mode-hook #'org-modern-mode)
;; (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

(require 'org-sticky-header)
(setq org-sticky-header-full-path 'full)
(setq org-sticky-header-heading-star "◉")

;; スライド ================
;; (org-tree-slide-simple-profile)
(org-tree-slide-presentation-profile)
(org-tree-slide--hide-slide-header)

;; pdf ================
;; (pdf-tools-install t)
(require 'pdf-tools)
(add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode)
(setq-default pdf-view-display-size 'fit-page)
(setq pdf-annot-activate-created-annotations t)
(define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
(setq pdf-view-resize-factor 1.1)

;; roam ================
(require 'org-roam)
(add-hook 'after-init-hook 'org-roam-mode)
(make-directory "~/roam" t)
(setq org-roam-v2-ack t)
(setq org-roam-directory "~/roam")
(setq org-roam-completion-everywhere t)

(define-key global-map (kbd "C-c n f") 'org-roam-node-find)
(define-key global-map (kbd "C-c n g") 'org-roam-graph)
(define-key global-map (kbd "C-c n i") 'org-roam-node-insert)
(define-key global-map (kbd "C-c n r") 'org-roam-node-random)
(define-key global-map (kbd "C-c n l") 'org-roam-buffer-toggle)
(define-key global-map (kbd "C-M-i") 'completion-at-point)

(setq org-roam-capture-templates
      '(("t" "TODO" entry
         (file+headline my-todo-file "Inbox")
         "*** TODO %?\n")
        ("d" "default" plain
         "%?"
         :if-new
         (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}"))
        ("r" "roam-page" plain
         (file "~/roam/templates/roam-page.org")
         :if-new
         (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}"))
        ("p" "project" plain
         (file "~/roam/templates/project.org")
         :if-new
         (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project"))
        ))

(setq org-id-link-to-org-use-id t)
(setq org-id-extra-files (org-roam--list-files org-roam-directory))

(setq org-roam-v2-ack t)

(org-roam-setup)
;; 画像 ================
(require 'org-download)
(setq-default org-download-image-dir "~/roam/images")

;; テンプレート ================
(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("cj" . "src clojure"))
  (add-to-list 'org-structure-template-alist '("cl" . "src C"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("gp" . "src git-permalink"))
  (add-to-list 'org-structure-template-alist '("go" . "src go"))
  (add-to-list 'org-structure-template-alist '("gq" . "src graphql"))
  (add-to-list 'org-structure-template-alist '("hs" . "src haskell"))
  (add-to-list 'org-structure-template-alist '("js" . "src javascript"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("rb" . "src ruby"))
  (add-to-list 'org-structure-template-alist '("rs" . "src rust"))
  (add-to-list 'org-structure-template-alist '("sc" . "src scala"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("sq" . "src sql"))
  (add-to-list 'org-structure-template-alist '("ts" . "src typescript")))

;; sql
(add-hook 'sql-mode-org-src-hook #'sqlind-minor-mode)

;; 中央寄せ ================
(require 'visual-fill-column)
(defun kd/centering-buffer ()
  "Centering buffer."
  (interactive)
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(add-hook 'org-mode-hook (lambda () (kd/centering-buffer)))
(add-hook 'eww-mode-hook (lambda () (kd/centering-buffer)))

;; face ================
;; themeのあとに評価するため、ここでは関数定義だけ。
;; https://github.com/daviwil/emacs-from-scratch/blob/master/Emacs.org

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  ;; (font-lock-add-keywords 'org-mode
  ;;                         '(("^ *\\([-]\\) "
  ;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "✦"))))))

  ;; (setq org-superstar-headline-bullets-list '("🙐" "🙑" "🙒" "🙓" "🙔" "🙕" "🙖" "🙗"))
  (setq org-superstar-headline-bullets-list '("◉" "○" "●" "✿" "✸"))

  (setq org-superstar-item-bullet-alist '((?* . ?•)
                                          (?+ . ?»)
                                          (?- . ?➤)))

  (dolist (face '((org-level-1 . 1.0)
                  (org-level-2 . 1.0)
                  (org-level-3 . 1.0)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Hiragino Sans" :height (cdr face) :weight 'bold))

  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)

  (custom-theme-set-faces
   'user
   '(variable-pitch ((t (:family "Helvetica Neue" :height 1.0 :weight regular))))
   '(fixed-pitch ((t (:family "Fira Mono" :height 1.0))))
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch :foreground "#f5f5f5"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
   '(org-block-begin-line ((t (:inherit org-block))))))

(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(defun org-lint-dir (directory)
  (let* ((files (directory-files directory t ".*\\.org$")))
    (org-lint-list files)))

(defun org-lint-list (files)
  (cond (files
         (org-lint-file (car files))
         (org-lint-list (cdr files)))))

(defun org-lint-file (file)
  (let ((buf)
        (lint))
    (setq buf (find-file-noselect file))
    (with-current-buffer buf (if (setq lint (org-lint)) (print (list file lint))))))

;; org-alert ================
(require 'org-alert)
(setq alert-default-style 'notifications)
(setq org-alert-interval 300)
(setq org-alert-notification-title "Reminder")
(org-alert-enable)

;; denote ================
(setq denote-directory (expand-file-name "~/roam/denote"))
(setq denote-known-keywords '("essay" "code-reading" "book"))

(define-key global-map (kbd "C-c d") 'denote-create-note)
