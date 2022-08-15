(require 'org-pomodoro)
(define-key global-map [insert] 'org-pomodoro)

(setq org-pomodoro-short-break-length 0)
(setq org-pomodoro-long-break-length 10)
(setq org-pomodoro-expiry-time 120)

(setq org-pomodoro-finished-sound "~/.emacs.d/resources/pmd-finished.wav")
;; (org-pomodoro-finished)
(setq org-pomodoro-short-break-sound "~/.emacs.d/resources/pmd-short-break.wav")
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

;; https://colekillian.com/posts/org-pomodoro-and-polybar/
(defun kd/org-pomodoro-time ()
  "Return the remaining pomodoro time. Function for displaying in Polybar."
  (if (org-pomodoro-active-p)
      (cl-case org-pomodoro-state
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
         (format "Overtime! %dm" (/ (org-pomodoro-remaining-seconds) 60))))
    "Not working..."))

(defvar kd/pmd-today-point 0)
(add-hook 'org-pomodoro-finished-hook
          (lambda () (setq kd/pmd-today-point (1+ kd/pmd-today-point))))

(defun kd/write-pmd (str)
  (shell-command (format "echo '%s' >> ~/roam/pmd.csv" str)))

;; reset point
(run-at-time "23:59pm" (* 24 60 60) (lambda ()
                                      (kd/write-pmd (concat (format-time-string "%Y-%m-%d")
                                                            ", "
                                                            (number-to-string kd/pmd-today-point)))
                                      (setq kd/pmd-today-point 0)
                                      (message "pomodoro count reset!")))

(defun kd/pmd-today-point-display ()
  ;; (format " [%s]" kd/pmd-today-point)
  (let* ((all-minute (* kd/pmd-today-point 25))
         (hour (/ all-minute 60))
         (minute (% all-minute 60)))
  (format " %spts/%02dh%02dm" kd/pmd-today-point hour minute)))
