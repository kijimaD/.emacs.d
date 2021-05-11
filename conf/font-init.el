;; (custom-set-faces
;;  '(default ((t (:family "Menlo" :slant normal :weight normal :height 90 :width normal :foundry "PfEd")))))
;; (set-fontset-font t 'japanese-jisx0208 (font-spec :family "ヒラギノ 角ゴ ProN"))

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

;; For when Emacs is started in GUI mode:
(--set-emoji-font nil)
;; Hook for when a frame is created with emacsclient
;; see https://www.gnu.org/software/emacs/manual/html_node/elisp/Creating-Frames.html
(add-hook 'after-make-frame-functions '--set-emoji-font)
