(require 'package)

(setq package-archives
      '(("elpy" . "https://jorgenschaefer.github.io/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

(require 'org)
(require 'org-protocol)

(setq system-time-locale "C")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(setq org-startup-folded 'content)

(add-hook 'org-mode-hook 'turn-on-font-lock)

(setq org-startup-indented t)

(setq org-hide-leading-stars t)
(setq org-hide-emphasis-markers t)

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

;; (setq org-ellipsis "»")
;; (setq org-ellipsis "..")
;; (setq org-ellipsis "⤵")
;; (setq org-ellipsis "🢗")
;; (setq org-ellipsis "❖")
;; (setq org-ellipsis "↯")
(setq org-ellipsis "▽")

(setq org-cycle-separator-lines 2)

(setq org-startup-truncated nil)
(defun change-truncation()
  (interactive)
  (cond ((eq truncate-lines nil)
         (setq truncate-lines t))
        (t
         (setq truncate-lines nil))))

(setq org-use-speed-commands t)

(define-key org-mode-map (kbd "C-c C-j") nil)
(define-key org-mode-map (kbd "M-<left>") nil)
(define-key org-mode-map (kbd "M-<right>") nil)

(define-key org-mode-map (kbd "C-c C-x i") 'org-clock-in)
(define-key org-mode-map (kbd "C-c C-x o") 'org-clock-out)

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
                               (shell . t)
                               (sql . t)))

(require 'cider)
(setq org-babel-clojure-backend 'cider)

(setq inferior-lisp-program "clisp")

(add-hook 'sql-mode-org-src-hook #'sqlind-minor-mode)

(setq org-confirm-babel-evaluate nil)

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

(require 'visual-fill-column)
(defun kd/centering-buffer ()
  "Centering buffer."
  (interactive)
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(add-hook 'org-mode-hook (lambda () (kd/centering-buffer)))
(add-hook 'eww-mode-hook (lambda () (kd/centering-buffer)))

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

;;; open-junk-file.el --- Open a junk (memo) file to try-and-error

;; $Time-stamp: <2016-09-13 10:59:40 rubikitch>$

;; Copyright (C) 2010  rubikitch

;; Author: rubikitch <rubikitch@ruby-lang.org>
;; Keywords: convenience, tools
;; Package-Version: 20161210.1114
;; Package-Commit: 558bec7372b0fed4c4cb6074ab906535fae615bd
;; URL: http://www.emacswiki.org/cgi-bin/wiki/download/open-junk-file.el

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; M-x `open-junk-file' opens a new file whose filename is derived from
;; current time.  You can write short program in it.  It helps to
;; try-and-error programs.
;;
;; For example, in Emacs Lisp programming, use M-x `open-junk-file'
;; instead of *scratch* buffer.  The junk code is SEARCHABLE.
;;
;; In Ruby programming, use M-x `open-junk-file' and
;; write a script with xmpfilter annotations.  It is the FASTEST
;; methodology to try Ruby methods, Irb is not needed anymore.
;; Xmpfilter is available at http://eigenclass.org/hiki/rcodetools

;;; Commands:
;;
;; Below are complete command list:
;;
;;  `open-junk-file'
;;    Open a new file whose filename is derived from current time.
;;
;;; Customizable Options:
;;
;; Below are customizable option list:
;;
;;  `open-junk-file-format'
;;    *File format to put junk files with directory.
;;    default = "~/junk/%Y/%m/%d-%H%M%S."
;;  `open-junk-file-find-file-function'
;;    *Function to open junk files.
;;    default = (quote find-file-other-window)

;;; Installation:
;;
;; Put open-junk-file.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'open-junk-file)
;;
;; No need more.

;;; Customize:
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET open-junk-file RET
;;


;;; Bug Report:
;;
;; If you have problem, send a bug report via M-x open-junk-file-send-bug-report.
;; The step is:
;;  0) Setup mail in Emacs, the easiest way is:
;;       (setq user-mail-address "your@mail.address")
;;       (setq user-full-name "Your Full Name")
;;       (setq smtpmail-smtp-server "your.smtp.server.jp")
;;       (setq mail-user-agent 'message-user-agent)
;;       (setq message-send-mail-function 'message-smtpmail-send-it)
;;  1) Be sure to use the LATEST version of open-junk-file.el.
;;  2) Enable debugger. M-x toggle-debug-on-error or (setq debug-on-error t)
;;  3) Use Lisp version instead of compiled one: (load "open-junk-file.el")
;;  4) Do it!
;;  5) If you got an error, please do not close *Backtrace* buffer.
;;  6) M-x open-junk-file-send-bug-report and M-x insert-buffer *Backtrace*
;;  7) Describe the bug using a precise recipe.
;;  8) Type C-c C-c to send.
;;  # If you are a Japanese, please write in Japanese:-)

;;; Code:

(eval-when-compile (require 'cl))
(defgroup open-junk-file nil
  "open-junk-file"
  :group 'files)
(defcustom open-junk-file-format "~/junk/%Y/%m/%d-%H%M%S."
  "File format to put junk files with directory.
It can include `format-time-string' format specifications."
  :type 'string
  :group 'open-junk-file)
(defvaralias 'open-junk-file-format 'open-junk-file-directory)
(defcustom open-junk-file-find-file-function 'find-file-other-window
  "Function to open junk files."
  :type 'function
  :group 'open-junk-file)
(defcustom open-junk-file-hook nil
  "List of functions to be called after a buffer is loaded from a `junk' file.
Whether the file is a JUNK or not is infered by `open-junk-file-format'.")

;;;###autoload
(defun find-file-hook--open-junk-file ()
  "Run `open-junk-file-hook' when the file is a JUNK file."
  (when (string-prefix-p
         (file-truename (replace-regexp-in-string "%.+$" "" open-junk-file-format))
         (file-truename buffer-file-name))
    (run-hooks 'open-junk-file-hook)))

;;;###autoload
(add-hook 'find-file-hook 'find-file-hook--open-junk-file)

;;;###autoload
(defun open-junk-file (&optional format find-file-fn)
  "Open a new file whose filename is derived from current time.
You can write short program in it.  It helps to try-and-error programs.

For example, in Emacs Lisp programming, use M-x `open-junk-file'
instead of *scratch* buffer.  The junk code is SEARCHABLE.

FORMAT and FIND-FILE-FN are optional.
Default value of them are `open-junk-file-format' and
`open-junk-file-find-file-function'."
  (interactive)
  (let* ((file (format-time-string (or format open-junk-file-format) (current-time)))
         (dir (file-name-directory file)))
    (make-directory dir t)
    (funcall (or find-file-fn open-junk-file-find-file-function)
             (read-string "Junk Code (Enter extension): " file))))

;;;; Bug report
(defvar open-junk-file-maintainer-mail-address
  (concat "rubiki" "tch@ru" "by-lang.org"))
(defvar open-junk-file-bug-report-salutation
  "Describe bug below, using a precise recipe.

When I executed M-x ...

How to send a bug report:
  1) Be sure to use the LATEST version of open-junk-file.el.
  2) Enable debugger. M-x toggle-debug-on-error or (setq debug-on-error t)
  3) Use Lisp version instead of compiled one: (load \"open-junk-file.el\")
  4) If you got an error, please paste *Backtrace* buffer.
  5) Type C-c C-c to send.
# If you are a Japanese, please write in Japanese:-)")
(defun open-junk-file-send-bug-report ()
  (interactive)
  (reporter-submit-bug-report
   open-junk-file-maintainer-mail-address
   "open-junk-file.el"
   (apropos-internal "^open-junk-file-" 'boundp)
   nil nil
   open-junk-file-bug-report-salutation))

(provide 'open-junk-file)

;; How to save (DO NOT REMOVE!!)
;; (emacswiki-post "open-junk-file.el")
;;; open-junk-file.el ends here

(use-package open-junk-file)
(setq open-junk-file-format (concat "~/Private/junk/%Y-%m-%d-%H%M%S."))
(global-set-key (kbd "C-x C-z") 'open-junk-file)

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

;; (require 'org-sticky-header)
;; (setq org-sticky-header-full-path 'full)
;; (setq org-sticky-header-heading-star "◉")
;; (remove-hook 'org-mode-hook #'org-stickey-header-mode)

(org-tree-slide-presentation-profile)
(org-tree-slide--hide-slide-header)

(require 'org-journal)

(setq org-journal-date-format "%Y-%m-%d(%a)")
(setq org-journal-time-format "%R ")

(setq org-journal-dir (concat "~/Private/junk/diary/org-journal"))

(setq org-journal-file-format "%Y%m%d.org")

(setq org-journal-find-file 'find-file)

(setq org-journal-hide-entries-p nil)

(defun kd/new-buffer-p ()
  (not (file-exists-p (buffer-file-name))))

(defun kd/insert-journal-template ()
  (let ((template-file (expand-file-name "~/.emacs.d/resources/journal-template.org" org-directory)))
    (when (kd/new-buffer-p)
      (save-excursion
        (goto-char (point-min))
        (insert-file-contents template-file)))))
(add-hook 'org-journal-after-entry-create-hook #'kd/insert-journal-template)

;; (pdf-tools-install t)
(require 'pdf-tools)
(add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode)
(setq-default pdf-view-display-size 'fit-page)
(setq pdf-annot-activate-created-annotations t)
(define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
(setq pdf-view-resize-factor 1.1)

(require 'org-download)
(setq-default org-download-image-dir "~/roam/images")

(require 'org-roam)
(add-hook 'after-init-hook 'org-roam-mode)
(make-directory "~/roam" t)
(setq org-roam-v2-ack t)
(setq org-roam-directory "~/roam")
(setq org-roam-completion-everywhere t)

(setq org-id-link-to-org-use-id t)
(setq org-id-extra-files (org-roam--list-files org-roam-directory))
(org-roam-setup)

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

(require 'org-alert)
(setq alert-default-style 'notifications)
(setq org-alert-interval 300)
(setq org-alert-notification-title "Reminder")
(org-alert-enable)

(setq denote-directory (expand-file-name "~/roam/denote"))
(setq denote-known-keywords '("essay" "code" "book"))

(define-key global-map (kbd "C-c d") 'denote-create-note)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(defun org-agenda-default ()
  (interactive)
  (persp-switch "2")
  (org-agenda nil "z"))
(global-set-key (kbd "<f6>") 'org-agenda-default)

(add-hook 'org-pomodoro-short-break-finished-hook 'org-agenda-default)
(add-hook 'org-pomodoro-long-break-finished-hook 'org-agenda-default)

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

(let* ((my-org-directory (concat "~/Private/junk/diary/org-journal/"))
       (my-todo-file (concat my-org-directory "todo.org"))
       (my-agenda-file '("~/roam" "~/roam/denote")))

  (if (file-exists-p my-todo-file)
      (setq my-agenda-files (add-to-list my-agenda-files my-todo-file)))
  (setq org-agenda-files my-agenda-file)
  (setq org-directory my-org-directory)
  (setq org-default-notes-file my-todo-file))

(setq org-agenda-start-with-log-mode t)

(setq org-agenda-span 14)
(setq org-agenda-start-day "7d")

(setq org-agenda-custom-commands
        '(("z" "Super zaen view"
           ((agenda "" ((org-agenda-span 'day)
                        (org-super-agenda-groups
                         '((:name "🏗️Today"
                                  :time-grid t
                                  :date today
                                  :scheduled today
                                  :order 1)
                           (:name "🍵Future"
                                  :deadline future
                                  :scheduled future
                                  :order 10)
                           (:name "Overdue"
                                  :deadline past
                                  :order 10)
                           (:habit t)
                           (:log t)
                           (:discard (:anything))))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:name "▶️Work In Progress"
                                   :todo "WIP"
                                   :order 1)
                            (:name "✍To write"
                                   :tag "Write"
                                   :order 12)
                            (:name "📕To read"
                                   :tag "Read"
                                   :order 14)
                            (:name "✍Things I Don't Know"
                                   :tag "DontKnow"
                                   :order 15)
                            (:name "🛤️Train"
                                   :tag "Train"
                                   :order 18)
                            (:discard (:anything t))))))))))

(setq org-clocktable-defaults '(:maxlevel 3 :scope agenda :tags "" :block today :step day :stepskip0 true :fileskip0 true))

(setq spacemacs-theme-org-agenda-height nil
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-include-diary t
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-with-log-mode t
      org-habit-following-days 7
      org-habit-preceding-days 10
      org-habit-graph-column 80 ;; 見出しが隠れるため
      org-habit-show-habits t)

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

(require 'org-pomodoro)

(define-key global-map [insert] 'org-pomodoro)

(setq org-pomodoro-short-break-length 0)
(setq org-pomodoro-long-break-length 10)
(setq org-pomodoro-expiry-time 120)

(setq org-pomodoro-finished-sound "~/.emacs.d/resources/atos.wav")
(setq org-pomodoro-short-break-sound "~/.emacs.d/resources/atos.wav")
(setq org-pomodoro-long-break-sound "~/.emacs.d/resources/atos.wav")
;; テスト
;; (org-pomodoro-finished)
;; (org-pomodoro-short-break-finished)

(add-hook 'org-pomodoro-short-break-finished-hook 'org-agenda-default)
(add-hook 'org-pomodoro-long-break-finished-hook 'org-agenda-default)

(setq org-clock-mode-line-total 'today)

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

(defun kd/org-pomodoro-time ()
  "Return the remaining pomodoro time. Function for displaying in Polybar."
  (cond
   ((org-pomodoro-active-p) (cl-case org-pomodoro-state
                              (:pomodoro
                               (format "%s %dm %s%s%s"
                                       (kd/org-pomodoro-remain-gauge org-pomodoro-length)
                                       (/ (org-pomodoro-remaining-seconds) 60)
                                       "%{F#FFFFFF}"
                                       org-clock-heading
                                       "%{F-}"
                                       ))
                              (:short-break
                               (format "%s Short break: %dm"
                                       (kd/org-pomodoro-remain-gauge org-pomodoro-short-break-length)
                                       (/ (org-pomodoro-remaining-seconds) 60)))
                              (:long-break
                               (format "%s Long break: %dm"
                                       (kd/org-pomodoro-remain-gauge org-pomodoro-long-break-length)
                                       (/ (org-pomodoro-remaining-seconds) 60)))
                              (:overtime
                               (format "Overtime! %dm" (/ (org-pomodoro-remaining-seconds) 60)))
                              ))
   ((org-clocking-p) (format "(%s) %s" (org-clock-get-clocked-time) org-clock-heading))
   (t "OFF")))

(defun kd/effort-timer ()
  (if (and org-clock-effort (or (org-pomodoro-active-p) (org-clocking-p)))
      (format "[%s/%s]" (org-duration-from-minutes (org-clock-get-clocked-time)) org-clock-effort)
    ""))

(defun kd/pmd-today-point-display ()
  ;; (format " [%s]" kd/pmd-today-point)
  (let* ((all-minute (* kd/pmd-today-point 25))
         (hour (/ all-minute 60))
         (minute (% all-minute 60)))
    (format " %s %spts/%02dh%02dm" (kd/effort-timer) kd/pmd-today-point hour minute)))

(defvar kd/pmd-today-point 0)
(add-hook 'org-pomodoro-finished-hook
          (lambda () (setq kd/pmd-today-point (1+ kd/pmd-today-point))))

(defun kd/write-pmd (str)
  (shell-command (format "echo '%s' >> ~/roam/pmd.csv" str)))

;; reset point
(run-at-time "23:59pm" (* 24 60 60) (lambda ()
                                      (when (> kd/pmd-today-point 0)
                                        (kd/write-pmd (concat (format-time-string "%Y-%m-%d")
                                                              ", "
                                                              (number-to-string kd/pmd-today-point)))
                                        (setq kd/pmd-today-point 0)
                                        (message "pomodoro count reset!"))))

(defun kd/pmd-manual ()
  "set point manually"
  (interactive)
  (let ((point (read-from-minibuffer "How much point? ")))
    (setq kd/pmd-today-point (string-to-number point))))

(setq org-tag-alist '(("Write" . ?w)
                      ("Read" . ?r)
                      ("DontKnow" . ?d)
                      ("Train" . ?t)))

(when window-system
  (progn
    (pcase system-type
      ((or 'gnu/linux 'windows-nt 'cygwin)
       (set-face-attribute 'default nil
                           :font "Fira Code"
                           :weight 'regular
                           :height 110)
       (set-fontset-font
        nil 'japanese-jisx0208
        (font-spec :family "Hiragino Sans")))
      ;; Mac
      ('darwin
       (set-face-attribute 'default nil
                           :font "Fira Mono"
                           :height 150)
       (set-fontset-font
        nil 'japanese-jisx0208
        (font-spec :family "Hiragino Sans"))))))

(prefer-coding-system 'utf-8)

(set-language-environment 'utf-8)

(set-terminal-coding-system 'utf-8)

(set-keyboard-coding-system 'utf-8)

(set-buffer-file-coding-system 'utf-8)

(setq default-buffer-file-coding-system 'utf-8)

(setq file-name-coding-system 'utf-8)

(set-default-coding-systems 'utf-8)

(defun --set-emoji-font (frame)
  "Adjust the font settings of FRAME so Emacs can display emoji properly."
  (if (eq system-type 'darwin)
      ;; For NS/Cocoa
      (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") frame 'prepend)
    ;; For Linux
    (set-fontset-font t 'symbol (font-spec :family "Symbola") frame 'prepend)))

(when window-system
  (progn
    ;; GUI用設定
    (--set-emoji-font nil)
    ;; Hook for when a frame is created with emacsclient
    ;; see https://www.gnu.org/software/emacs/manual/html_node/elisp/Creating-Frames.html
    (add-hook 'after-make-frame-functions '--set-emoji-font)

    ;; unicodefont
    (require 'unicode-fonts)
    (unicode-fonts-setup)))

(server-start)

(setq initial-scratch-message "")

(setq confirm-kill-processes nil)

(menu-bar-mode 0)

(show-paren-mode t)

(setq inhibit-startup-message t)

(setq save-silently t)

(global-font-lock-mode t)

(setq frame-title-format "%f")

(setq ring-bell-function 'ignore)

(require 'scroll-bar)
(scroll-bar-mode 0)

(show-paren-mode t)

(require 'tool-bar)
(tool-bar-mode 0)

(tooltip-mode 0)

(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)))

(keyboard-translate ?\C-h ?\C-?)

(global-set-key "\C-xp" 'count-words)

(global-set-key (kbd "C-M-{") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-}") 'enlarge-window-horizontally)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq confirm-kill-emacs 'y-or-n-p)

(setq vc-follow-symlinks t)

(require 'smartparens)
(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'eshell-mode-hook 'smartparens-mode)
(add-hook 'org-mode-hook 'smartparens-mode)

(setq message-log-max 1000)

(setq history-length 500)

(setq history-delete-duplicates t)

(setq backup-inhibited t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

(setq delete-auto-save-files t)

(setq auto-save-timeout 2)
(setq auto-save-visited-interval 2)
(setq auto-save-no-message t)
(auto-save-visited-mode)

(setq-default bidi-display-reordering nil)

(setq inhibit-splash-screen t)

(display-line-numbers-mode)

(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(setq-default indent-tabs-mode nil)

(setq x-select-enable-primary t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(delete-selection-mode t)

(eval-after-load "django-mode"
  '(progn
     (define-key django-mode-map (kbd "C-t") nil)))
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map (kbd "C-t") nil)))
(eval-after-load "vterm"
  '(progn
     (define-key vterm-mode-map (kbd "C-t") nil)
     (define-key vterm-mode-map (kbd "M-<right>") nil)
     (define-key vterm-mode-map (kbd "M-<left>") nil)
     (define-key vterm-mode-map (kbd "<f9>") nil)
     (define-key vterm-mode-map (kbd "C-<f9>") nil)))
(eval-after-load "magit"
  '(progn
     (mapc (lambda (i)
             (define-key magit-mode-map (kbd (format "M-%d" i)) nil))
           (number-sequence 1 4))))

(defadvice isearch-mode (around isearch-mode-default-string (forward &optional regexp op-fun recursive-edit word-p) activate)
    (if (and transient-mark-mode mark-active (not (eq (mark) (point))))
        (progn
          (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
          (deactivate-mark)
          ad-do-it
          (if (not forward)
              (isearch-repeat-backward)
            (goto-char (mark))
            (isearch-repeat-forward)))
      ad-do-it))

(setq
   ;; ホイールでスクロールする行数を設定
   mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control)))
   ;; 速度を無視する
   mouse-wheel-progressive-speed nil)
  (setq scroll-preserve-screen-position 'always)

(if (fboundp 'blink-cursor-mode)
      (blink-cursor-mode -1))

(savehist-mode 1)

(push 'compile-command savehist-additional-variables)

(push 'command-history savehist-ignored-variables)

(require 'rainbow-delimiters)
(rainbow-delimiters-mode t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(ahs-set-idle-interval 0.4)

(define-key auto-highlight-symbol-mode-map (kbd "M-<right>") nil)
(define-key auto-highlight-symbol-mode-map (kbd "M-<left>") nil)

(require 'whitespace)

;; 空白
(set-face-foreground 'whitespace-space nil)
(set-face-background 'whitespace-space "gray33")
;; ファイル先頭と末尾の空行
(set-face-background 'whitespace-empty "gray33")
;; タブ
(set-face-foreground 'whitespace-tab nil)
(set-face-background 'whitespace-tab "gray33")
;; ???
(set-face-background 'whitespace-trailing "gray33")
(set-face-background 'whitespace-hspace "gray33")
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         empty          ; 先頭/末尾の空行
                         spaces         ; 空白
                         ;; space-mark     ; 表示のマッピング
                         tab-mark))
;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")
;; タブの表示を変更
(setq whitespace-display-mappings
      '((tab-mark ?\t [?\xBB ?\t])))
(global-whitespace-mode 1)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)))

(setq-default typescript-indent-level 2)

(require 'hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))

(defface hlline-face
  '((((class color)
      (background dark))
     (:background "DodgerBlue4"))
    (((class color)
      (background light))
     (:background "gainsboro"))
    (t
     ()))
  "*Face used by hl-line.")

(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

(setq beacon-size 20) ; default 40
(setq beacon-color "#827591")
(setq beacon-blink-when-focused t)
(beacon-mode)

(setq-default bm-buffer-persistence nil)
(setq bm-restore-repository-on-load t)
(require 'bm)
(add-hook 'find-file-hook 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))
(global-set-key (kbd "C-M-SPC") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)

(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)
(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "M-t") (lambda () (interactive) (other-window -1)))

(require 'ace-jump-mode)
(setq ace-jump-mode-gray-background nil)
(setq ace-jump-word-mode-use-query-char nil)
(setq ace-jump-mode-move-keys
      (append "asdfghjkl;:]qwertyuiop@zxcvbnm,." nil))
(global-set-key (kbd "C-o") 'ace-jump-word-mode)

(ace-link-setup-default)

(require 'avy)
(global-set-key (kbd "C-j") 'avy-copy-line)
(global-set-key (kbd "M-j") 'avy-goto-line)
(global-set-key (kbd "C-M-j") 'avy-goto-whitespace-end)

(back-button-mode 1)
(global-set-key (kbd "C-c <left>") 'goto-last-change)
(global-set-key (kbd "C-c <right>") 'goto-last-change-reverse)

;; 矩形選択で使うため無効化する
(define-key back-button-mode-map (kbd "C-x SPC") nil)

(require 'migemo)
(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq migemo-command my-migemo-command)
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary my-migemo-dictionary)
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)
  )

(require 'anzu)
(global-anzu-mode)

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(with-eval-after-load 'magit
  (require 'forge))

(global-git-gutter+-mode 1)
(global-set-key (kbd "C-c C-v") 'git-gutter+-show-hunk-inline-at-point)

;; http://www.modernemacs.com/post/pretty-magit/
(defun kd/magit-commit-prompt ()
  "Use ivy to insert conventional commit keyword."
  (let ((conventional-prompt '(("build" "ビルド")
                               ("chore" "雑事, カテゴライズする必要ないようなもの")
                               ("ci" "CI")
                               ("docs" "ドキュメント")
                               ("feat" "新機能")
                               ("fix" "バグフィックス")
                               ("perf" "パフォーマンス")
                               ("refactor" "リファクタリング")
                               ("revert" "コミット取り消し")
                               ("style" "コードスタイル修正")
                               ("test" "テスト"))))
    (insert (concat (ivy-read "Commit Type "
                              (mapcar 'car conventional-prompt)
                              :require-match t
                              :sort t
                              :preselect "Add: ")
                    ": "))))
(remove-hook 'git-commit-setup-hook 'with-editor-usage-message)
(add-hook 'git-commit-setup-hook 'kd/magit-commit-prompt)

(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
(global-set-key (kbd "C-SPC") 'toggle-input-method)

(add-hook 'input-method-activate-hook
          (lambda() (set-cursor-color "Magenta")))
(add-hook 'input-method-inactivate-hook
          (lambda() (set-cursor-color "grey")))

(require 'mozc-popup)
(setq mozc-candidate-style 'echo-area)

(global-set-key (kbd "<f2>") 'devdocs-search)

(require 'fish-mode)

(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/insert/")
;; (define-auto-insert "\\.rb$" "ruby-template.rb")
;; (define-auto-insert "\\.md$" "markdown-template.rb")
(setq auto-insert-alist
      (append '(
                ("\\.rb$" . "ruby-template.rb")
                ("\\.js$" . "js-template.js")
                ("\\.org$" . "org-template.org")
                ("\\.md$" . "markdown-template.md")
                ) auto-insert-alist))

(require 'yasnippet)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
(auto-insert-mode t)
(yas-global-mode t)
(setq yas-prompt-functions '(yas-ido-prompt))

(define-key yas-minor-mode-map (kbd "C-x y i") 'yas-insert-snippet)
(define-key yas-minor-mode-map (kbd "C-x y n") 'yas-new-snippet)
(define-key yas-minor-mode-map (kbd "C-x y v") 'yas-visit-snippet-file)

(require 'projectile)
(projectile-global-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(counsel-projectile-mode)

(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))
(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)

(global-auto-revert-mode 1)

(require 'tramp)
(setq tramp-default-method "ssh")

(require 'flycheck)
(setq flycheck-indication-mode 'right-fringe)
(add-hook 'flycheck-mode-hook #'flycheck-set-indication-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-cask-setup))

(add-hook 'emacs-lisp-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'ruby-mode-hook 'flycheck-mode)

;; 自動起動
(setq flycheck-check-syntax-automatically
      '(save idle-change mode-enabled))

;; コード変更後、2秒後にチェックする
(setq flycheck-idle-change-delay 2)

(which-key-mode)
(which-key-setup-side-window-bottom)

(require 'dired-single)
(defun my-dired-init ()
  "Bunch of stuff to run for dired, either immediately or when it's
   loaded."
  ;; <add other stuff here>
  (define-key dired-mode-map [remap dired-find-file]
    'dired-single-buffer)
  (define-key dired-mode-map [remap dired-mouse-find-file-other-window]
    'dired-single-buffer-mouse)
  (define-key dired-mode-map [remap dired-up-directory]
    'dired-single-up-directory))

;; if dired's already loaded, then the keymap will be bound
(if (boundp 'dired-mode-map)
    ;; we're good to go; just add our bindings
    (my-dired-init)
  ;; it's not loaded yet, so add our bindings to the load-hook
  (add-hook 'dired-load-hook 'my-dired-init))

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(require 'easy-kill)
(global-set-key [remap kill-ring-save] 'easy-kill)

(require 'easy-kill-extras)
;; easy-kill-extras
;; Upgrade `mark-word' and `mark-sexp' with easy-mark
;; equivalents.
(global-set-key (kbd "M-@") 'easy-mark-word)
(global-set-key (kbd "C-M-@") 'easy-mark-sexp)

;; `easy-mark-to-char' or `easy-mark-up-to-char' could be a good
;; replacement for `zap-to-char'.
(global-set-key [remap zap-to-char] 'easy-mark-to-char)

;; Integrate `expand-region' functionality with easy-kill
(define-key easy-kill-base-map (kbd "o") 'easy-kill-er-expand)
(define-key easy-kill-base-map (kbd "i") 'easy-kill-er-unexpand)

;; Add the following tuples to `easy-kill-alist', preferrably by
;; using `customize-variable'.
(add-to-list 'easy-kill-alist '(?^ backward-line-edge ""))
(add-to-list 'easy-kill-alist '(?$ forward-line-edge ""))
(add-to-list 'easy-kill-alist '(?b buffer ""))
(add-to-list 'easy-kill-alist '(?< buffer-before-point ""))
(add-to-list 'easy-kill-alist '(?> buffer-after-point ""))
(add-to-list 'easy-kill-alist '(?f string-to-char-forward ""))
(add-to-list 'easy-kill-alist '(?F string-up-to-char-forward ""))
(add-to-list 'easy-kill-alist '(?t string-to-char-backward ""))
(add-to-list 'easy-kill-alist '(?T string-up-to-char-backward ""))

(require 'command-log-mode)
(global-command-log-mode)

(setq clm/log-command-exceptions*
      '(mozc-handle-event self-insert-command))

(setq elfeed-feeds
      '(("https://www.sanityinc.com/feed.xml" sanityinc blog)
        ("https://sachachua.com/blog/category/weekly/feed/" sachachua blog)
        ("https://techracho.bpsinc.jp/feed" Ruby Rails)
        ("http://b.hatena.ne.jp/t-wada/rss" Test)
        ("https://cprss.s3.amazonaws.com/rubyweekly.com.xml" Ruby weekly)
        ("https://news.ycombinator.com/rss" Ruby weekly)
        ("http://pragmaticemacs.com/feed/" Pragmatic Emacs)))

;; default-browser
(setq browse-url-browser-function 'browse-url-firefox)

(require 'google-this)
(google-this-mode 1)
(setq google-this-location-suffix "co.jp")

(require 'define-word)
(global-set-key (kbd "<end>") 'define-word-at-point)

;; 改行するようにする
(defun shr-insert-document--for-eww (&rest them)
  (let ((shr-width 70)) (apply them)))
(defun eww-display-html--fill-column (&rest them)
  (advice-add 'shr-insert-document :around 'shr-insert-document--for-eww)
  (unwind-protect
      (apply them)
    (advice-remove 'shr-insert-document 'shr-insert-document--for-eww)))
(advice-add 'eww-display-html :around 'eww-display-html--fill-column)

;; 色設定
(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))

;; デフォルトエンジン
(setq eww-search-prefix "https://www.google.co.jp/search?q=")

(defun eww-tag-pre (dom)
  (let ((shr-folding-mode 'none)
        (shr-current-font 'default))
    (shr-ensure-newline)
    (insert (eww-fontify-pre dom))
    (shr-ensure-newline)))

(defun eww-fontify-pre (dom)
  (with-temp-buffer
    (shr-generic dom)
    (let ((mode (eww-buffer-auto-detect-mode)))
      (when mode
        (eww-fontify-buffer mode)))
    (buffer-string)))

(defun eww-fontify-buffer (mode)
  (delay-mode-hooks (funcall mode))
  (font-lock-default-function mode)
  (font-lock-default-fontify-region (point-min)
                                    (point-max)
                                    nil))

(defun eww-buffer-auto-detect-mode ()
  (let* ((map '((ada ada-mode)
                (awk awk-mode)
                (c c-mode)
                (cpp c++-mode)
                (clojure clojure-mode lisp-mode)
                (csharp csharp-mode java-mode)
                (css css-mode)
                (dart dart-mode)
                (delphi delphi-mode)
                (emacslisp emacs-lisp-mode)
                (erlang erlang-mode)
                (fortran fortran-mode)
                (fsharp fsharp-mode)
                (go go-mode)
                (groovy groovy-mode)
                (haskell haskell-mode)
                (html html-mode)
                (java java-mode)
                (javascript javascript-mode)
                (json json-mode javascript-mode)
                (latex latex-mode)
                (lisp lisp-mode)
                (lua lua-mode)
                (matlab matlab-mode octave-mode)
                (objc objc-mode c-mode)
                (perl perl-mode)
                (php php-mode)
                (prolog prolog-mode)
                (python python-mode)
                (r r-mode)
                (ruby ruby-mode)
                (rust rust-mode)
                (scala scala-mode)
                (shell shell-script-mode)
                (smalltalk smalltalk-mode)
                (sql sql-mode)
                (swift swift-mode)
                (visualbasic visual-basic-mode)
                (xml sgml-mode)))
         (language (language-detection-string
                    (buffer-substring-no-properties (point-min) (point-max))))
         (modes (cdr (assoc language map)))
         (mode (cl-loop for mode in modes
                        when (fboundp mode)
                        return mode)))
    (message (format "%s" language))
    (when (fboundp mode)
      mode)))

(setq shr-external-rendering-functions
      '((pre . eww-tag-pre)))

(flycheck-define-checker textlint
  "A linter for Markdown."
  :command ("textlint" "--format" "unix" source)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": "
            (id (one-or-more (not (any " "))))
            (message (one-or-more not-newline)
                     (zero-or-more "\n" (any " ") (one-or-more not-newline)))
            line-end))
  :modes (text-mode markdown-mode gfm-mode org-mode))

(add-hook 'markdown-mode-hook
          '(lambda ()
             (add-node-modules-path)
             (setq flycheck-checker 'textlint)
             (current-word-highlight-mode)
             (flycheck-mode 1)))

(add-hook 'org-mode-hook
          '(lambda ()
             (add-node-modules-path)
             (setq flycheck-checker 'textlint)
             (flycheck-mode 1)))

(global-set-key (kbd "C-M-%") 'vr/query-replace)

(global-set-key [f7] 'writeroom-mode)

(setq git-link-default-branch "main")
(setq git-link-use-commit t)

(global-undo-tree-mode)
(setq undo-tree-auto-save-history nil)

(setq eradio-channels '(("def con - soma fm" . "https://somafm.com/defcon256.pls")
                          ("metal - soma fm"   . "https://somafm.com/metal130.pls")
                          ("cyberia - lainon"  . "https://lainon.life/radio/cyberia.ogg.m3u")
                          ("cafe - lainon"     . "https://lainon.life/radio/cafe.ogg.m3u")
                          ("ambient - HBR1.com" . "http://ubuntu.hbr1.com:19800/ambient.ogg")
                          ("ambient - RADIO ESTILO LEBLON" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us4.internet-radio.com:8193/listen.pls&t=.m3u")
                          ("ambient - Pink Noise Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk1.internet-radio.com:8004/listen.pls&t=.m3u")
                          ("ambient - Deeply Beautiful Chillout Music - A Heavenly World of Sound" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk2.internet-radio.com:31491/listen.pls&t=.m3u")
                          ("ambient - Chill Lounge Florida" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us5.internet-radio.com:8283/listen.pls&t=.m3u")
                          ("ambient - PARTY VIBE RADIO : AMBIENT" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://www.partyviberadio.com:8056/listen.pls?sid=1&t=.m3u")
                          ("healing - Healing Music Radio - The music of Peter Edwards" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us3.internet-radio.com:8169/live.m3u&t=.m3u")
                          ("ambient - Real World Sounds" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk5.internet-radio.com:8260/listen.pls&t=.m3u")
                          ("meditation - SilentZazen" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk5.internet-radio.com:8167/live.m3u&t=.m3u")
                          ("meditation - Zero Beat Zone (MRG.fm)" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://62.149.196.16:8800/listen.pls?sid=1&t=.m3u")
                          ("meditation - Meditation Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://213.239.218.99:7241/listen.pls?sid=1&t=.m3u")
                          ("ambient - AmbientRadio (MRG.fm)" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://62.149.196.16:8888/listen.pls?sid=1&t=.m3u")
                          ("jungle - Konflict Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk3.internet-radio.com:8192/live.m3u&t=.m3u")
                          ("jungle - Future Pressure Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk3.internet-radio.com:8108/listen.pls&t=.m3u")
                          ("jungle - PARTY VIBE RADIO : JUNGLE" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://www.partyviberadio.com:8004/listen.pls?sid=2&t=.m3u")
                          ("jazz - Smooth Jazz Florida" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us4.internet-radio.com:8266/listen.pls&t=.m3u")
                          ("rock - Classic Rock Florida HD" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us4.internet-radio.com:8258/listen.pls&t=.m3u")
                          ("dance - Dance UK Radio danceradiouk" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk2.internet-radio.com:8024/listen.pls&t=.m3u")
                          ("rock - Majestic Jukebox Radio #HIGH QUALITY SOUND" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://uk3.internet-radio.com:8405/live.m3u&t=.m3u")
                          ("ambient - LIFE CHILL MUSIC" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://aska.ru-hoster.com:8053/autodj.m3u&t=.m3u")
                          ("dance - PulseEDM Dance Music Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://pulseedm.cdnstream1.com:8124/1373_128.m3u&t=.m3u")
                          ("piano - Matt Johnson Radio" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://us2.internet-radio.com:8046/listen.pls&t=.m3u")
                          ("piano - Music Lake - Relaxation Music, Meditation, Focus, Chill, Nature Sounds" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://104.251.118.50:8626/listen.pls?sid=1&t=.m3u")
                          ("piano - Bru Zane Classical Radio - Rediscovering French Romantic Music" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://116.202.241.212:7001/listen.pls?sid=1&t=.m3u")
                          ("piano - CALMRADIO.COM - Most Beautiful Piano Ever" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://209.58.147.84:19991/listen.pls?sid=1&t=.m3u")
                          ("piano - CALMRADIO.COM - Light Jazz Piano" . "https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://23.82.11.88:10800/listen.pls?sid=1&t=.m3u")
                          ))

(setq toe-highscore-file "~/.emacs.d/games/.toe-scores")

(setq create-link-default-format 'create-link-format-org)

(rg-enable-default-bindings)

(require 'paredit)
;; (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;; (add-hook 'lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook 'enable-paredit-mode)

(require 'lispxmp)
(define-key emacs-lisp-mode-map (kbd "C-<return>") 'lispxmp)

(require 'graphql-mode)
(require 'ob-graphql)

(require 'smart-newline)
(global-set-key (kbd "C-m") 'newline)
(add-hook 'ruby-mode-hook 'smart-newline-mode)

(require 'projectile-rails)
(projectile-rails-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

(require 'rspec-mode)

;; Rspecの実行結果をスクロールして出力する
(setq compilation-scroll-output t)

;; Dockerのときの設定。プロジェクトごとに設定したいが…
(setq rspec-use-docker-when-possible 1)
(setq rspec-docker-container "rails")
(setq rspec-docker-command "docker-compose -f docker-compose.yml -f docker-compose-app.yml -f docker-compose-app.override.yml exec")
(setq rspec-docker-cwd "")

(defun rspec-runner ()
  "Return command line to run rspec."
  (let ((bundle-command (if (rspec-bundle-p) "RAILS_ENV=test bundle exec " ""))
        (zeus-command (if (rspec-zeus-p) "zeus " nil))
        (spring-command (if (rspec-spring-p) "spring " nil)))
    (concat (or zeus-command spring-command bundle-command)
            (if (rspec-rake-p)
                (concat rspec-rake-command " spec")
              rspec-spec-command))))

(setq rspec-use-spring-when-possible t)
  (defun rspec-spring-p ()
    (and rspec-use-spring-when-possible
         (stringp (executable-find "spring"))))

(require 'rubocop)
(add-hook 'ruby-mode-hook 'rubocop-mode)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq flycheck-checker 'ruby-rubocop)))
;; See: https://qiita.com/watson1978/items/debafdfc49511fb173e9
;; 独自に checker を定義する（お好みで）
(flycheck-define-checker ruby-rubocop
  "A Ruby syntax and style checker using the RuboCop tool."
  :command ("rubocop" "--format" "emacs"
            (config-file "--config" flycheck-rubocoprc) source)
  :error-patterns
  ((warning line-start
            (file-name) ":" line ":" column ": " (or "C" "W") ": " (message) line-end)
   (error line-start
          (file-name) ":" line ":" column ": " (or "E" "F") ": " (message) line-end))
  :modes (ruby-mode motion-mode))

(setq flycheck-ruby-rubocop-executable "bundle exec rubocop")

(when (require 'rinari nil 'noerror)
  (require 'rinari)
  (add-hook 'ruby-mode-hook 'rinari-minor-mode))

(when (require 'rinari nil 'noerror)
  (require 'rspec-mode)
  (eval-after-load 'rspec-mode
    '(rspec-install-snippets)))

(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda ()
                             (ruby-electric-mode t)))

(require 'quickrun)
(global-set-key (kbd "<f8>") 'quickrun)

(require 'inf-ruby)
(setq inf-ruby-default-implementation "pry")
(setq inf-ruby-eval-binding "Pry.toplevel_binding")
;; riなどのエスケープシーケンスを処理し、色付けする
(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

(unless (package-installed-p 'slim-mode)
  (package-refresh-contents) (package-install 'slim-mode))
(add-to-list 'auto-mode-alist '("\\.slim?\\'" . slim-mode))

(setq ruby-insert-encoding-magic-comment nil)

(defcustom ruby-block-delay 0
    "*Time in seconds to delay before showing a matching paren."
    :type  'number
    :group 'ruby-block)

(require 'rcodetools)
(define-key ruby-mode-map (kbd "C-<return>") 'xmp)

(when window-system
  (progn
    ;; (inf-ruby)
    ;; (robe-start)
    ))

(require 'go-mode)
(require 'ob-go)

(use-package dap-mode
    :after lsp-mode
    :hook
    (lsp-mode . dap-mode)
    (lsp-mode . dap-ui-mode)
    :config
    (dap-mode 1)
    (require 'dap-hydra)
    (require 'dap-dlv-go))

(setq dap-print-io t)
(setq lsp-gopls-server-path "~/go/bin/gopls")
(setq dap-dlv-go-delve-path "~/go/bin/dlv")

(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)
;; (jedi:setup)
;; ;; (define-key jedi-mode-map (kbd "<C-tab>") nil) ;;C-tabはウィンドウの移動に用いる
;; (setq jedi:complete-on-dot t)
;; (setq ac-sources
;;       (delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;;jediの補完候補だけでいい
;; (add-to-list 'ac-sources 'ac-source-filename)
;; (add-to-list 'ac-sources 'ac-source-jedi-direct)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(custom-set-variables
 '(haskell-indent-after-keywords (quote (("where" 4 0) ("of" 4) ("do" 4) ("mdo" 4) ("rec" 4) ("in" 4 0) ("{" 4) "if" "then" "else" "let")))
 '(haskell-indent-offset 4)
 '(haskell-indent-spaces 4))

(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

(require 'origami)
(define-minor-mode origami-view-mode
  "TABにorigamiの折畳みを割り当てる"
  nil "折紙"
  '(("\C-i" . origami-cycle))
  (or origami-mode (origami-mode 1)))
(defun origami-cycle (recursive)
  "origamiの機能をorg風にまとめる"
  (interactive "P")
  (call-interactively
   (if recursive 'origami-toggle-all-nodes 'origami-toggle-node)))
(defun yaml-mode-hook--origami ()
  (when (eq major-mode 'yaml-mode)
    (origami-view-mode)))
(add-hook 'yaml-mode-hook 'yaml-mode-hook--origami)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.js[x]?$" . web-mode));; js + jsx
(add-to-list 'auto-mode-alist '("\\.tsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("blade"  . "\\.blade\\.")))

;; JS+JSX設定 ================

;; コメントアウトの設定
(add-hook 'web-mode-hook
          '(lambda ()
             (add-to-list 'web-mode-comment-formats '("jsx" . "//" ))))

;; .js でも JSX 編集モードに
(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))

;; JSシンタックスチェック ================
;; ESlint
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-disabled-checkers '(javascript-jshint javascript-jscs))
    ))
;; eslint 用の linter を登録
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; 作業している project の node-module をみて、適切に
;; linter の設定を読み込む
(eval-after-load 'web-mode
  '(progn
     (add-hook 'web-mode-hook #'add-node-modules-path)
     (add-hook 'web-mode-hook #'prettier-js-mode)))
(eval-after-load 'web-mode
  '(add-hook 'rjsx-mode-hook #'add-node-modules-path))
(add-hook 'web-mode-hook 'flycheck-mode)
(add-hook 'rjsx-mode-hook 'flycheck-mode)

;; 実行: M-x eslint-fix-file
(defun eslint-fix-file ()
  (interactive)
  (call-process-shell-command
   (mapconcat 'shell-quote-argument
              (list "eslint" "--fix" (buffer-file-name)) " ") nil 0))

;; 実行後、buffer を revert する
;; 実行: M-x eslint-fix-file-and-revert
(defun eslint-fix-file-and-revert ()
  (interactive)
  (eslint-fix-file)
  (revert-buffer t t))

;; インデント等調整 ================
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  ;; (setq web-mode-attr-indent-offset 0)
  ;; (setq web-mode-markup-indent-offset 0)
  ;; (setq web-mode-css-indent-offset 0)
  ;; (setq web-mode-code-indent-offset 0)
  ;; (setq web-mode-sql-indent-offset 0)
  ;; (setq sql-indent-offset 0)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq json-reformat:indent-width 2)

  (setq web-mode-attr-indent-offset nil)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-auto-close-style 2)
  (setq web-mode-tag-auto-close-style 2))
(add-hook 'web-mode-hook 'my-web-mode-hook)

;; CSS ================
(setq css-indent-offset 2)

;; SQL ================
(add-hook 'ejc-sql-minor-mode-hook
          (lambda ()
            (ejc-eldoc-setup)))

;; コマンドを大文字にする
(add-hook 'sql-mode-hook 'sqlup-mode)
(add-hook 'sql-interactive-mode-hook 'sqlup-mode)
(global-set-key (kbd "C-c u") 'sqlup-capitalize-keywords-in-region)

;; 結果を折り返さないようにする
(add-hook 'sql-interactive-mode-hook
          '(lambda()
             (setq truncate-lines nil
                   truncate-partial-width-windows t)))

(setq erc-server "irc.libera.chat"
      erc-nick "kijimad"
      erc-user-full-name "Kijima Daigo"
      erc-track-shorten-start 8
      erc-autojoin-channels-alist '(("irc-libera.chat" "#systemcrafters" "#emacs"))
      erc-kill-buffer-on-part t
      erc-auto-query 'bufy)

;; Typescript ================
(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(setq lsp-verify-signature nil)

(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  :custom
  (lsp-completion-provider :none)
  (lsp-prefer-flymake nil)
  (lsp-print-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  (lsp-auto-guess-root t)
  (lsp-document-sync-method 'incremental)
  (lsp-response-timeout 5)
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless))) ;; Configure orderless
  :hook
  (scala-mode . lsp)
  (clojure-mode . lsp)
  (c-mode . lsp)
  (c++-mode . lsp)
  (rust-mode . lsp)
  (go-mode . lsp)
  (lsp-mode . lsp-lens-mode)
  (lsp-mode . lsp-completion-mode)
  (lsp-mode . lsp-ui-mode)
  (lsp-completion-mode . my/lsp-mode-setup-completion)
  :config
  ;; Uncomment following section if you would like to tune lsp-mode performance according to
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  ;;       (setq gc-cons-threshold 100000000) ;; 100mb
  ;;       (setq read-process-output-max (* 1024 1024)) ;; 1mb
  ;;       (setq lsp-idle-delay 0.500)
  ;;       (setq lsp-log-io nil)
  )

;; (use-package scala-mode
;;   :interpreter
;;   ("scala" . scala-mode))

;; ;; Enable sbt mode for executing sbt commands
;; (use-package sbt-mode
;;   :commands sbt-start sbt-command
;;   :config
;;   ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
;;   ;; allows using SPACE when in the minibuffer
;;   (substitute-key-definition
;;    'minibuffer-complete-word
;;    'self-insert-command
;;    minibuffer-local-completion-map)
;;   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
;;   (setq sbt:program-options '("-Dsbt.supershell=false"))
;;   )

;; (use-package lsp-metals
;;   :ensure t
;;   :custom
;;   ;; Metals claims to support range formatting by default but it supports range
;;   ;; formatting of multiline strings only. You might want to disable it so that
;;   ;; emacs can use indentation provided by scala-mode.
;;   (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))
;;   :hook (scala-mode . lsp))

(use-package lsp-ui
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-max-width 150)
  (lsp-ui-doc-max-height 30)
  (lsp-ui-peek-enable t))

(use-package yasnippet)

(use-package posframe
  ;; Posframe is a pop-up tool that must be manually installed for dap-mode
  )

(use-package dap-ui
  :config
  (dap-ui-mode 1))

(require 'corfu)
(global-corfu-mode)

(setq corfu-auto t)
(setq corfu-auto-prefix 3)
(setq corfu-count 15)
(setq corfu-cycle t)
(setq corfu-preselect-first t) ;; 自動的に最初の候補を選択する
(setq corfu-quit-at-boundary t) ;; スペースを入れるとquit
(setq corfu-quit-no-match t)

(setq completion-cycle-threshold 3)

(defun corfu-beginning-of-prompt ()
  "Move to beginning of completion input."
  (interactive)
  (corfu--goto -1)
  (goto-char (car completion-in-region--data)))

(defun corfu-end-of-prompt ()
  "Move to end of completion input."
  (interactive)
  (corfu--goto -1)
  (goto-char (cadr completion-in-region--data)))

(define-key corfu-map [remap move-beginning-of-line] #'corfu-beginning-of-prompt)
(define-key corfu-map [remap move-end-of-line] #'corfu-end-of-prompt)

(require 'vertico)
(vertico-mode)
(setq vertico-count 20)

(require 'vertico-directory)
(define-key vertico-map (kbd "C-l") #'vertico-directory-up)
(define-key vertico-map "\r" #'vertico-directory-enter)  ;; enter dired
(define-key vertico-map "\d" #'vertico-directory-delete-char)

(require 'marginalia)
(marginalia-mode +1)
;; marginalia-annotatorsをサイクルする
(define-key minibuffer-local-map (kbd "C-M-a") #'marginalia-cycle)

(require 'orderless)
(setq completion-styles '(orderless partial-completion))
(setq completion-category-defaults nil)
(setq completion-category-overrides nil)

(orderless-define-completion-style orderless+initialism
  (orderless-matching-styles '(orderless-initialism ;;一番最初にinitializm
                               orderless-literal  ;;次にリテラルマッチ
                               orderless-regexp)))

;; (setq completion-category-defaults nil)
(setq completion-category-overrides
      '((eglot (styles orderless+initialism))
        (command (styles orderless+initialism))
        (symbol (styles orderless+initialism))
        (variable (styles orderless+initialism))))
(setq orderless-component-separator #'orderless-escapable-split-on-space)

(require 'cape)
(add-to-list 'completion-at-point-functions #'cape-file)
(add-to-list 'completion-at-point-functions #'cape-tex)
(add-to-list 'completion-at-point-functions #'cape-dabbrev)
(add-to-list 'completion-at-point-functions #'cape-keyword)
(add-to-list 'completion-at-point-functions #'cape-abbrev)
(add-to-list 'completion-at-point-functions #'cape-ispell)
(add-to-list 'completion-at-point-functions #'cape-symbol)

;; EmacsのSVG対応コンパイルが必要
(require 'kind-icon)
(setq kind-icon-default-face 'corfu-default)
;; If 4k, big size icon displayed.
;; (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
;; (pop corfu-margin-formatters)

;; Available commands
;; affe-grep: Filters the content of all text files in the current directory
;; affe-find: Filters the file paths of all files in the current directory
(require 'affe)
(consult-customize affe-grep :preview-key (kbd "M-."))
(defvar affe-orderless-regexp "")
(defun affe-orderless-regexp-compiler (input _type)
  (setq affe-orderless-regexp (orderless-pattern-compiler input))
  (cons affe-orderless-regexp
        (lambda (str) (orderless--highlight affe-orderless-regexp str))))
(setq affe-regexp-compiler #'affe-orderless-regexp-compiler)

;; (add-hook 'corfu-mode-hook 'corfu-doc-mode)

(require 'lispy)
(add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))

(define-key lispy-mode-map (kbd "M-<right>") 'next-buffer)
(define-key lispy-mode-map (kbd "M-<left>") 'previous-buffer)
(define-key lispy-mode-map (kbd "M-i") 'swiper-thing-at-point)

(when (require 'ivy-hydra nil t)
  (setq ivy-read-action-function #'ivy-hydra-read-action))

(setq magit-completing-read-function 'ivy-completing-read)

(when (setq enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode 1))

(define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

(setq ivy-truncate-lines nil)

(setq ivy-wrap t)

(setq ivy-count-format "%d -> %d ")

(setq ivy-use-selectable-prompt t)

(with-eval-after-load "ivy"
  (setf (alist-get 'counsel-mark-ring ivy-sort-functions-alist) nil))

(all-the-icons-ivy-rich-mode 1)
(ivy-rich-mode 1)

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

(when (require 'smex nil t)
  (setq smex-history-length 35)
  (setq smex-completion-method 'ivy))

(ivy-mode 1)

(global-set-key (kbd "C-x C-b") 'counsel-switch-buffer)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x C-u") 'ivy-resume)
(global-set-key (kbd "C-x C-g") 'counsel-git-grep)
(global-set-key (kbd "C-x r i") 'counsel-register)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "M-i") 'swiper-thing-at-point)

(setq counsel-search-engine 'google)

(counsel-mode 1)

(defun ad:counsel-ag (f &optional initial-input initial-directory extra-ag-args ag-prompt caller)
  (apply f (or initial-input (ivy-thing-at-point))
         (unless current-prefix-arg
           (or initial-directory default-directory))
         extra-ag-args ag-prompt caller))

(advice-add 'counsel-ag :around #'ad:counsel-ag)

(with-eval-after-load "eldoc"
  (defun ad:eldoc-message (f &optional string)
    (unless (active-minibuffer-window)
      (funcall f string)))
  (advice-add 'eldoc-message :around #'ad:eldoc-message))

(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  ;; (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history)
  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t
        eshell-git-prompt-use-theme 'multiline
        eshell-toggle-height-fraction 2
        eshell-toggle-use-projectile-root t))
(add-hook 'eshell-first-time-mode-hook 'efs/configure-eshell)

(global-set-key (kbd "C-M-;") 'eshell-toggle)

(add-hook 'eshell-first-time-mode-hook 'esh-autosuggest-mode)
(setq esh-autosuggest-delay 0.5)

(when window-system
  (require 'vterm)
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
  (setq vterm-toggle-scope 'project)
  (setq vterm-toggle-project-root t)
  (setq vterm-max-scrollback 10000)
  ;; toggle
  (global-set-key [f9] 'vterm-toggle)
  (global-set-key (kbd "C-M-:") 'vterm-toggle)
  (global-set-key [C-f9] 'vterm-toggle-cd)

  (setq vterm-toggle-fullscreen-p nil)
  (add-to-list 'display-buffer-alist
               '((lambda(bufname _) (with-current-buffer bufname
                                      (or (equal major-mode 'vterm-mode)
                                          (string-prefix-p vterm-buffer-name bufname))))
                 (display-buffer-reuse-window display-buffer-at-bottom)
                 ;;(display-buffer-reuse-window display-buffer-in-direction)
                 ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                 ;;(direction . bottom)
                 ;;(dedicated . t) ;dedicated is supported in emacs27
                 (reusable-frames . visible)
                 (window-height . 0.3))))

(require 'doom-themes)
(doom-themes-org-config)
(setq custom-safe-themes t)
(setq-default custom-enabled-themes '(doom-tokyo-night))

(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes)))
  (efs/org-font-setup)
  ;; (kd/set-modus-face)
  )

(add-hook 'after-init-hook 'reapply-themes)

(doom-modeline-mode)

;; 表示項目の設定
(setq doom-modeline-buffer-file-name-style 'truncate-with-project)
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-minor-modes nil)
(setq doom-modeline-buffer-encoding nil)
(line-number-mode)
(column-number-mode)
(doom-modeline-def-modeline
  'my-simple-line
  '(bar matches buffer-info remote-host input-method major-mode process buffer-position)
  '(misc-info vcs checker))

;; 縦調整
(defun my-doom-modeline--font-height ()
  (- (frame-char-height) 20))
(advice-add #'doom-modeline--font-height :override #'my-doom-modeline--font-height)
(setq doom-modeline-height 20)

(defun setup-custom-doom-modeline ()
  (doom-modeline-set-modeline 'my-simple-line 'default))
(add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)

(setup-custom-doom-modeline)

(defun kd/set-modus-face ()
  (setq modus-themes-slanted-constructs t
        modus-themes-bold-constructs t
        modus-themes-no-mixed-fonts t
        modus-themes-subtle-line-numbers t
        modus-themes-mode-line '(moody borderless)
        modus-themes-syntax 'faint
        modus-themes-paren-match 'intense-bold
        modus-themes-region 'bg-only
        modus-themes-diffs 'deuteranopia
        modus-themes-org-blocks 'gray-background
        modus-themes-variable-pitch-ui t
        modus-themes-variable-pitch-headings t
        modus-themes-scale-headings t
        modus-themes-scale-1 1.1
        modus-themes-scale-2 1.15
        modus-themes-scale-3 1.21
        modus-themes-scale-4 1.27
        modus-themes-scale-title 1.33)

  (set-face-foreground 'vertical-border "gray")

  (set-face-attribute 'mode-line nil
                      :background nil
                      :overline "black"
                      :underline nil
                      :box nil)

  (set-face-attribute 'mode-line-inactive nil
                      :background "white"
                      :overline "gray"
                      :underline nil
                      :box nil)

  (window-divider-mode 0))

(setq my-hidden-minor-modes
      '(
        abbrev-mode
        auto-highlight-symbol-mode
        auto-revert-mode
        back-button-mode
        beacon-mode
        command-log-mode
        ctags-auto-update-mode
        eldoc-mode
        flycheck-mode
        flyspell-mode
        global-whitespace-mode
        google-this-mode
        highlight-indent-guides-mode
        magit-auto-revert-mode
        projectile-mode
        projectile-rails-mode
        rinari-minor-mode
        robe-mode
        rubocop-mode
        ruby-electric-mode
        undo-tree-mode
        which-key-mode
        yas-minor-mode
        ))
(mapc (lambda (mode)
        (setq minor-mode-alist
              (cons (list mode "") (assq-delete-all mode minor-mode-alist))))
      my-hidden-minor-modes)
(setq minor-mode-alist nil)

(require 'exwm)
(require 'exwm-config)

(setq exwm-replace t)

(setq exwm-layout-show-all-buffers t)

(setq mouse-autoselect-window nil
        focus-follows-mouse t
        exwm-workspace-warp-cursor t
        exwm-workspace-number 5)

(add-hook 'exwm-update-class-hook
          (lambda ()
            (exwm-workspace-rename-buffer exwm-class-name)))
(add-hook 'exwm-update-title-hook
          (lambda ()
            (pcase exwm-class-name
              ("qutebrowser" (exwm-workspace-rename-buffer (format "Qutebrowser: %s" exwm-title)))
              ("chrome" (exwm-workspace-rename-buffer (format "Chrome: %s" exwm-title))))))

(defun kd/set-init ()
  "Window Manager関係の各種プログラムを起動する."
  (interactive)

  (kd/set-background)

  (call-process-shell-command "shepherd")
  (call-process-shell-command "~/dotfiles/.config/polybar/launch.sh")
  (call-process-shell-command "blueberry")

  (exwm-workspace-switch-create 2)
  (start-process-shell-command "google-chrome" nil "google-chrome")
  (sleep-for 1)
  (start-process-shell-command "firefox" nil "firefox")
  (sleep-for 1)
  (start-process-shell-command "spotify" nil "spotify")
  (sleep-for 1)

  (exwm-workspace-switch-create 0)
  (persp-switch "1")
  (delete-other-windows)
  (if (file-exists-p org-journal-dir)
      (org-journal-new-entry nil))
  (vterm-toggle)
  (vterm-toggle)
  (persp-switch "2")
  (find-file "~/roam")
  (vterm-toggle)
  (vterm-toggle)
  (org-agenda nil "z")
  (persp-switch "3")
  (split-window-right)
  (switch-to-buffer "firefox")
  (persp-switch "4")
  (switch-to-buffer "firefox")
  (vterm-toggle)
  (vterm-toggle)
  (persp-switch "5")
  (find-file "~/dotfiles")
  (vterm-toggle)
  (vterm-toggle)
  (magit-status)
  (persp-switch "6")
  (find-file "~/.emacs.d/conf")
  (vterm-toggle)
  (vterm-toggle)
  (magit-status)
  (persp-switch "7")
  (find-file "~/ProjectOrg")
  (persp-switch "8")
  (find-file "~/Project")
  (persp-switch "9")
  (elfeed)

  (exwm-workspace-switch-create 1)
  (persp-switch "1")
  (persp-switch "2")
  (find-file "~/roam")
  (org-agenda nil "z")
  (persp-switch "4")
  (switch-to-buffer "Google-chrome")
  (persp-switch "8")
  (find-file "~/Project")

  (exwm-workspace-switch-create 2)
  (switch-to-buffer "Spotify")

  (exwm-workspace-switch-create 0)
  (persp-switch "4")

  (message "settings done!"))

(defun kd/set-background ()
  "背景をセットする."
  (interactive)
  (start-process-shell-command "compton" nil "compton --config ~/dotfiles/.config/compton/compton.conf")
  (start-process-shell-command "fehbg" nil "~/dotfiles/.fehbg"))

(defvar kd/last-workspace-index 0)

(defun kd/exwm-workspace-switch-last ()
  (interactive)
  (let ((old kd/last-workspace-index))
    (setq kd/last-workspace-index exwm-workspace-current-index)
    (exwm-workspace-switch old)))

(define-key exwm-mode-map (kbd "C-M-:") 'vterm-toggle)
(define-key exwm-mode-map (kbd "C-M-<right>") 'persp-next)
(define-key exwm-mode-map (kbd "C-M-<left>") 'persp-prev)
(define-key exwm-mode-map (kbd "<henkan>") 'pretty-hydra-henkan/body)

(when window-system
  (progn
    (exwm-config-example)
    ;; (kd/set-init)
    ))

(require 'exwm-randr)
(setq exwm-randr-workspace-output-plist '(1 "HDMI-1"))
(add-hook 'exwm-randr-screen-change-hook
          (lambda ()
            (start-process-shell-command
             "xrandr" nil "xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1 --auto")))
(exwm-enable)
(exwm-randr-enable)

(defvar kd/polybar-process nil
  "Holds the process of the running Polybar instance, if any")

(defun kd/start-panel ()
  (interactive)
  (kd/kill-panel)
  (setq kd/polybar-process (start-process-shell-command "polybar" nil "~/dotfiles/.config/polybar/launch.sh")))

(defun kd/kill-panel ()
  (interactive)
  (when kd/polybar-process
    (ignore-errors
      (kill-process kd/polybar-process)))
  (setq kd/polybar-process nil))

(defun kd/polybar-exwm-workspace ()
  (pcase exwm-workspace-current-index
    (0 "%{F#797D7F}Work%{F-} Home")
    (1 "Work %{F#797D7F}Home%{F-}")
    (2 "")
    (3 "")
    (4 "")
    (9 "")))

(defun kd/send-polybar-exwm-workspace ()
  (kd/send-polybar-hook "exwm-workspace" 1))

(defun kd/send-polybar-hook (module-name hook-index)
  (start-process-shell-command "polybar-msg" nil (format "polybar-msg hook %s %s" module-name hook-index)))

(add-hook 'exwm-workspace-switch-hook #'kd/send-polybar-exwm-workspace)

(require 'perspective)
(setq persp-initial-frame-name "1")
(setq persp-modestring-dividers '("" "" " "))
(persp-mode 1)

(mapc (lambda (i)
        (persp-switch (int-to-string i)))
      (number-sequence 1 9))
(persp-switch "1")

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define pretty-hydra-henkan (:color blue :foreign-keys warn :title "Convenient Tools")
    ("Media"
     (("<prior>" kd/mint-volume-up "up")
      ("<next>" kd/mint-volume-down "down")
      ("<pause>" kd/player-stop "stop"))

     "Find"
     (("a" counsel-apropos "apropos")
      ("f" counsel-ag "ag")
      ("h" counsel-find-library "lib")
      ("i" counsel-imenu "imenu")
      ("r" counsel-register "register")
      ("b" counsel-bookmark "bookmark")
      ("p" persp-ivy-switch-buffer "persp-buffer"))

     "Execute"
     (("e" counsel-linux-app "run")
      ("c" recompile "recompile")
      ("s" counsel-search "google")
      ("!" org-pomodoro "start pomodoro"))

     "Git"
     (("g" magit-blame)
      (">" git-gutter+-next-hunk)
      ("<" git-gutter+-previous-hunk)
      ("@" git-timemachine))

     "Edit"
     (("q" query-replace "replace")
      ("y" ivy-yasnippet "yas"))

     "Window"
     (("l" (lambda nil (interactive) (persp-switch-last)) "Last")
      ("1" (lambda nil (interactive) (persp-switch (int-to-string 1))) "Journal")
      ("2" (lambda nil (interactive) (persp-switch (int-to-string 2))) "Roam")
      ("3" (lambda nil (interactive) (persp-switch (int-to-string 3))) "Browser(Half)")
      ("4" (lambda nil (interactive) (persp-switch (int-to-string 4))) "Browser(Full)")
      ("5" (lambda nil (interactive) (persp-switch (int-to-string 5))) "Dotfiles")
      ("6" (lambda nil (interactive) (persp-switch (int-to-string 6))) "Emacs")
      ("7" (lambda nil (interactive) (persp-switch (int-to-string 7))) "Sub")
      ("8" (lambda nil (interactive) (persp-switch (int-to-string 8))) "Main")
      ("9" (lambda nil (interactive) (persp-switch (int-to-string 9))) "Blueberry"))

     "Workspace"
     (("w" (lambda nil (interactive) (kd/exwm-workspace-switch-last)) "Last"))))

  (define-key global-map (kbd "<henkan>") 'pretty-hydra-henkan/body))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define pretty-hydra-projectile-rails-find (:color blue :foreign-keys warn :title "Projectile Rails")
    ("Current"
     (("M" projectile-rails-find-current-model      "Current model")
      ("V" projectile-rails-find-current-view       "Current view")
      ("C" projectile-rails-find-current-controller "Current controller")
      ("H" projectile-rails-find-current-helper     "Current helper")
      ("P" projectile-rails-find-current-spec       "Current spec")
      ("Z" projectile-rails-find-current-serializer "Current serializer"))

     "App"
     (("m" projectile-rails-find-model           "Model")
      ("v" projectile-rails-find-view            "View")
      ("c" projectile-rails-find-controller      "Controller")
      ("h" projectile-rails-find-helper          "Helper")
      ("@" projectile-rails-find-mailer          "Mailer")
      ("y" projectile-rails-find-layout       "Layout")
      ("z" projectile-rails-find-serializer      "Serializer"))

     "Assets"
     (("j" projectile-rails-find-javascript  "Javascript")
      ("s" projectile-rails-find-stylesheet  "CSS"))

     "Other"
     (("n" projectile-rails-find-migration    "Migration")
      ("r" projectile-rails-find-rake-task    "Rake task")
      ("i" projectile-rails-find-initializer  "Initializer")
      ("l" projectile-rails-find-lib          "Lib")
      ("p" projectile-rails-find-spec         "Spec")
      ("t" projectile-rails-find-locale       "Translation"))

     "Single Files"
     (("R" projectile-rails-goto-routes   "routes.rb")
      ("G" projectile-rails-goto-gemfile  "Gemfile")
      ("D" projectile-rails-goto-schema   "schema.rb")))))

(global-set-key (kbd "M-SPC") #'major-mode-hydra)

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define emacs-lisp-mode nil
    ("Eval"
     (("b" eval-buffer "buffer")
      ("e" eval-defun "defun"))
     "REPL"
     (("I" ielm "ielm"))
     "Test"
     (("r" (ert-run-tests-interactively (car ert--selector-history)) "rerun")
      ("t" ert "prompt")
      ("T" (ert t) "all")
      ("F" (ert :failed) "failed"))
     "Doc"
     (("f" describe-function "function")
      ("v" describe-variable "variable")
      ("i" info-lookup-symbol "info lookup")))))

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define org-agenda-mode nil
    ("pomodoro"
     (("s" org-pomodoro "start org-pomodoro")))))

(defun kd/mint-volume-up ()
  "Linux Mintでの音量アップ."
  (interactive)
  (start-process-shell-command "volume up" nil "pactl set-sink-volume @DEFAULT_SINK@ +5%"))

(defun kd/mint-volume-down ()
  "Linux Mintでの音量ダウン."
  (interactive)
  (start-process-shell-command "volume up" nil "pactl set-sink-volume @DEFAULT_SINK@ -5%"))

(defun kd/player-stop ()
  "再生停止"
  (interactive)
  (start-process-shell-command "player stop" nil "playerctl stop"))

(defun kd/up-network ()
  "ネットワーク接続"
  (interactive)
  (let ((passwd))
    (setq passwd (read-passwd "Password? "))
    (shell-command  (concat "for intf in /sys/class/net/*; do echo "
                            (shell-quote-argument passwd)
                            " | sudo -S ifconfig `basename $intf` up; done"))))
(defun kd/down-network ()
  "ネットワーク切断"
  (interactive)
  (let ((passwd))
    (setq passwd (read-passwd "Password? "))
    (shell-command  (concat "for intf in /sys/class/net/*; do echo "
                            (shell-quote-argument passwd)
                            " | sudo -S ifconfig `basename $intf` down; done"))))

;; (use-package ej-dict
;;   :straight (:host github :repo "kijimaD/ej-dict"))
;; (ej-dict-install-dict)

(defun my-exchange-point-and-mark ()
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark))
(global-set-key (kbd "C-x C-x") 'my-exchange-point-and-mark)

(global-set-key (kbd "C-c C-k") 'kill-whole-line)

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
           (error-message-string "Fail to get path name.")))))

(defun my-isearch-done-opposite (&optional nopush edit)
  "End current search in the opposite side of the match."
  (interactive)
  (funcall #'isearch-done nopush edit)
  (when isearch-other-end (goto-char isearch-other-end)))

(defun my-next-line ()
  (interactive)
  (next-line)
  (recenter))
(global-set-key (kbd "<down>") 'my-next-line)

(defun my-previous-line ()
  (interactive)
  (previous-line)
  (recenter))
(global-set-key (kbd "<up>") 'my-previous-line)

(eval-after-load "eww"
  '(progn
     (define-key eww-mode-map (kbd "<mouse-1>") 'my-next-line)
     (define-key eww-mode-map (kbd "<mouse-2>") 'define-word-at-point)
     (define-key eww-mode-map (kbd "<mouse-4>") 'my-previous-line)
     (define-key eww-mode-map (kbd "<down-mouse-4>") 'nil)
     (define-key eww-mode-map (kbd "<mouse-5>") 'my-next-line)
     (define-key eww-mode-map (kbd "<down-mouse-5>") 'nil)
     (define-key eww-mode-map (kbd "<mouse-3>") 'my-previous-line)
     (define-key eww-mode-map (kbd "<mouse-8>") 'backward-word)
     (define-key eww-mode-map (kbd "<mouse-9>") 'forward-word)))

(defun kd/cancel-last-timer ()
  (interactive)
  (cancel-timer (car (last timer-list))))

;; Emacs C source directory
(let ((src-dir "~/ProjectOrg/emacs/emacs/src"))
  (if (file-directory-p src-dir)
      (setq source-directory src-dir)))
