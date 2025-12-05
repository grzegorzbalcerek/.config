(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(buffers-menu-max-size 30)
 '(calendar-date-style 'european)
 '(calendar-week-start-day 1)
 '(current-language-environment "English")
 '(fill-column 90)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(mouse-drag-copy-region t)
 '(org-time-stamp-rounding-minutes '(0 1))
 '(outline-minor-mode-prefix [3])
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")))
 '(safe-local-variable-values '((lexical-biding . t)))
 '(speedbar-show-unknown-files t)
 '(truncate-lines t)
 '(word-wrap t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; '(package-selected-packages
;   '(tree-sitter-langs typescript-mode tree-sitter company multiple-cursors lsp-mode rust-mode))
; '(typescript-mode-hook '(display-line-numbers-mode lsp))

(add-to-list 'default-frame-alist
                       '(font . "Liberation Mono-10"))

(setq default-directory "~/")
(setq w32-lwindow-modifier 'super)
(if (functionp 'w32-register-hot-key)
    (w32-register-hot-key [s-]))
(prefer-coding-system 'utf-8-unix)
(column-number-mode +1)
(put 'narrow-to-region 'disabled nil)
(set-scroll-bar-mode 'right)
(global-tab-line-mode)

(global-set-key [f1] 'save-buffer)
(global-set-key (kbd "C-c r") 'toggle-truncate-lines)

(global-set-key (kbd "<M-left>") 'windmove-left)
(global-set-key (kbd "<M-down>") 'windmove-down)
(global-set-key (kbd "<M-up>") 'windmove-up)
(global-set-key (kbd "<M-right>") 'windmove-right)

(global-set-key (kbd "<S-left>") (lambda(n)(interactive "p")(scroll-right n)))
(global-set-key (kbd "<S-down>") (lambda(n)(interactive "p")(scroll-up n)))
(global-set-key (kbd "<S-up>") (lambda(n)(interactive "p")(scroll-down n)))
(global-set-key (kbd "<S-right>") (lambda(n)(interactive "p")(scroll-left n)))

(global-set-key (kbd "<C-M-left>") 'previous-buffer)
(global-set-key (kbd "<C-M-down>") 'buffer-menu)
(global-set-key (kbd "<C-M-up>") (lambda()(interactive)(dired ".")))
(global-set-key (kbd "<C-M-right>") 'next-buffer)

(global-set-key (kbd "<C-S-M-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-S-M-down>") 'shrink-window)
(global-set-key (kbd "<C-S-M-up>") 'enlarge-window)
(global-set-key (kbd "<C-S-M-right>") 'enlarge-window-horizontally)

(set-register ?. '(file . "~/.emacs"))

(add-to-list 'load-path "~/.config/emacs")
(require 'time)

(set-buffer "*scratch*")
(insert "\n")
