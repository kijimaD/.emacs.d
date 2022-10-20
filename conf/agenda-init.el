;; agenda ================
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

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

(setq my-org-directory (concat "~/Private/junk/diary/org-journal/"))
(setq my-todo-file (concat my-org-directory "todo.org"))

(if (file-exists-p my-todo-file)
    (setq org-agenda-files `("~/roam" ,my-todo-file)))

(setq org-directory my-org-directory)
(setq org-default-notes-file my-todo-file)

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

;; org-super-agenda ================
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
