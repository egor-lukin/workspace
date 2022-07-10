;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here, run 'doom sync' on
;; the command line, then restart Emacs for the changes to take effect.
;; Alternatively, use M-x doom/reload.
;;
;; WARNING: Disabling core packages listed in ~/.emacs.d/core/packages.el may
;; have nasty side-effects and is not recommended.


;; All of Doom's packages are pinned to a specific commit, and updated from
;; release to release. To un-pin all packages and live on the edge, do:
;(unpin! t)

;; ...but to unpin a single package:
;(unpin! pinned-package)
;; Use it to unpin multiple packages
;(unpin! pinned-package another-pinned-package)


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a particular repo, you'll need to specify
;; a `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, for whatever reason,
;; you can do so here with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

(package! org-super-agenda)
(package! anki-editor)
(package! tramp-term)
(package! google-translate :pin "6f7b75b2aa1ff4e50b6f1579cafddafae5705dbd")
(package! add-node-modules-path)
(package! prettier-js)
(package! eslint-fix)
;; (package! typescript-mode :disable t)
(package! typescript-mode)
(package! tide)
;; (package! tide :disable t)
(package! zeal-at-point)
(package! dionysos)
(package! xterm-color)
(package! org-download)
(package! company-tabnine)
(package! graphviz-dot-mode)
(package! kubernetes-evil)
;; (unpin! org-roam)
(package! org-roam :pin "b63ff2a7bbd888128939b8ae88c3f62c0d529945")
(package! org-roam-ui)
;; (package! elfeed)
(package! org-ql)
(package! org-mind-map)
(package! sound-wav)
(package! cider)
(package! helm-dash)
(package! hledger-mode)
(unpin! visual-fill-column)
(package! org-recoll :recipe (:repo "alraban/org-recoll"))
(package! ranger)
(package! ereader)
(package! nov :recipe (:repo "https://depp.brause.cc/nov.el.git"))

(package! telega)
(package! magit)
;; (package! multitran)

;; (package! request)
;; (package! map :pin "bb50dba")

;; (package! reverso
;;   :pin "1a86accd5a970bf4bca8e3802db513cc337c8a61"
;;   :recipe (:repo "https://github.com/LukinEgor/reverso-emacs"))
