(push '(fullscreen . maximized) default-frame-alist)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

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

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))

(use-package conda
  :ensure t
  :init
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

;; djangonaut
(use-package djangonaut
  :ensure t)

;; hl-todo
(use-package hl-todo
  :ensure t)

;; Display line numbers when in prog mode all the time.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Enable transient mark mode
(transient-mark-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
