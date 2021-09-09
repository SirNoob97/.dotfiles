(setq inhibit-startup-message t)

(scroll-bar-mode 0)        ; Disable visible scrollbar
(tool-bar-mode 0)          ; Disable the toolbar
(tooltip-mode 0)           ; Disable tooltips
(set-fringe-mode 0)        ; Give some breathing room
(menu-bar-mode 0)            ; Disable the menu bar

(column-number-mode)
(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(load-theme 'wombat t)

(global-set-key (kbd "<escape>") 'keyboard-scape-quit)

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package) (package-install 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-java-java-path "/home/martin/.sdkman/candidates/java/current/bin/java")
 '(package-selected-packages
   '(company-lsp xclip lsp-ui company evil-collection flycheck lsp-treemacs lsp-ivy which-key helpful ivy-rich doom-modeline counsel dap-mode lsp-java lsp-mode use-package cl-libify undo-tree s)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'use-package)
(setq use-package-always-ensure t)

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;(use-package evil-collection
;  :after evil
;  :config
;  (evil-collection-init))
;
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("C-l" . ivy-alt-done)
         ("TAB" . ivy-next-line)
         ("<backtab>" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-l" . ivy-done)
         ("<backtab>" . ivy-previous-line)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-M-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

; LSP
;(use-package flycheck
;  :init
;  (setq flycheck-check-syntax-automatically '(mode-enabled save))
;  :custom
;  (flycheck-highlighting-mode 'lines)
;  (flycheck-highlighting-style 'leve-face))


;----------------------
(use-package yasnippet
  :init
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  :config
  (autoload 'yas/expand "yasnippet" t)
  (autoload 'yas/load-directory "yasnippet" t)
  (mapc 'yas/load-directory yas/root-directory)
  (yas-global-mode 1))

(defun default-java-code-style-hook()
  (setq c-basic-offset 2
        c-label-offset 0
        tab-width 2
        indent-tabs-mode nil
        require-final-newline nil))
(add-hook 'java-mode-hook 'default-java-code-style-hook)

(use-package flycheck
  :init
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flycheck errors*" eos)
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (side . bottom)
                 (reusable-frames . visible)
                 (window-height . 0.15))))

(defun custom-java-mode-hook ()
  (auto-fill-mode)
  (flycheck-mode)
  (subword-mode)
  (yas-minor-mode)
  (set-fringe-style '(8 . 0))

  ;; Fix indentation for anonymous classes
  (c-set-offset 'substatement-open 0)
  (if (assoc 'inexpr-class c-offsets-alist)
      (c-set-offset 'inexpr-class 0))

  ;; Indent arguments on the next line as indented body.
  (c-set-offset 'arglist-intro '++))
(add-hook 'java-mode-hook 'custom-java-mode-hook)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-headerline-breadcrumb-segments '(file symbols))
  :bind
  (:map lsp-mode-map
        (("M-RET" . lsp-execute-code-action)))
  :config
  (setq lsp-inhibit-message t
	lsp-completion-enable-additional-text-edit nil
        lsp-eldoc-render-all nil
        lsp-enable-file-watchers nil
        lsp-enable-symbol-highlighting nil
        lsp-headerline-breadcrumb-enable nil
        lsp-highlight-symbol-at-point nil
        lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable nil)

  ;; Performance tweaks, see
  ;; https://github.com/emacs-lsp/lsp-mode#performance
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500))

(use-package lsp-ui
  :config
  (setq lsp-prefer-flymake nil
        lsp-ui-doc-delay 5.0
        lsp-ui-sideline-enable nil
        lsp-ui-sideline-show-symbol nil))

(use-package lsp-java
  :init
  (setq lsp-java-vmargs
        (list
         "-noverify"
         "-Xmx3G"
         "-XX:+UseG1GC"
         "-XX:+UseStringDeduplication"
         "-javaagent:/home/martin/.m2/repository/org/projectlombok/lombok/1.18.20/lombok-1.18.20.jar"
         )

        ;; Don't organise imports on save
        lsp-java-save-action-organize-imports nil

        ;; Fetch less results from the Eclipse server
        lsp-java-completion-max-results 20

        lsp-java-java-path "/home/martin/.sdkman/candidates/java/current/bin/java"
        )

  :config
  (add-hook 'java-mode-hook #'lsp))

(use-package dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-register-debug-template
   "localhost:5005"
   (list :type "java"
         :request "attach"
         :hostName "localhost"
         :port 5005))
  ;(dap-register-debug-template
  ; "lxd"
  ; (list :type "java"
  ;       :request "attach"
  ;       :hostName "x.x.x.x"
  ;       :port 5005))
  )

(use-package dap-java
  :ensure nil
  :after (lsp-java)

  ;; The :bind here makes use-package fail to lead the dap-java block!
  ;; :bind
  ;; (("C-c R" . dap-java-run-test-class)
  ;;  ("C-c d" . dap-java-debug-test-method)
  ;;  ("C-c r" . dap-java-run-test-method)
  ;;  )

  :config
  (global-set-key (kbd "<f7>") 'dap-step-in)
  (global-set-key (kbd "<f8>") 'dap-next)
  (global-set-key (kbd "<f9>") 'dap-continue)
  )

(use-package treemacs
  :init
  (add-hook 'treemacs-mode-hook
            (lambda () (treemacs-resize-icons 15))))


;----------------------

(use-package xclip
  :config
  (xclip-mode 1))


;(use-package lsp-mode
;  :hook
;  (lsp-mode . lsp-enable-which-key-integration)
;  :init
;  (setq lsp-keymap-prefix "C-c l")
;  (setq lsp-headerline-breadcrumb-segments '(file symbols))
;  :config (setq lsp-completion-enable-additional-text-edit nil))

(use-package company
  :bind (:map company-active-map
              ("TAB" . company-complete-common-or-cycle)
	      ("<backtab>" . company-select-previous))
  :custom
  (company-idle-delay 0.0)
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (company-mode))
;
;(use-package lsp-treemacs :after lsp) 
;(use-package lsp-ivy :after lsp) 
;(use-package lsp-ui
;  :hook (lsp-mode . lsp-ui-mode)
;  :custom (lsp-ui-doc-position 'bottom))

;(use-package lsp-java :config (add-hook 'java-mode-hook 'lsp))
;(use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
;(use-package dap-java :ensure nil)
