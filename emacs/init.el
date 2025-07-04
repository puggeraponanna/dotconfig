(setq disabled-command-function nil)
(setq custom-file "~/.config/emacs/emacs-custom.el")
(load custom-file 'noerror)

(tool-bar-mode -1)             ; Hide the outdated icons
(scroll-bar-mode -1)           ; Hide the always-visible scrollbar
(setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
(setq use-file-dialog nil)      ; Ask for textual confirmation instead of GUI
(blink-cursor-mode 0)
(setq-default cursor-type 'hbar)
(global-display-line-numbers-mode 1)
(setq-default tab-width 4)

;; Choose some fonts
(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font")
(set-face-attribute 'variable-pitch nil :family "EB Garamond")

; Setup Melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Set Theme
(use-package spacemacs-theme)
(load-theme 'spacemacs-light)

;;Org mode configuration
;; Enable Org mode
(require 'org)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-hide-emphasis-markers t)

;;Completions setup
(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

;;go mode
(use-package go-mode)

;;LSP and DAP Setup
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (
	 (go-mode . lsp))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package dap-mode)
(require 'dap-dlv-go)

;;which key
(use-package which-key
  :config
  (which-key-mode))

;;projectile
(use-package projectile
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

;;magit
(use-package magit
  :bind
  (("C-c g" . magit-status)))
