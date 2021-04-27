(setq inhibit-startup-message t)

(scroll-bar-mode -1) ; Who needs a scroolbar in evil-mode?
(tool-bar-mode -1)
(tooltip-mode -1) ; Tooltips are bloat !1!!111111!!!!
(set-fringe-mode 10)
(set-language-environment "UTF-8")

(menu-bar-mode -1) ; Menu Bar is bloat !1!!!!!11

(setq scroll-conservatively 101)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3)))
(setq mouse-wheel-progressive-speed t)
(setq mouse-wheel-follow-mouse 't)

(setq default-directory "~")

(setq tab-always-indent 'complete)

(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 175)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(dolist (mode '(org-mode-hook
		term-mode-hook
                tetris-mode
                2048-game-mode
                shell-mode
                dired-mode-hook
		neotree-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package ivy
  :defer 0.1
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :after ivy
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (ivy-mode))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(setq ivy-initial-inputs-alist nil)

(use-package smex
  :init (smex-initialize))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(setq doom-modeline-height 1)
(custom-set-faces
 '(mode-line ((t (:family "FiraCode Nerd Font" :height 0.75))))
 '(mode-line-inactive ((t (:family "FiraCode Nerd Font" :height 0.75)))))

(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :init (smartparens-global-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.5))

(use-package doom-themes
  :defer t
  :init (load-theme 'doom-one t)
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(use-package all-the-icons)

(use-package dap-mode
  :commands dap-debug)

(use-package evil-tutor
  :commands evil-tutor-start)

(use-package evil-surround
  :after evil
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-easymotion
  :after evil
  :ensure t)

(use-package emojify
  :hook (after-init . global-emojify-mode))

(use-package neotree
  :commands neotree-toggle
  :config (setq neo-theme 'icons))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package lsp-ivy
  :after lsp-mode)

(use-package yasnippet
  :hook (lsp-mode . yas-global-mode))

(use-package general
  :after evil
  :config
  (general-create-definer leaderkeys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (leaderkeys
    "t" '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "f" '(:ignore t :which-key "file")
    "fs" '(save-buffer :which-key "save file")
    "ff" '(counsel-find-file :which-key "find file")
    "q" '(:ignore t :which-key "quit")
    "qq" '(kill-emacs :which-key "kill emacs")
    "qr" '(restart-emacs :which-key "restart emacs")
    "g" '(:ignore t :which-key "git")
    "gs" '(magit-status :which-key "magit-status")
    "o" '(:ignore t :which-key "open")
    "ot" '(neotree-toggle :which-key "open neotree")
    "oe" '(eshell :which-key "open eshell")
    ";" '(evilnc-comment-or-uncomment-lines :which-key "comment line")
    )) 

(use-package ess
  :hook (r-mode . ess))

(use-package lsp-latex
  :hook (latex-mode . lsp-latex))

(with-eval-after-load "tex-mode"
  (add-hook 'tex-mode-hook 'lsp-deferred)
  (add-hook 'latex-mode-hook 'lsp-deferred))

(use-package elcord
  :config
  (elcord-mode 1))

(use-package jupyter
  :disabled)

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Daniel Und Marc's Mega Emacs")
  (setq dashboard-startup-banner "~/.emacs.d/logo.png")
  :config
  (dashboard-setup-startup-hook))

(use-package gitignore-mode
  :mode "\\.gitignore\\'")

(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

(use-package ivy-hydra
  :after (ivy hydra))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'message-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-escape
  :after evil
  :config
  (evil-escape-mode 1)
  (setq evil-escape-sequence "fd"))

(defun lsp-mode-setup ()
  (lsp-modeline-code-actions-mode)
  (setq lsp-modeline-code-actions-segments '(count icons))
  (lsp-headerline-breadcrumb-mode)
  (setq lsp-headerline-breadcrumb-segments nil))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c 1")
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-modeline-diagnostics-enable t))

(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-set-bar 'left))

(use-package 2048-game
  :commands 2048-game)

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'top))

(use-package format-all
  :hook
  (format-all-mode . format-all-ensure-formatter)
  (prog-mode . format-all-mode))

(use-package better-defaults)

(use-package helpful
  :commands (helpful-callable helpful-command helpful-variable helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package eshell
  :commands eshell)

(use-package go-mode
  :defer t
  :mode "\\.go\\'"
  :hook (go-mode . lsp-deferred))

(use-package go-eldoc
  :hook (go-mode . go-eldoc-setup))

(use-package asm-mode
  :defer t)

(use-package nasm-mode
  :defer t)

(use-package slime
    :commands slime-mode
    :hook (slime-mode . company-mode)
    :init
    (progn
      (setq slime-contribs '(slime-asdf
                             slime-fancy
                             slime-indentation
                             slime-sbcl-exts
                             slime-scratch)
            inferior-lisp-program "sbcl")
      (setq slime-complete-symbol*-fancy t)
      (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)))

(use-package slime-company
  :hook (slime-mode . slime-company))

(use-package clojure-mode
  :hook (clojure-mode . lsp-deferred))

(use-package js2-mode
  :defer t
  :mode (("\\.js\\'" . js2-mode))
  :hook (js2-mode . lsp-mode))

(use-package rust-mode
  :defer t
  :mode "\\.rs\\'")

(add-hook 'rust-mode-hook #'lsp)

(use-package markdown-mode
  :mode "\\.md\\'")

(use-package vmd-mode
  :hook (markdown-mode . vmd-mode))

(use-package flycheck-rust
  :after rust-mode)

(use-package haskell-mode)

(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'dante-mode))

(use-package vimrc-mode
  :mode "\\.vim[rc]?\\'"
  :defer t
  :init
  (add-hook 'vimrc-mode-hook 'lsp-deferred)
  (add-hook 'vimrc-mode-hook 'company-mode))

(defun prolog-hook ()
    (lsp-register-client
        (make-lsp-client
        :new-connection
        (lsp-stdio-connection (list "swipl"
                                    "-g" "use_module(library(lsp_server))."
                                    "-g" "lsp_server:main"
                                    "-t" "halt"
                                    "--" "stdio"))
        :major-modes '(prolog-mode)
        :priority 1
        :multi-root t
        :server-id 'prolog-ls))
    (lsp-deferred))
(add-hook 'prolog-mode-hook #'prolog-hook)

(use-package fzf
  :commands fzf-git)

(use-package yaml-mode
  :defer t
  :mode "\\.y[a]?ml\\'")

(use-package dockerfile-mode
  :defer t
  :mode "\\Dockerfile\\'"
  :hook (dockerfile-mode . lsp-deferred))

(use-package json-mode
  :defer t
  :mode "\\.json\\'")

(use-package typescript-mode
  :defer t
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(defun elisp-hook ()
  (company-mode)
  (company-elisp))

(add-hook 'emacs-lisp-mode-hook 'elisp-hook)

(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview))

(use-package kubernetes-evil
  :ensure t
  :after kubernetes)

(use-package flycheck
  :hook (after-init . global-flycheck-mode))

(use-package restart-emacs
  :commands restart-emacs)

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
              ("<return>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'yas-minor-mode)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred))))  ; or lsp

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit)

(use-package hydra
  :defer t)

(use-package evil-nerd-commenter
  :after evil
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single
  :after dired)

(use-package diredfl
  :hook (dired-mode . diredfl-global-mode))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(format-all-default-formatters
   '(("Assembly" asmfmt)
     ("ATS" atsfmt)
     ("Bazel" buildifier)
     ("BibTeX" emacs-bibtex)
     ("C" clang-format)
     ("C#" clang-format)
     ("C++" clang-format)
     ("Cabal Config" cabal-fmt)
     ("Clojure" cljfmt)
     ("CMake" cmake-format)
     ("Crystal" crystal)
     ("CSS" prettier)
     ("D" dfmt)
     ("Dart" dartfmt)
     ("Dhall" dhall)
     ("Dockerfile" dockfmt)
     ("Elixir" mix-format)
     ("Elm" elm-format)
     ("Emacs Lisp" emacs-lisp)
     ("Fish" fish-indent)
     ("GLSL" clang-format)
     ("Go" goimports)
     ("GraphQL" prettier)
     ("Haskell" brittany)
     ("HTML" html-tidy)
     ("Java" clang-format)
     ("JavaScript" prettier)
     ("JSON" prettier)
     ("Jsonnet" jsonnetfmt)
     ("JSX" prettier)
     ("Kotlin" ktlint)
     ("LaTeX" latexindent)
     ("Less" prettier)
     ("Literate Haskell" brittany)
     ("Lua" lua-fmt)
     ("Markdown" prettier)
     ("Nix" nixpkgs-fmt)
     ("Objective-C" clang-format)
     ("OCaml" ocp-indent)
     ("Perl" perltidy)
     ("PHP" prettier)
     ("Protocol Buffer" clang-format)
     ("PureScript" purty)
     ("Python" black)
     ("R" styler)
     ("Reason" bsrefmt)
     ("ReScript" resfmt)
     ("Ruby" rufo)
     ("Rust" rustfmt)
     ("Scala" scalafmt)
     ("SCSS" prettier)
     ("Shell" shfmt)
     ("Solidity" prettier)
     ("SQL" sqlformat)
     ("Swift" swiftformat)
     ("Terraform" terraform-fmt)
     ("TOML" prettier)
     ("TSX" prettier)
     ("TypeScript" prettier)
     ("Verilog" istyle-verilog)
     ("Vue" prettier)
     ("XML" html-tidy)
     ("YAML" prettier)
     ("_Angular" prettier)
     ("_Flow" prettier)
     ("_Fortran 90" fprettify)
     ("_Gleam" gleam)
     ("_Ledger" ledger-mode)
     ("_Snakemake" snakefmt)))
 '(package-selected-packages
   '(company-box company lsp-ivy lsp-ui lsp-mode evil-nerd-commenter forge evil-magit magit evil-escape evil-collection evil general ivy-rich neotree doom-themes which-key rainbow-delimiters doom-modeline counsel ivy command-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
