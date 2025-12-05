;;; -*- lexical-biding: t -*-

(provide 'zk)

(defun zk-orgify()
  (interactive)
  (org-mode)
  (beginning-of-buffer)
  (while (re-search-forward "--[|]--" nil t) (replace-match "--+--"))
  (save-buffer))

(global-set-key (kbd "M-o") 'zk-orgify)

(defun zk-mdify()
  (interactive)
  (fundamental-mode)
  (beginning-of-buffer)
  (while (re-search-forward "--[+]--" nil t) (replace-match "--|--"))
  (save-buffer))
(global-set-key (kbd "M-p") 'zk-mdify)
