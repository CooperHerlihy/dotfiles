;;; post-init.el --- After init.el -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Section | Emacs

(add-to-list 'load-path "~/.emacs.d/")

;; The system app launcher
(defun my-emacs-launcher ()
  "Create a temporary frame as an app launcher"
  (interactive)
  (with-selected-frame
    (make-frame '((name . "emacs-launcher")
                  (minibuffer . only)
                  (fullscreen . 0)
                  (undecorated . t)))
                  (unwind-protect
                    (app-launcher-run-app)
                    (delete-frame))))

;; Automatically update packages at regular intervals
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7) ; 7 days
  (auto-package-update-hide-results t)
  (auto-package-update-delete-old-versions t)
  (auto-package-update-prompt-before-update t)
  :config
  (auto-package-update-maybe)) ; Run at startup if the interval has been elapsed

(setq package-install-upgrade-built-in t) ; Allow emacs to upgrade built-in packages
;; Save the minbuffer history across sessions
(use-package savehist
  :ensure nil
  :commands (savehist-mode savehist-save)
  :hook
  (after-init . savehist-mode)
  :init
  (setq history-length 300)
  (setq savehist-autosave-interval 600))

;; Automatically update a buffer to reflect external changes made to disk
(use-package autorevert
  :ensure nil
  :commands (auto-revert-mode global-auto-revert-mode)
  :hook
  (after-init . global-auto-revert-mode)
  :init
  (setq auto-revert-verbose t) ; Display messages
  (setq auto-revert-interval 5) ; 5 seconds between checks
  (setq auto-revert-remote-files nil) ; Do not revert remote files
  (setq auto-revert-use-notify t)
  (setq auto-revert-avoid-polling nil))

;; Show key chord hints
(use-package which-key
  :ensure nil ; Builtin
  :commands which-key-mode
  :hook (after-init . which-key-mode)
  :custom
  (which-key-idle-delay 0.25)
  (which-key-idle-secondary-delay 0.25)
  (which-key-add-column-padding 1)
  (which-key-max-description-length 40))

