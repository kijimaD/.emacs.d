;;; current-word-highlight-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "current-word-highlight" "current-word-highlight.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from current-word-highlight.el

(autoload 'current-word-highlight-mode "current-word-highlight" "\
Current-Word-Highlight Minor Mode

\(fn &optional ARG)" t nil)

(defvar global-current-word-highlight-mode nil "\
Non-nil if Global Current-Word-Highlight mode is enabled.
See the `global-current-word-highlight-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-current-word-highlight-mode'.")

(custom-autoload 'global-current-word-highlight-mode "current-word-highlight" nil)

(autoload 'global-current-word-highlight-mode "current-word-highlight" "\
Toggle Current-Word-Highlight mode in all buffers.
With prefix ARG, enable Global Current-Word-Highlight mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Current-Word-Highlight mode is enabled in all buffers where
`current-word-highlight-mode-maybe' would do it.
See `current-word-highlight-mode' for more information on Current-Word-Highlight mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "current-word-highlight" '("current-word-highlight-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; current-word-highlight-autoloads.el ends here
