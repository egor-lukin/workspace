(defun my/move-check-in-to-daily-note ()
  "Move 'check-in' items from 'Inbox' to daily note based on 'CREATED_AT' property."
  (interactive)
  (org-map-entries
   (lambda ()
     (when (and (string= (org-get-heading t t t t) "check-in")
                (org-entry-get (point) "CREATED"))
       (let* ((created-at (org-entry-get (point) "CREATED"))
              (daily-note-file (my/daily-note-filename created-at)))
         (let ((subtree (org-copy-subtree)))
           (my/insert-check-in-to-daily-note daily-note-file subtree)))))
   "Inbox" 'file))

(defun my/daily-note-filename (date)
  "Generate the filename for the daily note based on DATE."
  (concat "~/org/roam/daily/" (format-time-string "%Y-%m-%d" (org-time-string-to-time date)) ".org.gpg"))

;; (my/daily-note-filename "2024-05-10")

(defun my/insert-check-in-to-daily-note (daily-note-file subtree)
  "Insert the 'check-in' SUBTREE into the specified DAILY-NOTE-FILE under 'test header'."
  (with-current-buffer (find-file-noselect daily-note-file)
    ;; (goto-char (point-min))
    (re-search-forward "^\\* buffer" nil t)
    (insert (concat "\n" subtree "\n"))
    (save-buffer)))

;; (my/insert-check-in-to-daily-note (my/daily-note-filename "2025-01-13") "** test")
