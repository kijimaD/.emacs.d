;; (defvar efs/frame-transparency '(90 . 90))
;; (set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
;; (add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))

;; Set the font face based on platform
(when window-system
  (progn
    (pcase system-type
      ((or 'gnu/linux 'windows-nt 'cygwin)
       (set-face-attribute 'default nil
                           :font "Fira Mono"
                           :weight 'regular
                           :height 100)
       (set-fontset-font
        nil 'japanese-jisx0208
        (font-spec :family "Hiragino Sans")))
      ('darwin
       (set-face-attribute 'default nil
                           :font "Fira Mono"
                           :height 150)
       (set-fontset-font
        nil 'japanese-jisx0208
        (font-spec :family "Hiragino Sans"))))))

;; "JetBrains Mono"
;; "Iosevka SS08"
;; "Fira Mono"
;; "Hiragino Sans" -- (japanese)

;; 文字コード ================
;;ターミナルの文字コード
(set-terminal-coding-system 'utf-8)
;;キーボードから入力される文字コード
(set-keyboard-coding-system 'utf-8)
;;ファイルのバッファのデフォルト文字コード
(set-buffer-file-coding-system 'utf-8)
;;バッファのプロセスの文字コード
(setq default-buffer-file-coding-system 'utf-8)
;;ファイルの文字コード
(setq file-name-coding-system 'utf-8)
;;新規作成ファイルの文字コード
(set-default-coding-systems 'utf-8)

;; 絵文字フォント ================
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
    (add-hook 'after-make-frame-functions '--set-emoji-font)))

(when (not window-system)
  (progn
    ;; CUI用設定
    ))

;; unicodefont ================
(require 'unicode-fonts)
(unicode-fonts-setup)
