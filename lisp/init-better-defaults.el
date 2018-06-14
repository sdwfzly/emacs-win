;;---------------
;; Basic Defaults
;;---------------
(setq make-backup-files nil)

(setq auto-save-default nil)

(delete-selection-mode 1)

(global-auto-revert-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(show-paren-mode 1)

(set-language-environment "UTF-8")

;; (set-default-font "Source Code Variable:pixelsize=15:foundry=ADBO:weight=normal:slant=italic:width=normal:spacing=100:scalable=true")
(set-default-font "Source Code Variable:slant=Italic")

;; Org-mode Highlight
(require 'org)
(setq org-src-fontify-natively t)

;; Recent Files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;;---------------
;; Modes Defaults
;;---------------

;; Dired Mode
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(put 'dired-find-alternate-file 'disabled nil)

;; Show Paren Everywhere
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))

;; Abbrevs
(setq default-abbrev-mode 1)
(define-abbrev-table 'global-abbrev-table '(
					    ;; signature
					    ("8sd" "sdwfzly")
					    ))

;;----------
;; Functions
;;----------

;; Open init & orgconf file (F2)
(defun open-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; Auto Indent Region or Buffer (C-M-\)
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))
(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indented Selected Region."))
      (progn
	(indent-buffer)
	(message "Indented Buffer.")))))

;; occur mode (M-s o)
(defun occur-dwim ()
  "Call 'occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))

;; Hippie expand (M-/)
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
					 try-expand-dabbrev-all-buffers
					 try-expand-dabbrev-from-kill
					 try-complete-file-name-partially
					 try-complete-file-name
					 try-expand-all-abbrevs
					 try-expand-list
					 try-expand-line
					 try-complete-lisp-symbol
					 try-complete-lisp-symbol-partially))

;; Dos end of line
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX & DOS line endings"
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with UNIX eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))


(provide 'init-better-defaults)
