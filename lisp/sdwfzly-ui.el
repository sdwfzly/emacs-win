(global-linum-mode 1)
(setq linum-format "%d ")

(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq-default cursor-type 'bar)
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

(global-hl-line-mode 1)

(load-theme 'monokai 1)

(provide 'sdwfzly-ui)
