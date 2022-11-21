(require 'go-mode)
(require 'ob-go)

;; Go デバッガー
(use-package dap-mode
  :after lsp-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode)
  :config
  (dap-mode 1)
  (require 'dap-hydra)
  (require 'dap-dlv-go))

(setq dap-print-io t)
(setq lsp-gopls-server-path "~/go/bin/gopls")
(setq dap-dlv-go-delve-path "~/go/bin/dlv")

(setq dap-print-io t)

(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

(add-hook 'before-save-hook 'gofmt-before-save)
