;; org-journal-test.el --- Test file for org-journal
;;
;; Author: Christian Schwarzgruber (c.schwarzgruber.cs@gmail.com)
;;
;; Copyright (c) Christian Schwarzgruber
;;
;; Description:
;;

(require 'ert)
(require 'org-journal)

(defvar org-journal-dir-test "/tmp/org-journal")

(defun org-journal-dir-test-setup ()
  "Create temporary directory."
  (when (file-exists-p org-journal-dir-test)
    (delete-directory org-journal-dir-test t))
  (when (file-exists-p org-journal-cache-file)
    (delete-file org-journal-cache-file))
  (make-directory org-journal-dir-test))

(defun org-journal-file-pattern-test ()
  (org-journal-dir-and-format->regex
   org-journal-dir org-journal-file-format))

(defmacro org-journal-test-macro (&rest body)
  "Wrapp a `org-journal' -- `ert'-test with default values."
  `(let* ((org-journal-dir org-journal-dir-test)
          (comment-start-skip "^\\s-*#\\(?: \\|$\\)")
          (org-journal-file-pattern (org-journal-file-pattern-test))
          (auto-mode-alist `(,(cons org-journal-file-pattern 'org-journal-mode) ,@auto-mode-alist))
          (org-journal-file-type 'daily)
          (org-journal-carryover-items "TODO=\"TODO\"")
          (org-journal-cache-file "/tmp/org-journal.cache")
          (org-journal-flatten-dates nil)
          (org-journal-dates (make-hash-table :test 'equal))
          (org-journal-journals (make-hash-table :test 'equal))
          (org-journal-encrypt-journal nil)
          (org-journal-enable-encryption nil)
          (org-journal-date-format "Test header")
          (org-agenda-inhibit-startup t)
          (org-journal-time-format "%R")
          (new-entry (concat "** " (format-time-string org-journal-time-format))))
     (org-journal-dir-test-setup)
     ,@body))

(ert-deftest org-journal-calendar-date-from-file ()
  "Should return a list with day/month/year"
  (org-journal-dir-test-setup)
  (let* ((org-journal-dir org-journal-dir-test)
         (org-journal-file-pattern (org-journal-file-pattern-test)))
    (should (equal (org-journal-file-name->calendar-date
                    (expand-file-name "20190103" org-journal-dir))
                   '(1 03 2019)))))

(ert-deftest org-journal-convert-time-to-file-type-time-test ()
  "Testing"
  (let ((time (current-time))
        (org-journal-file-type 'daily))
    (should (equal (org-journal-convert-time-to-file-type-time time)
                   time))
    (setq time (encode-time 0 0 0 3 1 2019)
          org-journal-file-type 'weekly)
    (should (equal (org-journal-convert-time-to-file-type-time time)
                   (encode-time 0 0 0 31 12 2018)))
    (setq time (encode-time 0 0 0 15 4 2019)
          org-journal-file-type 'monthly)
    (should (equal (org-journal-convert-time-to-file-type-time time)
                   (encode-time 0 0 0 1 4 2019)))
    (setq time (encode-time 0 0 0 3 2 2019)
          org-journal-file-type 'yearly)
    (should (equal (org-journal-convert-time-to-file-type-time time)
                   (encode-time 0 0 0 1 1 2019)))))


(ert-deftest org-journal-carryover-items-test ()
  "Org journal new entry test."
  (org-journal-test-macro
   (let ((org-journal-file-type 'weekly))
     (with-temp-buffer
       (insert "* Tuesday, 01/01/19\n")
       (org-set-property "CREATED" "20190101")
       (insert "** 13:00 Some journal entry\n")
       (insert "* Wednesday, 01/02/19\n")
       (org-set-property "CREATED" "20190102")
       (insert "** TODO First\n")
       (insert "** 13:00 Some journal entry 1\n")
       (insert "** TODO Second\n")
       (insert "** 14:00 Some journal entry 2\n")
       (write-file (expand-file-name "20181231" org-journal-dir-test))
       (kill-buffer "20181231"))
     (org-journal-new-entry nil)
     (write-file (org-journal-get-entry-path))
     (kill-buffer)
     (should (string= (with-temp-buffer
                        (insert-file-contents (org-journal-get-entry-path))
                        (buffer-substring-no-properties (point-min) (point-max)))
                      (concat "* Test header\n  :PROPERTIES:\n  :CREATED:  "
                              (format-time-string "%Y%m%d")
                              "\n  :END:\n** TODO First\n** TODO Second\n"
                              new-entry "\n"))))))

(ert-deftest org-journal-carryover-keep-parents-test ()
  "Org journal new entry test for daily files."
  (org-journal-test-macro
   (with-temp-buffer
     (insert "* Wednesday, 01/02/19\n")
     (insert "** a\n")
     (insert "** TODO a\n")
     (insert "** b1\n")
     (insert "*** TODO b1\n")
     (insert "*** DONE b1\n")
     (insert "*** b1 note\n")
     (insert "*** b2\n")
     (insert "**** TODO b2\n")
     (insert "**** b3\n")
     (insert "***** TODO b3\n")
     (insert "***** DONE b3\n")
     (insert "** TODO b\n")
     (insert "** 14:00 Some journal entry 2\n")
     (write-file (expand-file-name "20181231" org-journal-dir-test))
     (kill-buffer "20181231"))
   (org-journal-new-entry nil)
   (write-file (org-journal-get-entry-path))
   (kill-buffer)
   (should (string= (with-temp-buffer
                      (insert-file-contents (org-journal-get-entry-path))
                      (buffer-substring-no-properties (point-min) (point-max)))
                    (concat "* Test header\n** TODO a\n** b1\n*** TODO b1\n*** b2\n**** TODO b2\n**** b3\n***** TODO b3\n** TODO b\n" new-entry "\n")))))


(ert-deftest org-journal-search-build-file-list-test ()
  "Test for `org-journal-search-build-file-list'."
  (org-journal-test-macro
   (let ((test-file-daily '("20170104" "20170312" "20190201"))
         (test-file-yearly '("20170101" "20180101" "20190101"))
         (test-file-weekly '("20170102" "20180430" "20181231"))
         (test-file-monthly '("20170101" "20180401" "20190301"))
         (create-files (lambda (test-files)
                         (org-journal-dir-test-setup)
                         (dolist (file test-files)
                           (with-temp-buffer
                             (write-file (expand-file-name file org-journal-dir-test))))))
         period-start
         period-end)
     (message "Running daily org-journal-search-build-file-list-test")
     ;; Daily build file boundary check
     (setq period-start (encode-time 0 0 0 4 1 2017)
           period-end (encode-time 0 0 0 1 2 2019))
     (funcall create-files test-file-daily)
     (should (equal (length (org-journal-search-build-file-list period-start period-end)) 1))

     (message "Running weekly org-journal-search-build-file-list-test")
     (setq period-start (encode-time 0 0 0 8 1 2017)
           period-end (encode-time 0 0 0 31 12 2018))
     ;; Weekly build file boundary check
     (setq org-journal-file-type 'weekly)
     (funcall create-files test-file-weekly)
     (should (equal (length (org-journal-search-build-file-list period-start period-end)) 1))

     (message "Running monthly org-journal-search-build-file-list-test")
     (setq period-start (encode-time 0 0 0 31 1 2017)
           period-end (encode-time 0 0 0 1 3 2019))
     ;; Monthly build file boundary check
     (setq org-journal-file-type 'monthly)
     (funcall create-files test-file-monthly)
     (should (equal (length (org-journal-search-build-file-list period-start period-end)) 1))

     (message "Running yearly org-journal-search-build-file-list-test")
     (setq period-start (encode-time 0 0 0 31 12 2017)
           period-end (encode-time 0 0 0 1 1 2019))
     ;; Yearly build file boundary check
     (setq org-journal-file-type 'yearly)
     (funcall create-files test-file-yearly)
     (should (equal (length (org-journal-search-build-file-list period-start period-end)) 1)))))
