;;-------------------------
;; Check & Install Packages
;;-------------------------
(when (>= emacs-major-version 24)
     (require 'package)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
(require 'cl)
(defvar sdwfzly/packages '(
		company
		smooth-scrolling
		hungry-delete
		swiper
		counsel
		smartparens
		popwin
		expand-region
		iedit

		;; --- Mode ---
		markdown-mode
		exec-path-from-shell
		;; --- Theme ---
		monokai-theme
		;; solarized-theme
		) "Default packages")

(setq package-selected-packages sdwfzly/packages) ;; Don't autoremove unused packages
(defun sdwfzly/packages-installed-p ()
     (loop for pkg in sdwfzly/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))
(unless (sdwfzly/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg sdwfzly/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

;; Find Executable Path on OS X
(when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

;;------------------
;; Packages Settings
;;------------------
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(require 'hungry-delete)
(global-hungry-delete-mode 1)

(smartparens-global-mode 1)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

(global-company-mode 1)

(require 'popwin)
(popwin-mode 1)

(provide 'init-packages)
