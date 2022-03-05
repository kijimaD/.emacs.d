;; -*- mode: emacs-lisp; coding: utf-8-unix -*-

;; https://tam5917.hatenablog.com/entry/2022/02/05/141115

(require 'corfu)
(corfu-global-mode)
(setq corfu-cycle t)
(setq corfu-auto t)
(setq corfu-quit-at-boundary nil) ;; nil: スペースを入れてもquitしない
(setq corfu-quit-no-match nil) ;; nil: マッチしないとき"no match"を表示してquitしない
(setq corfu-auto-prefix 3)
(setq corfu-count 15)

;; TAB cycle if there are only few candidates
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
(setq completion-styles '(orderless))

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
(add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
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

(use-package corfu-doc
  :straight (:host github :repo "galeo/corfu-doc")
  :hook (corfu-mode-hook . corfu-doc-mode))

(defun corfu-lsp-setup ()
  (setq-local completion-styles '(orderless)
              completion-category-defaults nil))
(add-hook 'lsp-mode-hook #'corfu-lsp-setup)
