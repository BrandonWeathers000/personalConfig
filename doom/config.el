;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

;; Font chage
(setq doom-font (font-spec :family "Blex Mono Nerd Font" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Blex Mono Nerd Font" :size 16))

;; Custom banner for dashboard
;; (setq fancy-splash-image "")

;; Most remove options for the dashboard
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;; Tarnsparency
(set-frame-parameter nil 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 85))

;; Mu4e
(require 'mu4e)

(setq mu4e-maildir "~/Mail/gmail")

(setq mu4e-get-mail-command "mbsync gmail")
(setq mu4e-update-interval 300)

(setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
(setq mu4e-drafts-folder "/[Gmail]/Drafts")
(setq mu4e-trash-folder  "/[Gmail]/Trash")

(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/bin/msmtp")

;; IRC/ERC
(use-package erc
  :custom
  (erc-interactive-display 'buffer))

(setq erc-nick "Foxlem")
(setq erc-prompt "Foxlem ★☆★ ")

;; Vertico posframe
(require 'vertico-posframe)
(vertico-posframe-mode 1)

;; Beacon
(beacon-mode 1)

;; Modeline
(setq doom-modeline-modal nil)
(setq doom-modeline-modal-icon nil)
(setq doom-modeline-buffer-state-icon t)
(size-indication-mode -1)

;; Turn off show paren mode
;; (show-paren-mode -1)

;; Theme
;; (setq doom-theme 'doom-outrun-electric)

;; Tron theme
;; (use-package tron-legacy-theme
;;   :config
;;   (load-theme 'tron-legacy t))

;; Customization options
;; (use-package tron-legacy-theme
;;   :config
;;   (setq tron-legacy-theme-dark-fg-bright-comments t)
;;   (load-theme 'tron-legacy t))

;; Catppuccin theme
;; (load-theme 'catppuccin :no-confirm)

;; frappe, latte, macchiato, or mocha
;; (setq catppuccin-flavor 'mocha)
;; (catppuccin-reload)

;; Only for the currently active flavor
;; (catppuccin-set-color 'base "#000000") ;; change base to #000000 for the currently active flavor
;; (catppuccin-reload)

(add-to-list 'custom-theme-load-path "/home/brandon/.config/doom/themes/" t)

(setq doom-modeline-buffer-file-name-style 'file-name)

;; Modeline buffer color
(set-face-attribute 'mode-line-buffer-id nil
                    :foreground "#D2C4ED")

;; (load-theme 'BWeathers t)
(load-theme 'BWeathers-purple t)

(after! doom-modeline
  (doom-modeline-def-modeline 'my-simple-line
    '(bar workspace-name window-number modals matches buffer-info)
    '(misc-info minor-modes input-method buffer-position))

  (defun my/set-simple-modeline ()
    (doom-modeline-set-modeline 'my-simple-line 'default))

  (add-hook 'doom-modeline-mode-hook #'my/set-simple-modeline))

;; Python and holo-layer
;; (setq holo-layer-python-command "~/.venvs/holo-layer/bin/python")

;; (add-to-list 'load-path "~/holo-layer/")
;; (require 'holo-layer)

;; (setq holo-layer-enable-cursor-animation t)

;; (holo-layer-enable)

;; Tell Emacs to use Firefox
(setq browse-url-browser-function 'browse-url-firefox)
(setq browse-url-firefox-program "firefox")

;; Disable syntax highlighting
(setq font-lock-mode nil)

;; Keybinds
(with-eval-after-load 'erc
  (define-key erc-mode-map (kbd "RET") 'nil))
(with-eval-after-load 'erc
  (define-key erc-mode-map (kbd "C-c C-c") 'erc-send-current-line))

(map! :leader
      "k" #'evil-insert-digraph)

(defun print-an-arrow ()
  "This function prints out the arrow (→) digraph"
  (interactive)
  (insert "→"))

(map! :leader
      "@" #'print-an-arrow)

(defun java-SOP (start end)
  "This function prints System.out.println(); in the buffer"
  (interactive "r")
  (let ((text (buffer-substring start end)))
    (delete-region start end)
    (insert (format "System.out.println(\%s\);" text))))

(map! :leader
      "S" #'nil)

(map! :leader
      "S" #'java-SOP)

(defun org-document-header ()
  "This function prints the title, author, date, and default options fields for org → LaTeX complicaiton"
  (interactive)
  (insert
   (concat
    "#+TITLE:\n"
    "#+AUTHOR:Brandon Weathers\n"
    "#+DATE:" (format-time-string "%m/%d/%Y") "\n"
    "#+OPTIONS: toc:nil num:nil")))

(map! :leader
      "H" #'nil)

(map! :leader
      "H" #'org-document-header)

(defun print-current-date ()
  "This function prints the current date"
  (interactive)
  (insert (format-time-string "%m/%d/%Y")))

(map! :leader
      "D" #'nil)

(map! :leader
      "D" #'print-current-date)