;; Package navigation and interaction
(use-package projectile
  :init
  ;; (setq projectile-cleanup-known-projects t)
  (setq projectile-auto-discover t)
  (cond
   ((eq system-type 'windows-nt)
    (setq projectile-project-search-path (list "c:/dev" (format "%s/notes" (getenv "USERPROFILE")))))
   (t
    (setq projectile-project-search-path '("~/dev" "~/notes"))))
  :bind (:map projectile-mode-map
              ("C-c p" . 'projectile-command-map))
  :config
  (projectile-mode +1)
  (add-hook 'project-find-functions #'project-projectile))

;; ripgrep for projectile
(use-package rg)

;;; Section | Editing

(electric-pair-mode +1) ; Auto insert paren/brace/bracket pairs

;; Provide linear undo for evil
(use-package undo-fu
  :commands (undo-fu-only-undo
             undo-fu-only-redo
             undo-fu-only-redo-all
             undo-fu-disable-checkpoint))

;; Save undo history across sessions
(use-package undo-fu-session
  :commands undo-fu-session-global-mode
  :hook (after-init . undo-fu-session-global-mode))

;; Vim emulation
(use-package evil
  :hook ((text-mode . evil-local-mode)
         (prog-mode . evil-local-mode)
         (conf-mode . evil-local-mode))
  :init
  (setq evil-undo-system 'undo-fu)
  (setq evil-ex-search-vim-style-regexp t) ; Use Vim-style regular expressions
  (setq evil-split-window-below t) ; Enable automatic horizontal split below
  (setq evil-vsplit-window-right t) ; Enable automatic vertical split to the right
  (setq evil-echo-state nil) ; Disable echoing Evil state to avoid replacing eldoc
  (setq evil-want-C-u-scroll t) ; Enable C-u to scroll up in normal mode
  (setq evil-want-Y-yank-to-eol t) ; Whether Y yanks to the end of the line

  :config

  ;; Center after large moves
  (defun my-evil-center-line (&rest _)
    (evil-scroll-line-to-center nil))
  (advice-add 'evil-search-next :after #'my-evil-center-line)
  (advice-add 'evil-search-previous :after #'my-evil-center-line)
  (advice-add 'evil-scroll-up :after #'my-evil-center-line)
  (advice-add 'evil-scroll-down :after #'my-evil-center-line)

  ;; Evil gcc and gc comments
  (evil-define-operator my-evil-comment-or-uncomment (beg end)
    "Toggle comment for the region between BEG and END."
    (interactive "<r>")
    (comment-or-uncomment-region beg end))
  (evil-define-key 'normal 'global (kbd "gc") 'my-evil-comment-or-uncomment))

;; kj leaves insert mode
(use-package evil-escape
  :hook (evil-local-mode . evil-escape-mode)
  :init
  (setq-default evil-escape-key-sequence "kj")
  (setq-default evil-escape-delay 0.2))

;; vim-surround emulation
(use-package evil-surround
  :hook (evil-local-mode . evil-surround-mode))

(use-package dumb-jump
  :commands dumb-jump-xref-activate
  :init
  ;; Register `dumb-jump' as an xref backend so it integrates with
  ;; `xref-find-definitions'. A priority of 90 ensures it is used only when no
  ;; more specific backend is available.
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate 90)

  (setq dumb-jump-aggressive nil)
  ;; (setq dumb-jump-quiet t)

  ;; Number of seconds a rg/grep/find command can take before being warned to
  ;; use ag and config.
  (setq dumb-jump-max-find-time 3)

  ;; Use `completing-read' so that selection of jump targets integrates with the
  ;; active completion framework (e.g., Vertico, Ivy, Helm, Icomplete),
  ;; providing a consistent minibuffer-based interface whenever multiple
  ;; definitions are found.
  (setq dumb-jump-selector 'completing-read)

  ;; If ripgrep is available, force `dumb-jump' to use it because it is
  ;; significantly faster and more accurate than the default searchers (grep,
  ;; ag, etc.).
  (when (executable-find "rg")
    (setq dumb-jump-force-searcher 'rg)
    (setq dumb-jump-prefer-searcher 'rg)))

;; Strip trailing whitespace on save
(use-package stripspace
  :hook ((text-mode . stripspace-local-mode)
         (prog-mode . stripspace-local-mode)
         (conf-mode . stripspace-local-mode))
  :custom
  (stripspace-only-if-initially-clean nil))

;;; Section | Completion

;; Vertical completion interface
(use-package vertico
  :config
  (vertico-mode))

;; Orderless search in vertico completions
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia annotations in completions
(use-package marginalia
  :hook (after-init . marginalia-mode))

;; Completion popup
(use-package corfu
  :commands (corfu-mode global-corfu-mode)
  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode)
         (vterm-mode . corfu-mode))

  :custom
  ;; Hide commands in M-x which do not apply to the current mode.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Disable Ispell completion function. As an alternative try `cape-dict'.
  (text-mode-ispell-word-completion nil)
  (tab-always-indent 'complete)

  :config
  (global-corfu-mode))

;;; Section | File Type Support

(setq-default fill-column 80)
(add-hook `text-mode-hook `turn-on-auto-fill)

(use-package markdown-mode)

;; c-indent-comment-alist, c-indent-comments-syntactically-p (see Indentation Commands);
;; c-doc-comment-style (see Documentation Comments);
;; c-block-comment-prefix, c-comment-prefix-regexp (see Customizing Filling and Line Breaking);
;; c-hanging-braces-alist (see Hanging Braces);
;; c-hanging-colons-alist (see Hanging Colons);
;; c-hanging-semi&comma-criteria (see Hanging Semicolons and Commas);
;; c-cleanup-list (see Clean-ups);
(setq c-basic-offset 4)
;; c-offsets-alist (see c-offsets-alist);
;; c-comment-only-line-offset (see Comment Line-Up Functions);
;; c-special-indent-hook, c-label-minimum-indentation (see Other Special Indentations);
;; c-backslash-column, c-backslash-max-column (see Customizing Macros).

(use-package lua-mode)

(use-package glsl-mode)

;;; Section | Language Support

;;; Section | New Features

;; A magical Git client
(use-package magit
  :bind ("C-x g" . magit-status))

;; (cond
;;  ((eq system-type 'windows-nt)
;;   (global-set-key (kbd "C-c t") 'eshell))
;;  (t
;;   ;; A terminal emulator written in C
;;   (use-package vterm
;;     :if (bound-and-true-p module-file-suffix)
;;     :bind ("C-c t" . 'vterm)
;;     :preface
;;     (when noninteractive
;;       ;; vterm unnecessarily triggers compilation of vterm-module.so upon loading.
;;       ;; This prevents that during byte-compilation (`use-package' eagerly loads
;;       ;; packages when compiling).
;;       (advice-add #'vterm-module-compile :override #'ignore))
;;
;;     (defun my-vterm--setup ()
;;       (setq mode-line-format nil) ; Hide the mode-line
;;       (setq-local hscroll-margin 0) ; Inhibit early horizontal scrolling
;;       (setq-local confirm-kill-processes nil)) ; Suppress prompt for terminating active processes
;;
;;     :init
;;     (add-hook 'vterm-mode-hook #'my-vterm--setup)
;;     (setq vterm-timer-delay 0.05)
;;     (setq vterm-kill-buffer-on-exit t)
;;     (setq vterm-max-scrollback 5000))))

;;; Section | Aesthetics

;; (add-to-list 'default-frame-alist '(fullscreen . fullboth)) ; Default to fullscreen

;; Configure the default face
(if (find-font (font-spec :name "JetBrainsMono NF"))
    (set-face-font 'default "JetBrainsMono NF"))
(set-face-attribute 'default nil
                    :height 110) ; 11 point size

;; Relative line numbers
(setq-default display-line-numbers-type 'relative)
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode))

;; Modeline
(setq line-number-mode t)
(setq column-number-mode t)

;; Color theme (temporary, will write custom)
(use-package doom-themes
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  :config
  (load-theme 'doom-one t)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package xdg-launcher
  :vc (:url "https://github.com/emacs-exwm/xdg-launcher")
  :commands (app-launcher-run-app xdg-launcher-run-app))
