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

(setq org-todo-keywords '((type "TODO" "WAIT" "|" "DONE" "CLOSE")))
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "orange" :weight bold))
        ("WAIT" . (:foreground "HotPink2" :weight bold))
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
(setq org-ellipsis "↯")
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

;; agenda ================
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("m" "Memo" entry
         (file+headline my-todo-file "Memo")
         "** %?\n")
        ("t" "Task" entry
         (file+headline my-todo-file "Tasks")
         "** TODO %?\n")
        ("p" "Protocol" entry
         (file+headline my-todo-file "Inbox")
         "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
        ("L" "Protocol Link" entry
         (file+headline my-todo-file "Inbox")
         "* %?[[%:link][%:description]]")))

(setq org-log-done t)

(setq my-org-directory (concat "~/" public-directory "/junk/diary/org-journal/"))
(setq my-todo-file (concat my-org-directory "todo.org"))

(setq org-directory my-org-directory)
(setq org-default-notes-file my-todo-file)

(setq org-agenda-files `("~/roam" ,my-todo-file))

;; 時刻をデフォルト表示
(setq org-agenda-start-with-log-mode t)

;; 7日分の予定を表示させる
(setq org-agenda-span 7)
(setq org-agenda-start-day "7d")

;; agendaには、習慣・スケジュール・TODOを表示させる
(setq org-agenda-custom-commands
      '(("a" "Agenda and all TODO's"
         ((tags "project-CLOCK=>\"<today>\"|repeatable") (agenda "") (alltodo)))))

(defun org-agenda-default ()
  (interactive)
  (org-agenda nil "a"))
(global-set-key (kbd "<f6>") 'org-agenda-default)

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
(setq org-journal-hide-entries-p t)

;; 使い捨てのファイルを開く ================
(require 'open-junk-file)
(setq open-junk-file-format (concat "~/" public-directory "/junk/%Y-%m-%d-%H%M%S."))
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;; 見出しをいい感じにする ================
;; (require 'org-bullets)
;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(require 'org-sticky-header)
(setq org-sticky-header-full-path 'full)
(setq org-sticky-header-heading-star "◉")

;; スライド ================
(org-tree-slide-simple-profile)

;; pdf ================
;; (pdf-tools-install t)
(add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode)
(setq-default pdf-view-display-size 'fit-page)

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
(define-key global-map (kbd "C-M-i") 'completion-at-point)
(define-key global-map [insert] 'org-pomodoro)

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

(org-roam-setup)
;; 画像 ================
(require 'org-download)
(setq-default org-download-image-dir "~/roam/images")

;; テンプレート ================
(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("js" . "src javascript"))
  (add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("rb" . "src ruby"))
  (add-to-list 'org-structure-template-alist '("sq" . "src sql"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell")))

;; sql
(add-hook 'sql-mode-org-src-hook #'sqlind-minor-mode)

;; 中央寄せ ================
(require 'visual-fill-column)
(defun efs/org-mode-visual-fill ()
  "Centering buffer."
  (interactive)
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(add-hook 'org-mode-hook (lambda () (efs/org-mode-visual-fill)))

;; face ================
;; themeのあとに評価するため、ここでは関数定義だけ。
;; https://github.com/daviwil/emacs-from-scratch/blob/master/Emacs.org

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  ;; (font-lock-add-keywords 'org-mode
  ;;                         '(("^ *\\([-]\\) "
  ;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "✦"))))))

(setq org-superstar-headline-bullets-list '("🙐" "🙑" "🙒" "🙓" "🙔" "🙕" "🙖" "🙗"))
(setq org-superstar-item-bullet-alist '((?* . ?•)
                                        (?+ . ?»)
                                        (?- . ?➤)))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.4)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.0)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Hiragino Sans" :weight 'extra-bold :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
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
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

;; UI ================
(when window-system
  (progn
    (use-package org-roam-ui
      :straight
      (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
      :after org-roam
      ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
      ;;         a hookable mode anymore, you're advised to pick something yourself
      ;;         if you don't care about startup time, use
      ;;  :hook (after-init . org-roam-ui-mode)
      :config
      (setq org-roam-ui-sync-theme t
            org-roam-ui-follow t
            org-roam-ui-update-on-save t
            org-roam-ui-open-on-start t))))

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
