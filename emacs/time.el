;;; -*- lexical-biding: t -*-

(provide 'time)

(defun time-initialize()
  (interactive)
  (find-file "~/time.org")
  (erase-buffer)
  (insert "** break\n** work\n"))

(defun time-clock-in(str)
  (interactive)
  (find-file "~/time.org")
  (goto-char 1)
  (search-forward str)
  (org-clock-in))
(global-set-key (kbd "<f7>") (lambda()(interactive)(time-clock-in "** break")))
(global-set-key (kbd "<f8>") (lambda()(interactive)(time-clock-in "** work")))

   
