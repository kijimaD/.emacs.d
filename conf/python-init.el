;; Python開発環境 ====
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(jedi:setup)
;; (define-key jedi-mode-map (kbd "<C-tab>") nil) ;;C-tabはウィンドウの移動に用いる
(setq jedi:complete-on-dot t)
(setq ac-sources
      (delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;;jediの補完候補だけでいい
(add-to-list 'ac-sources 'ac-source-filename)
(add-to-list 'ac-sources 'ac-source-jedi-direct)
