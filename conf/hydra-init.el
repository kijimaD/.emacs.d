(use-package hydra-posframe
  :straight (:host github :repo "Ladicle/hydra-posframe")
  :hook (after-init . hydra-posframe-enable))

(with-eval-after-load 'pretty-hydra
  ;; projectile-rails ================
  ;; https://mugijiru.github.io/.emacs.d/programming/rails/
  (pretty-hydra-define pretty-hydra-projectile-rails-find (:separator "-" :color blue :foreign-keys warn :title "Projectile Rails")
    ("Current"
     (("M" projectile-rails-find-current-model      "Current model")
      ("V" projectile-rails-find-current-view       "Current view")
      ("C" projectile-rails-find-current-controller "Current controller")
      ("H" projectile-rails-find-current-helper     "Current helper")
      ("P" projectile-rails-find-current-spec       "Current spec")
      ("Z" projectile-rails-find-current-serializer "Current serializer"))

     "App"
     (("m" projectile-rails-find-model           "Model")
      ("v" projectile-rails-find-view            "View")
      ("c" projectile-rails-find-controller      "Controller")
      ("h" projectile-rails-find-helper          "Helper")
      ("@" projectile-rails-find-mailer          "Mailer")
      ("y" projectile-rails-find-layout       "Layout")
      ("z" projectile-rails-find-serializer      "Serializer"))

     "Assets"
     (("j" projectile-rails-find-javascript  "Javascript")
      ("s" projectile-rails-find-stylesheet  "CSS"))

     "Other"
     (("n" projectile-rails-find-migration    "Migration")
      ("r" projectile-rails-find-rake-task    "Rake task")
      ("i" projectile-rails-find-initializer  "Initializer")
      ("l" projectile-rails-find-lib          "Lib")
      ("p" projectile-rails-find-spec         "Spec")
      ("t" projectile-rails-find-locale       "Translation"))

     "Single Files"
     (("R" projectile-rails-goto-routes   "routes.rb")
      ("G" projectile-rails-goto-gemfile  "Gemfile")
      ("D" projectile-rails-goto-schema   "schema.rb"))))

  (pretty-hydra-define+ pretty-hydra-henkan (:foreign-keys warn :title "Convenient Tools" :quit-key "g")
    ("Media"
     (("<prior>" kd/mint-volume-up "up")
      ("<next>" kd/mint-volume-down "down"))

     "Move"
     (("a" counsel-apropos "apropos")
      ("f" counsel-ag "ag")
      ("h" counsel-find-library "lib")
      ("i" counsel-imenu "imenu")
      ("r" counsel-mark-ring "ring")
      ("b" counsel-bookmark "bookmark"))

     "Execute"
     (("e" counsel-linux-app "run")
      ("c" recompile "recompile")
      ("s" counsel-search "google")
      )

     "Edit"
     (("q" query-replace "replace")
      ("y" ivy-yasnippet "yas")
     )))

  (define-key projectile-rails-mode-map (kbd "C-c r") 'pretty-hydra-projectile-rails-find/body)
  (define-key global-map (kbd "<henkan>") 'pretty-hydra-henkan/body))

;; major-mode-hydra ================

(global-set-key (kbd "M-SPC") #'major-mode-hydra)

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define emacs-lisp-mode nil
    ("Eval"
     (("b" eval-buffer "buffer")
      ("e" eval-defun "defun")
      ("r" eval-region "region"))
     "REPL"
     (("I" ielm "ielm"))
     "Test"
     (("t" ert "prompt")
      ("T" (ert t) "all")
      ("F" (ert :failed) "failed"))
     "Doc"
     (("f" describe-function "function")
      ("v" describe-variable "variable")
      ("i" info-lookup-symbol "info lookup")))))
