;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Egor Lukin"
      user-mail-address "lukin.net@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 20))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Projects/notes/")

(setq org-super-agenda-groups
      '((:name "Log\n"
               :log t)  ; Automatically named "Log"
        (:name "Schedule\n"
               :time-grid t)
        (:name "Today\n"
               :scheduled today)
        (:name "Due today\n"
               :deadline today)
        (:name "Overdue\n"
               :deadline past)
        (:name "Due soon\n"
               :deadline future)
        (:name "Waiting\n"
               :todo "WAIT"
               :order 98)
        (:name "Scheduled earlier\n"
               :scheduled past)))

(setq org-agenda-files (quote ("~/Projects/gtd")))
;; (setq org-journal-enable-agenda-integration t)

(setq org-download-dir "~/Projects/notes/img")
(setq-default org-download-image-dir "~/Projects/notes/img")
;; (setq org-download-screenshot-method "gnome-screenshot")
(add-hook 'dired-mode-hook 'org-download-enable)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; fuzzy search by default
(setq helm-mode-fuzzy-match t)

(setq ivy-re-builders-alist
      '((counsel-ag . regexp-quote)
        (t      . ivy--regex-fuzzy)))

(setq projectile-project-search-path '("~/Projects/"))


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


;; Autocompletion for eshell
(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))

(setq eshell-cmpl-cycle-completions nil)

;; (map! :leader
;;       :desc "ag" "s a" #'counsel-ag)

;; (map! :leader
;;       :desc "fzf" "s f" #'counsel-fzf)

(setq doom-theme 'doom-gruvbox-light)

(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))


(setq doom-font (font-spec :family "monospace" :size 24 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 24))

(after! eshell
  (set-eshell-alias!
   "dc" "docker-compose \$*"
   "dcrs" "docker-compose run --service-ports \$*"
   "gl"  "(call-interactively 'magit-log-current)"
   "gs"  "magit-status"
   "g"   "git"
   "gc"  "magit-commit"))

(setq ein:output-area-inlined-images t)

;; Google Translate Integration
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cr" 'google-translate-at-point-reverse)
(global-set-key "\C-cT" 'google-translate-query-translate)

(setq google-translate-default-source-language '"en")
(setq google-translate-default-target-language '"ru")

;; Search failed problem fix
;; https://github.com/atykhonov/google-translate/issues/52
(use-package google-translate
  :ensure t
  :custom
  (google-translate-backend-method 'curl)
  :config
   (defun google-translate--search-tkk () "Search TKK." (list 430675 2721866130)))

(setq browse-url-browser-function 'eww-browse-url)

(setq org-roam-directory "~/Projects/notes")
(setq org-roam-db-location  "~/Projects/notes/org-roam.db")

(after! org-roam
  (map! :leader
        :prefix "r"
        :desc "org-roam" "l" #'org-roam
        :desc "org-roam-insert" "i" #'org-roam-insert
        :desc "org-roam-switch-to-buffer" "b" #'org-roam-switch-to-buffer
        :desc "org-roam-find-file" "f" #'org-roam-find-file
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
        :desc "org-roam-insert" "i" #'org-roam-insert
        :desc "org-roam-capture" "c" #'org-roam-capture))

(setq magit-margin-settings "preffix")

(setq org-capture-templates
      '(("d" "default" plain (function org-roam--capture-get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#++roam_tags:"
         :unnarrowed t)))

;; (use-package treemacs-icons-dired
;;   :after treemacs dired
;;   :ensure t
;;   :config (treemacs-icons-dired-mode))

;; (add-to-list 'projectile-globally-ignored-directories "*node_modules")

;; (add-to-list 'load-path (expand-file-name "~/Projects/aweshell"))
;; (require 'aweshell)

(setq dionysos-backend 'vlc)

;; mu4e
(setq +mu4e-backend 'offlineimap)
(set-email-account! "LukinEgor"
  '((mu4e-sent-folder       . "//Sent Mail")
    (mu4e-drafts-folder     . "/Lissner.net/Drafts")
    (mu4e-trash-folder      . "/Lissner.net/Trash")
    (mu4e-refile-folder     . "/Lissner.net/All Mail")
    (smtpmail-smtp-user     . "lukin.net@gmail.com")
    (mu4e-compose-signature . "---\nEgor Lukin"))
  t)

(add-to-list 'company-backends #'company-tabnine)

(add-hook 'dired-mode-hook 'org-download-enable)

(setq doom-themes-treemacs-theme "doom-colors")

(use-package org-journal
  :custom
  (org-journal-date-prefix "* ")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-dir "~/Projects/notes")
  (org-journal-date-format "%A, %d %B %Y"))

(after! org-journal
  (map! :leader
        :prefix "j"
        :desc "org-journal-new-entry" "n" #'org-journal-new-entry
        :desc "org-journal-search-forever" "s" #'org-journal-search-forever
        :desc "org-journal-read-entry" "r" #'org-journal-read-entry))

(setq elfeed-feeds
      '("https://hnrss.org/best"
        "https://www.lesswrong.com/feed.xml?view=curated-rss"
        "https://lesswrong.ru/rss.xml"))

(use-package org-mind-map
  :init
  (require 'ox-org)
  :ensure t
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )
