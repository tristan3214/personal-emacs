(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
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

;; Installation of elpy
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

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

;; A nice theme
(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))

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

(add-hook 'prog-mode-hook 'display-line-numbers-mode)



