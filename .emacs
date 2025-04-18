(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil-collection flx-ido evil catppuccin-theme)))
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
(setq evil-want-keybinding nil)

(require 'evil)
(evil-mode 1)
(ido-mode 1)

(when (require 'evil-collection nil t)
  (evil-collection-init))


(global-set-key (kbd "C-<tab>") (lambda () (interactive) (switch-to-buffer (other-buffer (current-buffer) 1))))
(global-set-key (kbd "C-c l") 'compile)

(setq shell-command-switch "-ic")

(setq use-short-answers t)
(setq scroll-step 1
    scroll-conservatively 10000)
(put 'dired-find-alternate-file 'disabled nil)

(global-set-key (kbd "<escape>")      'keyboard-escape-quit)

(keyboard-translate ?\C-a ?\C-x)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(global-set-key (kbd "C-l") 'next-buffer)
(global-set-key (kbd "C-h") 'previous-buffer)
(global-set-key (kbd "C-x t") 'shell)
(global-set-key (kbd "C-x i") 'ibuffer)

(setq ibuffer-saved-filter-groups
 '(("MyList"
    ("Cpp"     (filename      . ".cpp"))
    ("Shell"   (name          . "*shell\\*"))
    ("Dired"   (mode          . dired-mode))
    ("Org"     (filename      . ".org")))))
(add-hook 'ibuffer-mode-hook
 (lambda ()
  (ibuffer-switch-to-saved-filter-groups "MyList")))

