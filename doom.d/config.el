;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Egor Lukin"
      user-mail-address "lukin.net@gmail.com")

(setq doom-theme 'doom-gruvbox-light)

(setq doom-font (font-spec :family "monospace" :size 36 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 36))

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

(use-package google-translate
  ;; :ensure t
  :custom
  (google-translate-backend-method 'curl)
  :config
   (defun google-translate--search-tkk () "Search TKK." (list 430675 2721866130)))

(setq browse-url-browser-function 'eww-browse-url)
(setq eww-download-directory "~/cached-web-pages")

(after! elfeed
  (setq elfeed-feeds
        '(("https://hnrss.org/best" hn tech)
          "https://www.lesswrong.com/feed.xml?view=curated-rss"
          "https://slatestarcodex.com/feed/"
          "https://lifehacker.com/rss"
          "https://hackaday.com/blog/feed/"
          "https://feeds.arstechnica.com/arstechnica/index"
          "https://mindingourway.com/rss/"
          ("https://www.reddit.com/r/Biohackers/.rss" redit)
          ("https://www.reddit.com/r/QuantifiedSelf/.rss" redit)
          ("https://www.reddit.com/r/kubernetes/.rss" redit)
          ("https://www.reddit.com/r/GUIX/.rss" redit)
          ("https://www.reddit.com/r/emacs/.rss" redit)
          ("https://www.reddit.com/r/orgmode/.rss" redit)
          ("https://www.reddit.com/r/selfhosted/.rss" redit)
          "https://reminder.media/rss"
          "https://lesswrong.ru/rss.xml"
          ("https://tg.i-c-a.su/rss/tbilisi_pike" tg)
          ("https://tg.i-c-a.su/rss/emigriceps" tg)
          ("https://tg.i-c-a.su/rss/rebrain_devops" tg)
          ("https://tg.i-c-a.su/rss/addmeto" tg)
          ("https://tg.i-c-a.su/rss/nestarenieRU" tg)
          ("https://tg.i-c-a.su/rss/pmdaily" tg)
          ("https://tg.i-c-a.su/rss/ctodaily" tg)
          ("https://tg.i-c-a.su/rss/Faguet" tg)
          ("https://tg.i-c-a.su/rss/yurydud" tg)
          ("https://tg.i-c-a.su/rss/zareshai_channel" tg)
          ("https://tg.i-c-a.su/rss/zamesin" tg)
          ("https://tg.i-c-a.su/rss/ontologics" tg)
          ("https://tg.i-c-a.su/rss/pepegramming" tg)
          ("https://tg.i-c-a.su/rss/evtuhovich_sect" tg)
          ("https://tg.i-c-a.su/rss/tasteofrain" tg)
          ("https://tg.i-c-a.su/rss/samurai_haiku" tg)
          ("https://tg.i-c-a.su/rss/news_clj" tg)
          ("https://tg.i-c-a.su/rss/Matskevich" tg)
          ("https://tg.i-c-a.su/rss/OpenLongevity_ru" tg)
          ("https://tg.i-c-a.su/rss/nadyathinks" tg)
          ("https://tg.i-c-a.su/rss/meta_texts" tg)
          ("https://tg.i-c-a.su/rss/RationalAnswer" tg)
          ("https://tg.i-c-a.su/rss/lesswrong_ru_news" tg)
          ("https://tg.i-c-a.su/rss/Shmit16" tg)
          ("https://tg.i-c-a.su/rss/nikitonsky_pub" tg)
          ("https://tg.i-c-a.su/rss/varlamov_news" tg)
          ("https://tg.i-c-a.su/rss/mnogosdelal" tg)
          ("https://tg.i-c-a.su/rss/ea_kocherga" tg)
          )))

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

;; %Y-%m-%d.org
(after! org
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "roam/gtd/gtd.org" "Inbox")
           (file "templates/todo.org"))
          ("e" "English word" entry
           (file+headline "anki/english_words.org" "Backlog")
           (file "templates/english_words.org"))
          ("b" "Add bookmark" entry
           (file+headline "roam/notes/bookmarks.org" "Inbox")
           (file "templates/bookmarks.org"))
          ("c" "Todo from x clipboard" entry
           (file+headline "roam/gtd/gtd.org" "Inbox")
           (file "templates/external.org")))))

(setq deft-directory "~/org")
(setq deft-extensions '("txt" "tex" "org"))
(setq deft-recursive t)

(map! :leader
      (:prefix-map ("b" . "babel")
       :desc "org-babel-execute-src-block" "b" #'org-babel-execute-buffer))

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
  (if (org-clocking-p)
      (let ((header org-clock-heading)
            (time
             (floor
              (org-time-convert-to-integer (time-since org-clock-start-time))
              60)))
        (polybar--format-line header time))
    polybar--default-header))

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

(setq docker-tramp-use-names t)

(setq org-use-fast-todo-selection t)

(setq telega-use-docker t)

(winner-mode +1)

(setq org-attach-directory "~/photos/attachments")
