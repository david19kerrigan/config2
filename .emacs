(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil catppuccin-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq make-backup-files nil) 

(desktop-save-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-set-style "k&r")
(setq c-basic-offset 4)

(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'mocha) 
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(set-face-attribute 'default nil :font "JetBrains Mono-14")
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(ido-mode 1)

(global-set-key (kbd "C-<tab>") (lambda () (interactive) (switch-to-buffer (other-buffer (current-buffer) 1))))
(global-set-key (kbd "C-c l") 'compile)

(setq shell-command-switch "-ic")
