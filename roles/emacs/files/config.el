;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Egor Lukin"
      user-mail-address "lukin.net@gmail.com")

(setq multi-term-program-switches "--login")

;; (setq doom-theme 'doom-gruvbox-light)
;; (setq doom-theme 'doom-palenight)
;; (setq doom-theme 'doom-moonlight)
(setq doom-theme 'doom-dracula)

(setq doom-font (font-spec :family "monospace" :size 42 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 42))

(setq display-line-numbers-type t)

(after! org
  (setq org-directory "~/org/"))

(after! org
  (setq org-todo-keywords
        '((sequence "TODO" "IN-PROGRESS" "WAIT" "SKIP" "DELEGATED" "SCHEDULED" "|" "DONE" "CLOSED" "MOVED")))
  (setq org-agenda-files '("roam/gtd/gtd.org" "roam/gtd/backlog.org" "roam/gtd/routines.org" "roam/gtd/birthday.org" "roam/gtd/scheduled.org")))

(setq org-refile-targets
      '(("~/org/roam/gtd/gtd.org" :maxlevel . 2)
        ("~/org/roam/gtd/routines.org" :maxlevel . 2)
        ("~/org/roam/gtd/scheduled.org" :maxlevel . 2)
        ("~/org/roam/gtd/backlog.org" :maxlevel . 2)))

(setq org-download-dir "~/Pictures/Screenshots")

(after! org
  (setq org-log-done t)
  (setq org-log-into-drawer t))

(after! org
  (setq org-archive-location "~/org/roam/gtd/archived/09-2022.org::"))

(require 'org-habit)
(setq org-habit-show-habits-only-for-today t)
(setq org-habit-preceding-days 25)
(setq org-habit-following-days 3)

(setq projectile-project-search-path '("~/Projects/"))

(setq helm-mode-fuzzy-match t)

(setq ivy-re-builders-alist
      '((counsel-ag . regexp-quote)
        (t      . ivy--regex-fuzzy)))

(setq ein:output-area-inlined-images t)

;; Google Translate Integration
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cr" 'google-translate-at-point-reverse)
(global-set-key "\C-cT" 'google-translate-query-translate)

(setq google-translate-default-source-language '"en")
(setq google-translate-default-target-language '"ru")

(setq google-translate-backend-method 'curl)

(use-package google-translate
  ;; :ensure t
  :custom
  (google-translate-backend-method 'curl)
  :config
   (defun google-translate--search-tkk () "Search TKK." (list 430675 2721866130)))

(setq browse-url-browser-function 'eww-browse-url)
(setq eww-download-directory "~/cached-web-pages")

(after! elfeed
  (setq elfeed-search-filter "@1-month-ago +unread"))

(defun my/org-roam-node-find-by-directory ()
  (interactive)
  (let* ((directories '("tasks" "literate" "conceptual" "projects" "planning"))
        (directory (completing-read "Enter directory: " directories)))
    (org-roam-node-find t nil
                        (lambda (node)
                          (let ((tags (org-roam-node-tags node)))
                            (member directory tags))))))

(after! org-roam
  (setq org-roam-directory "~/org/roam")
  (setq org-roam-db-location  "~/org/roam/org-roam.db")

  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%A, %d %B %Y>\n"))))

  (setq org-roam-capture-templates
        '(("t" "Task note" plain
           "%?"
           :if-new (file+head "tasks/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :tasks\n")
           :unnarrowed t)
          ("l" "Literate note" plain
           "%?"
           :if-new (file+head "literate/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :literate\n")
           :unnarrowed t)
          ("c" "Conceptual note" plain "%?"
           :if-new (file+head "conceptual/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :conceptual\n")
           :unnarrowed t)
          ("r" "Planning note" plain "%?"
           :if-new (file+head "planning/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :planning\n")
           :unnarrowed t)
          ("p" "Project note" plain
           "%?"
           :if-new (file+head "project/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :projects\n")
           :unnarrowed t)))

  (map! :leader
        :prefix "r"
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-node-find-by-directory" "t" #'my/org-roam-node-find-by-directory
        :desc "org-roam-dailies-goto-date" "s" #'org-roam-dailies-goto-date
        :desc "org-roam-dailies-goto-today" "d" #'org-roam-dailies-goto-today
        :desc "org-roam-buffer" "l" #'org-roam-buffer
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
        :desc "org-roam-dailies-find-next-note" "n" #'org-roam-dailies-find-next-note
        :desc "org-roam-dailies-find-previous-note" "p" #'org-roam-dailies-find-previous-note
        :desc "org-roam-capture" "c" #'org-roam-capture))

(defun my/daily-note-filename ()
  (let ((date (format-time-string "%Y-%m-%d" (current-time))))
    (concat
     "~/org/roam/daily/"
     date
     ".org")))


;; %Y-%m-%d.org
(after! org
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "roam/gtd/gtd.org" "Inbox")
           (file "templates/todo.org"))
          ("e" "English word" entry
           (file+headline "anki/english_words.org" "Backlog")
           (file "templates/english_words.org"))
          ("m" "Write message" entry
           (file+headline (lambda () (my/daily-note-filename)) "messages")
           (file "templates/message.org"))
          ("b" "Add entry to daily buffer" entry
           (file+headline (lambda () (my/daily-note-filename)) "buffer")
           (file "templates/buffer.org")))))

(setq deft-directory "~/org")
(setq deft-extensions '("txt" "tex" "org"))
(setq deft-recursive t)

(map! :leader
      (:prefix-map ("b" . "babel")
       :desc "org-babel-execute-src-block" "b" #'org-babel-execute-buffer))

(setq org-babel-pry-command "pry")

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-persist t)

(require 'openwith)
(openwith-mode t)
(setq openwith-associations
            (list
             (list (openwith-make-extension-regexp
                    '("mpg" "mpeg" "mp3" "mp4"
                      "avi" "wmv" "wav" "mov" "flv"
                      "ogm" "ogg" "mkv"))
                   "vlc"
                   '(file))
             (list (openwith-make-extension-regexp
                    '("xbm" "pbm" "pgm" "ppm" "pnm"
                      "png" "gif" "bmp" "tif" "jpeg" "jpg"))
                   "eog"
                   '(file))
             '("\\.pdf" "evince" (file))
             '("\\.djvu" "evince" (file))
             ))

(defvar polybar--default-header "no active clocks!")

(defun polybar--format-line (task time)
  (concat task " ("(number-to-string time) " min)"))

(defun polybar-current-clock-line ()
  (interactive)
  (message
   (if (org-clocking-p)
       (let ((header org-clock-heading)
             (time
              (floor
               (org-time-convert-to-integer (time-since org-clock-start-time))
               60)))
         (polybar--format-line header time))
     polybar--default-header)))

(map! :leader :prefix "b" :desc "polybar-current-clock-line" "c" #'polybar-current-clock-line)

(setq hledger-jfile "~/org/finances/ledger.journal")

;; Develop in ~/emacs.d/mysnippets, but also
;; try out snippets in ~/Downloads/interesting-snippets
(setq yas-snippet-dirs '("~/org/snippets"
                         "~/emacs.d/mysnippets"))

(use-package! reverso)
(after! reverso
  (setq reverso-default-source-lang "english")
  (setq reverso-default-target-lang "russian")

  (map! :leader
        :prefix "k"
        :desc "reverso-direct-search" "d" #'reverso-direct-search
        :desc "reverso-reverse-search" "r" #'reverso-reverse-search))

 (defun eshell-load-bash-aliases ()
    "Read Bash aliases and add them to the list of eshell aliases."
    ;; Bash needs to be run - temporarily - interactively
    ;; in order to get the list of aliases.
      (with-temp-buffer
        (call-process "bash" nil '(t nil) nil "-ci" "alias")
        (goto-char (point-min))
        (while (re-search-forward "alias \\(.+\\)='\\(.+\\)'$" nil t)
          (eshell/alias (match-string 1) (match-string 2)))))

(xclip-mode 1)

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if filename
        (if (y-or-n-p (concat "Do you really want to delete file " filename " ?"))
            (progn
              (delete-file filename)
              (message "Deleted file %s." filename)
              (kill-buffer)))
      (message "Not a file visiting buffer!"))))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun org--photos-list ()
  (let* ((date (string-replace "-" "" (org-read-date)))
         (photos-path "~/photos/mobile/DCIM/Camera/")
         (command (concat "ls " photos-path " | grep " date))
         (photo-paths (split-string (shell-command-to-string command) "\n")))
    (seq-reduce
     (lambda (acc time)
       (if (not (string-blank-p time))
           (concat acc "\n"
                   "#+attr_html: :width 750px\n"
                   "[[file:" photos-path time "][" time "]" "]") acc))
     photo-paths "")))

(defun org-insert-photos ()
  (interactive)
  (insert (org--photos-list)))

;; (hms-to-pomodoros "1:22")
(defun hms-to-pomodoros (str)
  (/ (hms-to-minutes str) 25))

;; (hms-to-minutes "1:12")
(defun hms-to-minutes (str)
  (let* ((lst (split-string str ":"))
         (hour (nth 0 lst))
         (minute (nth 1 lst)))
    (+ (* (string-to-number hour) 60)
       (string-to-number minute))))

(setq docker-tramp-use-names t)

(setq org-use-fast-todo-selection t)

(setq telega-use-docker t)

(winner-mode +1)

(setq org-attach-directory "~/photos/attachments")
