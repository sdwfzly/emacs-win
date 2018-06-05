
(when (>= emacs-major-version 24)
     (require 'package)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
(require 'cl)
(defvar sdwfzly/packages '(
                ;; --- Auto-completion ---
                company
                ;; --- Better Editor ---
                smooth-scrolling
                hungry-delete
                swiper
                counsel
                smartparens
                popwin
                expand-region
                ;; --- Major Mode ---
                markdown-mode
                ;; --- Minor Mode ---
                exec-path-from-shell
                ;; --- Themes ---
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

(setq make-backup-files nil)

(setq auto-save-default nil)

(delete-selection-mode 1)

(global-auto-revert-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(show-paren-mode 1)

(set-language-environment "UTF-8")

;; Org-mode Highlight
(require 'org)
(setq org-src-fontify-natively t)

;; Recent Files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(put 'dired-find-alternate-file 'disabled nil)

(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))

(abbrev-mode 1)
(define-abbrev-table 'global-abbrev-table '(
                                            ;; signature
                                            ("8sd" "sdwfzly")
                                            ))

(defun open-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(defun open-orgconf-file ()
  (interactive)
  (find-file "~/.emacs.d/sdwfzly.org"))

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

(global-set-key (kbd "<f2>") 'open-init-file)
(global-set-key (kbd "<f3>") 'open-orgconf-file)

(global-set-key (kbd "C-c r") 'recentf-open-files)
(global-set-key (kbd "C-c a") 'org-agenda)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-c p f") 'counsel-git)

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(global-set-key (kbd "M-/") 'hippie-expand)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(global-set-key (kbd "M-s o") 'occur-dwim)

(global-set-key (kbd "M-s i") 'counsel-imenu)

(global-set-key (kbd "C-=") 'er/expand-region)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(global-linum-mode 1)
(setq linum-format "%d ")

(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq-default cursor-type 'bar)
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; Shutdown help at startup
(setq inhibit-splash-screen 1)

(global-hl-line-mode 1)

(load-theme 'monokai 1)

(require 'org)
(setq org-src-fontify-natively 1)
(setq org-agenda-files '("~/Documents/Org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 1)
 '(popwin:popup-window-position (quote right))
 '(popwin:popup-window-width 80)
)
