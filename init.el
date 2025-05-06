(push '(fullscreen . maximized) default-frame-alist)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Meow configuration
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))
(require 'meow)
(meow-setup)
(meow-global-mode 1)

;; Install lsp and various modes
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap
  (setq lsp-keymap-prefix "C-c l"
	lsp-ui-doc-show-with-mouse t
        lsp-ui-doc-position 'at-point
        lsp-pylsp-plugins-ruff-enabled t
        lsp-pylsp-plugins-mypy-enabled t
        lsp-pylsp-plugins-rope-autoimport-enabled t)
  :hook ((python-mode . lsp)
	 (js2-mode . lsp)
	 (js-mode . lsp)
	 (php-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-log-io nil) ; if set to true can cause a performance hit


  ;; lsp extras
(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))
(use-package lsp-treemacs
  :ensure t)
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
(use-package lsp-docker
  :ensure t)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
(use-package flycheck
  :ensure t)
(use-package dap-mode
  :ensure t)
;;(use-package pyenv-mode
;;  :ensure t)
(use-package exec-path-from-shell
  :ensure t)
;;(setq lsp-pylsp-server-command "/Users/thillis/miniconda3/bin/pylsp")

(use-package company
  :ensure t)
(add-hook 'after-init-hook 'global-company-mode)
(use-package company-web
  :ensure t)

(use-package conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "~/miniconda3"))
  (setq conda-env-home-directory (expand-file-name "~/miniconda3")))
;;(conda-env-autoactivate-mode)

;; Install flycheck for various languages
;; (use-package flycheck-python)

;; Installation of elpy
;; (use-package elpy
;;   :ensure t
;;   :init
;;   (elpy-enable))

;; ;; Configure elpy more
;; (when (load "flycheck" t t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/sandbox" "~/projects/" "~/work/" "~/playground"))
  :config
  ;; On Linux, however, I usually go with another one
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (global-set-key (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

;; This appears to not work so use list-packages-list to install instead and then restart
;; A nice theme
;;(use-package zenburn-theme
;;  :config
(load-theme 'zenburn t)

;; Install ag
(use-package ag
  :ensure t)

;; helm-ag
(use-package helm-ag
  :ensure t)

;; magit
(use-package magit
  :ensure t)

;; treemacs
(use-package treemacs
  :ensure t)

;; treemacs-all-the-icons
(use-package treemacs-all-the-icons
  :ensure t)

;; treemacs-magit
(use-package treemacs-magit
  :ensure t)

;; treemacs-projectile
(use-package treemacs-projectile
  :ensure t)

;; yaml
(use-package yaml
  :ensure t)

;; which-key
(use-package which-key
  :ensure t)

(which-key-mode)

;; web-mode
(use-package web-mode
  :ensure t)

;; js2-mode
(use-package js2-mode
  :ensure t)

;; json-mode
(use-package json-mode
  :ensure t)

;; djangonaut
(use-package djangonaut
  :ensure t)

;; shell-pop
(use-package shell-pop
  :ensure t)

;; hl-todo
(use-package hl-todo
  :ensure t)

;; Display line numbers when in prog mode all the time.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Assign ace-window command for quick switching
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; Assign treemacs button
(global-set-key (kbd "M-0") 'treemacs-select-window)

;; TODO: Configure this to not work in fundamental mode.
(electric-pair-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/org/1.org"))
 '(package-selected-packages
   '(ag company-jedi company-web conda dap-mode djangonaut elpy
	exec-path-from-shell flycheck helm-ag hl-todo js2-mode
	json-mode lsp-jedi lsp-ui multi- pyenv-mode shell-pop
	treemacs-all-the-icons treemacs-magit treemacs-projectile
	web-mode zenburn-theme))
 '(python-indent-guess-indent-offset nil)
 '(python-shell-interpreter "/Users/thillis/miniconda3/bin/python3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Org mode settings
;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; Set org todo keywords for cycling through.
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
