;;; wc-goal-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "wc-goal-mode" "wc-goal-mode.el" (23393 27873
;;;;;;  68173 40000))
;;; Generated autoloads from wc-goal-mode.el

(autoload 'wc-goal-mode "wc-goal-mode" "\
Toggle wc mode With no argument, this command toggles the
mode.  Non-null prefix argument turns on the mode.  Null prefix
argument turns off the mode.

When Wc mode is enabled on a buffer, it counts the current words
in the buffer and keeps track of a differential of added or
subtracted words.

A goal of number of words added/subtracted can be set while using
this mode. Upon completion of the goal, the modeline text will
highlight indicating that the goal has been reached.

Commands:
\\{wc-goal-mode-map}

Entry to this mode calls the value of `wc-goal-mode-hook' if that
value is non-nil.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; wc-goal-mode-autoloads.el ends here
