(push '(fullscreen . maximized) default-frame-alist)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Built in TODO highlight 
(global-hl-todo-mode)

;; evil mode engaged
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; Evil mode in more places
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Evil matchit that lets you traverse matching sections with %
(use-package evil-matchit
  :ensure t)
(global-evil-matchit-mode 1)

(use-package evil-indent-plus
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

;; Inherit my shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; General.el for leader keys
(use-package general
  :ensure t
  :config
  (general-create-definer my/leader-def
    :states '(normal visual)
    :prefix "SPC")

  ;; Top-level shortcuts
  (my/leader-def
    "SPC" '(execute-extended-command :which-key "M-x")
    "."   '(find-file :which-key "find file")
    ":"   '(eval-expression :which-key "eval")
    ";"   '(comment-dwim :which-key "comment"))

  ;; Files
  (my/leader-def
    "f"   '(:ignore t :which-key "files")
    "ff"  '(find-file :which-key "find file")
    "fs"  '(save-buffer :which-key "save")
    "fr"  '(recentf-open-files :which-key "recent")
    "fR"  '(rename-file :which-key "rename")
    "fD"  '(delete-file :which-key "delete"))

  ;; Buffers
  (my/leader-def
    "b"   '(:ignore t :which-key "buffers")
    "bb"  '(switch-to-buffer :which-key "switch")
    "bd"  '(kill-current-buffer :which-key "kill")
    "br"  '(revert-buffer :which-key "revert")
    "bl"  '(ibuffer :which-key "list"))

  ;; Windows
  (my/leader-def
    "w"   '(:ignore t :which-key "windows")
    "wv"  '(split-window-right :which-key "split right")
    "ws"  '(split-window-below :which-key "split below")
    "wd"  '(delete-window :which-key "delete")
    "wD"  '(delete-other-windows :which-key "delete others")
    "w="  '(balance-windows :which-key "balance"))

  ;; Search
  (my/leader-def
    "s"   '(:ignore t :which-key "search")
    "ss"  '(isearch-forward :which-key "search forward")
    "sr"  '(isearch-backward :which-key "search backward")
    "sg"  '(grep :which-key "grep"))

  ;; Code / LSP (eglot)
  (my/leader-def
    "c"   '(:ignore t :which-key "code")
    "cd"  '(xref-find-definitions :which-key "definition")
    "cD"  '(xref-find-definitions-other-window :which-key "definition other window")
    "cr"  '(xref-find-references :which-key "references")
    "cn"  '(eglot-rename :which-key "rename")
    "ca"  '(eglot-code-actions :which-key "code actions")
    "cf"  '(eglot-format :which-key "format")
    "cF"  '(eglot-format-buffer :which-key "format buffer")
    "ch"  '(eldoc :which-key "hover/docs")
    "ci"  '(eglot-find-implementation :which-key "implementation")
    "ct"  '(eglot-find-typeDefinition :which-key "type definition")
    "ce"  '(flymake-show-buffer-diagnostics :which-key "errors list")
    "cj"  '(flymake-goto-next-error :which-key "next error")
    "ck"  '(flymake-goto-prev-error :which-key "prev error"))

  ;; Eglot management
  (my/leader-def
    "l"   '(:ignore t :which-key "lsp")
    "ls"  '(eglot :which-key "start")
    "lq"  '(eglot-shutdown :which-key "shutdown")
    "lr"  '(eglot-reconnect :which-key "reconnect")
    "lw"  '(eglot-show-workspace-configuration :which-key "workspace config"))

  ;; Git (if using magit)
  (my/leader-def
    "g"   '(:ignore t :which-key "git")
    "gg"  '(magit-status :which-key "status")
    "gb"  '(magit-blame :which-key "blame")
    "gl"  '(magit-log-current :which-key "log"))

  ;; Help
  (my/leader-def
    "h"   '(:ignore t :which-key "help")
    "hf"  '(describe-function :which-key "function")
    "hv"  '(describe-variable :which-key "variable")
    "hk"  '(describe-key :which-key "key")
    "hm"  '(describe-mode :which-key "mode"))

  ;; Toggle
  (my/leader-def
    "t"   '(:ignore t :which-key "toggle")
    "tn"  '(display-line-numbers-mode :which-key "line numbers")
    "tw"  '(whitespace-mode :which-key "whitespace")
    "tt"  '(treemacs :which-key "treemacs"))

  ;; Projectile
  (my/leader-def
  "p"   '(:ignore t :which-key "project")
  "pp"  '(projectile-switch-project :which-key "switch project")
  "pf"  '(projectile-find-file :which-key "find file")
  "ps"  '(projectile-ripgrep :which-key "search")
  "pb"  '(projectile-switch-to-buffer :which-key "buffers")
  "pk"  '(projectile-kill-buffers :which-key "kill buffers"))

  )

;; Define neovim like windows navigation
(general-define-key
  :states '(normal insert visual emacs motion)
  "C-h" 'evil-window-left
  "C-j" 'evil-window-down
  "C-k" 'evil-window-up
  "C-l" 'evil-window-right)

(general-define-key
  :keymaps '(minibuffer-local-map
             minibuffer-local-ns-map
             minibuffer-local-completion-map
             minibuffer-local-must-match-map)
  "<escape>" 'abort-minibuffers)

;; Add a short cut for creating a new file in dired mode
(with-eval-after-load 'dired
  (general-define-key
    :keymaps 'dired-mode-map
    :states 'normal
    "o" 'dired-create-empty-file))

;; Override dired space functionality
(with-eval-after-load 'dired
  (general-define-key
    :keymaps 'dired-mode-map
    :states 'normal
    "SPC" nil))

;; Enable gcc and gc comment/uncommenting
(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode 1))

;; Enable vim like undo tre
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (evil-set-undo-system 'undo-tree))

;; Show tabs
(setq whitespace-style '(face tabs tab-mark))
(setq whitespace-display-mappings
      '((tab-mark ?\t [?› ?\t])))    ; show tabs as ›
(global-whitespace-mode 1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:foreground "gray40" :background unspecified)))))

(use-package conda
  :ensure t
  :config
  (conda-env-autoactivate-mode t)
  (setq conda-anaconda-home (expand-file-name "~/miniconda3"))
  (setq conda-env-home-directory (expand-file-name "~/miniconda3")))


;; This appears to not work so use list-packages-list to install instead and then restart
;; A nice theme
;;(use-package zenburn-theme
;;  :config
(load-theme 'zenburn t)

;; magit
(use-package magit
  :ensure t)
;; Do some stuff after magit load
(with-eval-after-load 'magit
  (general-define-key
    :keymaps '(magit-mode-map 
               magit-status-mode-map 
               magit-log-mode-map 
               magit-diff-mode-map
               magit-revision-mode-map)
    :states '(normal visual emacs)
    "C-h" 'evil-window-left
    "C-j" 'evil-window-down
    "C-k" 'evil-window-up
    "C-l" 'evil-window-right))

;; vterm
(use-package vterm
  :ensure t)

;; yaml
(use-package yaml
  :ensure t)

;; which-key
(use-package which-key
  :ensure t)

(which-key-mode)

;; js2-mode
(use-package js2-mode
  :ensure t)

;; json-mode
(use-package json-mode
  :ensure t)

;; hl-todo
(use-package hl-todo
  :ensure t)

(use-package flymake-collection
  :ensure t)
  ;;:hook (python-mode . flymake-collection-flake8-setup))

;; Set relative line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
;; Display line numbers when in prog mode all the time.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Fucntions for determining the python version
(defun my/python-version-from-shebang ()
  "Return 2 or 3 based on shebang, or nil if absent."
  (save-excursion
    (goto-char (point-min))
    (when (looking-at "#!.*python\\([23]\\)")
      (string-to-number (match-string 1)))))

;; Create a file called .dir-locals.el and place this in it ((python-mode . ((my/python-version . 2))))
(put 'my/python-version 'safe-local-variable #'integerp)

(defun my/python-major-version ()
  "Detect Python version for current buffer."
  (or (my/python-version-from-shebang)
      (and (boundp 'my/python-version) my/python-version)
      3))  ; default to 3

;; start eglot automatically for python 3 projects
(defun my/python-eglot-setup ()
  "Start eglot for Python 3, use flake8 for Python 2."
  (when (derived-mode-p 'python-mode 'python-ts-mode)
    (if (= (my/python-major-version) 2)
        (progn
          (setq-local python-flymake-command '("flake8" "-"))
          (flymake-mode 1))
      (eglot-ensure))))

(setq flymake-no-changes-timeout 2.0)

(add-hook 'hack-local-variables-hook #'my/python-eglot-setup)

(use-package flymake-ruff
  :ensure t
  :hook (eglot-managed-mode . flymake-ruff-load))

;; Install sideline eglot backend
(use-package sideline-eglot
  :ensure t
  :config
  (setq sideline-backends-right '(sideline-flymake sideline-eglot)))

;; Install sideline flymake backend
(use-package sideline-flymake
  :ensure t)

;; Install sideline and enable the different backends
(use-package sideline
  :ensure t
  :hook ((flymake-mode . sideline-mode)
         (eglot-managed-mode . sideline-mode))
  :config
  (setq sideline-backends-right '(sideline-flymake sideline-eglot)))

;; Eglot setup
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(python-mode . ("basedpyright-langserver" "--stdio"))))

;; Enable transient mark mode
(transient-mark-mode 1)

;; Desktop.el for saving window states
(use-package desktop
  :config
  (setq desktop-save t                     ; Always save without asking
        desktop-load-locked-desktop 'check-pid  ; Handle stale locks from crashes
        desktop-restore-eager 5            ; Restore 5 buffers immediately, rest lazily
        desktop-restore-frames t)          ; Restore window/frame configuration
  (desktop-save-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(conda djangonaut evil-collection evil-commentary evil-indent-plus
	   evil-matchit evil-nerd-commenter evil-surround
	   exec-path-from-shell flymake-collection flymake-flake8
	   flymake-ruff general hl-todo js2-mode json-mode magit
	   projectile sideline-eglot sideline-flymake undo-tree vterm
	   yaml zenburn-theme)))

