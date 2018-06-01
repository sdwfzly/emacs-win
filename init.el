(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Package Management
;; ------------------
(require 'sdwfzly-packages)

;; Better-Defaults
;; ---------------
(require 'sdwfzly-defaults)
  
;; Keybindings
;; -----------
(require 'sdwfzly-keybindings)

;; UI-Configs
;; ----------
(require 'sdwfzly-ui)

;; Customize-group settings
;; ------------------------
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
(load-file custom-file)
