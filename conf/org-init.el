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

(setq org-todo-keywords '((type "TODO" "WAIT" "WIP" "|" "DONE" "CLOSE")))
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "orange" :weight bold))
        ("WAIT" . (:foreground "HotPink2" :weight bold))
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

(setq my-org-directory (concat "~/dropbox/junk/diary/org-journal/"))
(setq my-todo-file (concat my-org-directory "todo.org"))

(setq org-directory my-org-directory)
(setq org-default-notes-file my-todo-file)

(setq org-agenda-files `("~/roam" ,my-todo-file))

;; 時刻をデフォルト表示
(setq org-agenda-start-with-log-mode t)

;; 7日分の予定を表示させる
(setq org-agenda-span 14)
(setq org-agenda-start-day "7d")

;; agendaには、習慣・スケジュール・TODOを表示させる
(setq org-agenda-custom-commands
      '(("a" "Agenda and all TODO's"
         ((tags "project-CLOCK=>\"<today>\"|repeatable") (agenda "") (alltodo)))))
(setq org-agenda-custom-commands nil)

(defun org-agenda-default ()
  (interactive)
  (persp-switch "2")
  (org-agenda nil "z"))
(global-set-key (kbd "<f6>") 'org-agenda-default)

;; agenda内でRで出るclocktableの設定。
(setq org-clocktable-defaults '(:maxlevel 3 :scope agenda :tags "" :block today :step day :stepskip0 true :fileskip0 true))

(setq org-clock-mode-line-total 'today)

;; org-babel ================
(org-babel-do-load-languages 'org-babel-load-languages
                             '((shell . t)
                               (python . t)
                               (ruby . t)
                               (emacs-lisp . t)
                               (sql . t)
                               (graphql . t)
                               (haskell . t)
                               (clojure . t)
                               (lisp . t)
                               (rust . t)
                               (C . t)))

(setq org-confirm-babel-evaluate nil)
(setq org-babel-clojure-backend 'cider)
(require 'cider)

;; common lisp
(setq inferior-lisp-program "clisp")
;; clisp, sbcl,  ...

;; 日誌 ================
(require 'org-journal)
(setq org-journal-date-format "%Y-%m-%d")
(setq org-journal-time-format "%R ")
(setq org-journal-dir (concat "~/dropbox/junk/diary/org-journal"))
(setq org-journal-file-format "%Y%m%d.org")
(setq org-journal-find-file 'find-file)
(setq org-journal-hide-entries-p t)

;; 使い捨てのファイルを開く ================
(require 'open-junk-file)
(setq open-junk-file-format (concat "~/dropbox/junk/%Y-%m-%d-%H%M%S."))
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

  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("js" . "src javascript"))
  (add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("rb" . "src ruby"))
  (add-to-list 'org-structure-template-alist '("gq" . "src graphql"))
  (add-to-list 'org-structure-template-alist '("sq" . "src sql"))
  (add-to-list 'org-structure-template-alist '("hs" . "src haskell"))
  (add-to-list 'org-structure-template-alist '("cj" . "src clojure"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell")))

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

;; org-roam-ui ================
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

;; org-alert ================
(require 'org-alert)
(setq org-pomodoro-short-break-length 1)
(setq alert-default-style 'notifications)
(setq org-alert-interval 300)
(setq org-alert-notification-title "Reminder")
(org-alert-enable)

;; pomodoro ================
(require 'org-pomodoro)
(define-key global-map [insert] 'org-pomodoro)

(setq org-pomodoro-finished-sound "~/.emacs.d/resources/pmd-finished.wav")
;; (org-pomodoro-finished)
(setq org-pomodoro-short-break-sound "~/.emacs.d/resources/pmd-short-break.wav")
;; (org-pomodoro-short-break-finished)

(add-hook 'org-pomodoro-short-break-finished-hook 'org-agenda-default)
(add-hook 'org-pomodoro-long-break-finished-hook 'org-agenda-default)

(defun kd/org-pomodoro-remain-gauge (max-minutes)
  "Display remain time gauge."
  (let* ((display-len 25)
         (remaining-minutes (/ (org-pomodoro-remaining-seconds) 60))
         (current-percent (/ remaining-minutes max-minutes))
         (done (truncate (* (- 1 current-percent) display-len)))
         (will (truncate (* current-percent display-len))))
    (concat
     "%{T2}"
     ;; (concat "%{F#008000}" (make-string done ?█) "%{F-}")
     (concat "%{F#008000}" (make-string done ?|) "%{F-}")
     (concat "%{F#413839}" (make-string will ?|) "%{F-}")
     "%{T-}")))

;; https://colekillian.com/posts/org-pomodoro-and-polybar/
(defun kd/org-pomodoro-time ()
  "Return the remaining pomodoro time. Function for displaying in Polybar."
  (if (org-pomodoro-active-p)
      (cl-case org-pomodoro-state
        (:pomodoro
         (format "%s %dm - %s"
                 (kd/org-pomodoro-remain-gauge org-pomodoro-length)
                 (/ (org-pomodoro-remaining-seconds) 60)
                 org-clock-heading))
        (:short-break
         (format "%s Short break: %dm"
                 (kd/org-pomodoro-remain-gauge org-pomodoro-short-break-length)
                 (/ (org-pomodoro-remaining-seconds) 60)))
        (:long-break
         (format "%s Long break: %dm"
                 (kd/org-pomodoro-remain-gauge org-pomodoro-long-break-length)
                 (/ (org-pomodoro-remaining-seconds) 60)))
        (:overtime
         (format "Overtime! %dm" (/ (org-pomodoro-remaining-seconds) 60))))
    " Toggle LAN switch, and run pomodoro!"))

(defvar kd/pmd-today-point 0)
(add-hook 'org-pomodoro-finished-hook
          (lambda () (setq kd/pmd-today-point (1+ kd/pmd-today-point))))

(defun kd/write-pmd (str)
  (shell-command (format "echo '%s' >> ~/roam/pmd.csv" str)))

;; reset point
;; FIXME: 起動時に即実行されてる
(run-at-time "00:02am" (* 24 60 60) (lambda ()
                                      (kd/write-pmd (concat (format-time-string "%Y-%m-%d")
                                                            ", "
                                                            (number-to-string kd/pmd-today-point)))
                                      (setq kd/pmd-today-point 0)
                                      (message "pomodoro count reset!")))

(defun kd/pmd-today-point-display ()
  ;; (format " [%s]" kd/pmd-today-point)
  (format " ✿ %s" kd/pmd-today-point))

;; org-super-agenda
(org-super-agenda-mode)

(let ((org-super-agenda-groups
       '(;; Each group has an implicit boolean OR operator between its selectors.
         (:name "Today"  ; Optionally specify section name
                :time-grid t  ; Items that appear on the time grid
                :todo "TODAY")  ; Items that have this TODO keyword
         (:name "Important"
                ;; Single arguments given alone
                :tag "bills"
                :priority "A")
         (:name "WIP"
                ;; Single arguments given alone
                :todo "WIP")
         ;; Set order of multiple groups at once
         (:order-multi (2 (:name "Shopping in town"
                                 ;; Boolean AND group matches items that match all subgroups
                                 :and (:tag "shopping" :tag "@town"))
                          (:name "Food-related"
                                 :habit t
                                 ;; Multiple args given in list with implicit OR
                                 :tag ("food" "dinner"))
                          (:name "Space-related (non-moon-or-planet-related)"
                                 ;; Regexps match case-insensitively on the entire entry
                                 :and (:regexp ("space" "NASA")
                                               ;; Boolean NOT also has implicit OR between selectors
                                               :not (:regexp "moon" :tag "planet")))))
         ;; Groups supply their own section names when none are given
         (:todo "WAITING" :order 8)  ; Set order of this section
         (:todo ("SOMEDAY" "TO-READ" "TO-WRITE" "CHECK" "TO-WATCH" "WATCHING")
                ;; Show this group at the end of the agenda (since it has the
                ;; highest number). If you specified this group last, items
                ;; with these todo keywords that e.g. have priority A would be
                ;; displayed in that group instead, because items are grouped
                ;; out in the order the groups are listed.
                :order 9)
         (:priority<= "B"
                      ;; Show this section after "Today" and "Important", because
                      ;; their order is unspecified, defaulting to 0. Sections
                      ;; are displayed lowest-number-first.
                      :order 1)
         ;; After the last group, the agenda will display items that didn't
         ;; match any of these groups, with the default order position of 99
         )))
  ;; (org-agenda nil "a")
  )

(setq spacemacs-theme-org-agenda-height nil
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-include-diary t
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-with-log-mode t)

(setq org-agenda-custom-commands
      '(("z" "Super zaen view"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                                :time-grid t
                                :date today
                                :todo "TODAY"
                                :scheduled today
                                :order 1)
                         (:discard (:anything))))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Work In Progress"
                                 :todo "WIP"
                                 :order 1)
                          (:name "Due Today"
                                 :deadline today
                                 :order 2)
                          (:name "Due Month"
                                 :deadline future
                                 :order 3)
                          (:name "Overdue"
                                 :deadline past
                                 :order 7)
                          (:name "To write"
                                 :tag "Write"
                                 :order 12)
                          (:name "To read"
                                 :tag "Read"
                                 :order 14)
                          (:name "Projects"
                                 :tag "Project"
                                 :order 30)
                          (:discard (:tag ("Chore" "Routine" "Daily")))))))))))
