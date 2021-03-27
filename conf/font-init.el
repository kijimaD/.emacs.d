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
