;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-ir-black)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;CUSTOM ADDITION;;;
;; Font chage
(setq doom-font (font-spec :family "3270 Nerd Font" :size 24 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "3270 Nerd Font" :size 20))

;; Custom banner for dashboar
(setq fancy-splash-image "~/Pictures/other/felix.jpg")

;; Most remove options for the dashboard
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;; Beacon
(beacon-mode 1)

;; Line
(require 'telephone-line)
(setq telephone-line-primary-left-separator 'telephone-line-cubed-left
      telephone-line-primary-right-separator 'telephone-line-cubed-right
      telephone-line-secondary-left-separator 'telephone-line-nil
      telephone-line-secondary-right-separator 'telephone-line-nil)
(defface my-red '((t (:foreground "white" :background "red"))) "")
(defface my-orangered '((t (:foreground "white" :background "orange red"))) "")
(defface my-orange '((t (:foreground "dim grey" :background "orange"))) "")
(defface my-gold '((t (:foreground "dim grey" :background "gold"))) "")
(defface my-yellow '((t (:foreground "dim grey" :background "yellow"))) "")
(defface my-chartreuse '((t (:foreground "dim grey" :background "chartreuse"))) "")
(defface my-green '((t (:foreground "dim grey" :background "green"))) "")
(defface my-sgreen '((t (:foreground "dim grey" :background "spring green"))) "")
(defface my-cyan '((t (:foreground "dim grey" :background "cyan"))) "")
(defface my-blue '((t (:foreground "white" :background "blue"))) "")
(defface my-dmagenta '((t (:foreground "white" :background "dark magenta"))) "")

(setq telephone-line-faces
      '((red . (my-red . my-red))
        (ored . (my-orangered . my-orangered))
        (orange . (my-orange . my-orange))
        (gold . (my-gold . my-gold))
        (yellow . (my-yellow . my-yellow))
        (chartreuse . (my-chartreuse . my-chartreuse))
        (green . (my-green . my-green))
        (sgreen . (my-sgreen . my-sgreen))
        (cyan . (my-cyan . my-cyan))
        (blue . (my-blue . my-blue))
        (dmagenta . (my-dmagenta . my-dmagenta))
        (evil . telephone-line-evil-face)
        (accent . (telephone-line-accent-active . telephone-line-accent-inactive))
        (nil . (mode-line . mode-line-inactive))))

(telephone-line-defsegment s1 ()  "")
(telephone-line-defsegment s2 ()  "")
(telephone-line-defsegment s3 ()  "")
(telephone-line-defsegment s4 ()  "")
(telephone-line-defsegment s5 ()  "")
(telephone-line-defsegment s6 ()  "")
(telephone-line-defsegment s7 ()  "")
(telephone-line-defsegment s8 ()  "")
(telephone-line-defsegment s9 ()  "")
(telephone-line-defsegment s10 () "")
(telephone-line-defsegment s11 () "")

(setq telephone-line-lhs
      '((red . (s1))
        (ored . (s2))
        (orange . (s3))
        (gold . (s4))
        (yellow . (s5))
        (chartreuse . (s6))
        (green . (s7))
        (sgreen . (s8))
        (cyan . (s9))
        (blue . (s10))
        (dmagenta . (s11))
        (nil    . (telephone-line-minor-mode-segment
                   telephone-line-buffer-segment))))
(setq telephone-line-rhs
      '((nil    . (telephone-line-misc-info-segment))
        (accent . (telephone-line-major-mode-segment))
        (evil   . (telephone-line-airline-position-segment))))
(telephone-line-mode 1)
