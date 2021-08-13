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

;; 画像表示
(setq org-startup-with-inline-images t)

;; 展開アイコン
;; (setq org-ellipsis "»")
;; (setq org-ellipsis "..")
;; (setq org-ellipsis "⤵")
;; (setq org-ellipsis "🢗")
;; (setq org-ellipsis "❖")
(setq org-ellipsis " ↯")
(setq org-cycle-separator-lines -1)

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
(global-set-key (kbd "<f6>") 'org-tree-slide-mode)
(global-set-key (kbd "S-<f6>") 'org-tree-slide-skip-done-toggle)
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

(setq org-roam-capture-templates
      '(("d" "default" plain
         "%?"
         :if-new
         (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}"))
        ("l" "programming language" plain
         (file "~/roam/templates/programming-language.org")
         :if-new
         (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}"))
        ("p" "project" plain
         (file "~/roam/templates/project.org")
         :if-new
         (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project"))
        ))

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
                  (org-level-2 . 1.0)
                  (org-level-3 . 1.0)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Jost" :weight 'extra-bold :height (cdr face)))

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
