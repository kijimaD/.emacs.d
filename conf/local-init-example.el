;; 環境によってlocal-init.elに追加する。CI用に、local-initがないときにも読み込むようにしている。

;; Linux
(setq public-directory "Dropbox")
(setq my-migemo-command "cmigemo")
(setq my-migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")

;; Mac
;; (setq public-directory "dropbox")
;; (setq my-migemo-command "/usr/local/bin/cmigemo")
;; (setq my-migemo-dictionary "/usr/local/Cellar/cmigemo/HEAD-5c014a8/share/migemo/utf-8/migemo-dict")
;; (setq ns-command-modifier (quote meta))
;; (setq ns-alternate-modifier (quote super))
;; (setq ctags-auto-update-mode nil)
