(setq make-backup-files nil)
(setq auto-save-default nil)

(show-paren-mode 1)


(delete-selection-mode 1)

(global-auto-revert-mode 1)

(abbrev-mode 1)
(define-abbrev-table 'global-abbrev-table '(
					    ;; signature
					    ("8sd" "sdwfzly")
					    ))

;; Org-mode内语法高亮
(require 'org)
(setq org-src-fontify-natively t)

;; 打开最近文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)



(provide 'sdwfzly-defaults)
