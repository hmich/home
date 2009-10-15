;; Enter the debugger each time an error is found
(setq debug-on-error t)

(setq load-path
      (append  '("~/emacs" "~/emacs/slime" "~/emacs/haskell-mode" "~/emacs/ecb-2.32" "~/emacs/auctex")
               load-path))

(require 'cl)

;; Windows compatibility
(defconst win32p
  (eq system-type 'windows-nt)
  "Check if we are running Microsoft Windows")

(if win32p
    (progn
      (setq inferior-lisp-program "c:/Development/lisp/clisp-2.43/clisp.exe -K full")
      (setq haskell-program-name "C:/dev/haskell/ghc-6.10.1/bin/ghci.exe")
      (setq common-lisp-hyperspec-root "file:c:/Development/Lisp/HyperSpec/")

      ;(setq font "-outline-Lucida Console-normal-r-normal-normal-15-112-96-96-c-90-iso8859-5")
      ;(setq font "-outline-Consolas-normal-r-normal-normal-15-112-96-96-c-*-iso8859-5")
      ;(setq font "-outline-Lucida Sans Typewriter-normal-r-normal-normal-13-97-96-96-c-*-iso8859-5")
      ;(setq font "-outline-DejaVu Sans Mono-normal-r-normal-normal-15-112-96-96-c-*-iso8859-5")

      (setq font "-outline-Lucida Sans Typewriter-normal-r-normal-normal-13-97-96-96-c-*-iso8859-5")

      ;(set-frame-font "-outline-Consolas-normal-r-normal-normal-15-112-96-96-c-*-iso8859-5")

      (set-language-environment 'UTF-8)
      (set-terminal-coding-system 'utf-8)
      (set-keyboard-coding-system 'utf-8)
      (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

      (define-coding-system-alias 'windows-1251 'cp1251)

      (prefer-coding-system 'cp866)
      (prefer-coding-system 'koi8-r-unix)
      (prefer-coding-system 'windows-1251-dos)
      (prefer-coding-system 'utf-8-unix)

      (setq default-input-method 'russian-computer)

      (setq w32-pass-lwindow-to-system nil
            w32-pass-rwindow-to-system nil
            w32-lwindow-modifier 'super
            w32-rwindow-modifier 'super
            w32-apps-modifier 'hyper
            w32-downcase-file-names t)

      (setq preview-gs-command "gswin32c"))
  (progn
    (setq inferior-lisp-program "sbcl")
    (setq haskell-program-name "ghci")
    (setq font "-xos4-terminus-medium-r-normal--16-160-72-72-c-80-iso8859-1")))

(require 'maxframe)

(defun with-frame (frame, func)
  (let ((current-frame (selected-frame)))
    (select-frame frame)
    (funcall func)
    (select-frame current-frame)))

(add-hook 'window-setup-hook 'maximize-frame)
(add-hook 'after-make-frame-functions
          (lambda (frame) (with-frame frame 'maximize-frame)))

(setq viper-mode t)
(setq viper-want-ctl-h-help t)
(setq viper-expert-level 5)
(setq viper-inhibit-startup-message t)
(setq viper-case-fold-search t)
(setq viper-shift-width 4)
(setq viper-vi-style-in-minibuffer nil)
(copy-face 'default 'viper-minibuffer-vi-face)
(setq-default viper-ex-style-motion nil)
(setq-default viper-ex-style-editing nil)
(setq-default viper-delete-backwards-in-replace t)
(setq-default viper-auto-indent t)
;; (require 'viper)
;; (require 'vimpulse)
;; (require 'pager)
;;(define-key viper-vi-global-user-map "g" 'beginning-of-buffer)
;; (define-key viper-vi-global-user-map "\C-v" 'pager-page-down)
;; (define-key viper-vi-global-user-map "\M-v" 'pager-page-up)
;; (define-key viper-vi-global-user-map "\C-f" 'pager-page-down)
;; (define-key viper-vi-global-user-map "\C-b" 'pager-page-up)
;; (define-key viper-vi-global-user-map "\C-u" 'universal-argument)
;;(define-key viper-vi-global-user-map (kШжbd ")рр'viper-append)
;;(define-key viper-vi-global-user-map [332868] 'viper-Append)

(setq woman-use-own-frame nil)     ; don't create new frame for manpages
(setq woman-use-topic-at-point t)  ; don't prompt upon K key (manpage display)

;; Apply color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)

;; Fonts
(add-to-list 'default-frame-alist (append '(font) font))
(set-frame-font font)

;; Backuping
(setq backup-by-copying t
      backup-directory-alist '((".*" . "~/.backup"))
      kept-new-versions 16
      kept-old-versions 2
      delete-old-versions t
      version-control t
      backup-by-copying-when-linked t)

;; Auto-revert
(global-auto-revert-mode)

;; Interface settings
(setq frame-title-format '(buffer-file-name "%f" ("%b")))
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(mouse-wheel-mode t)
(setq visible-bell t)
(setq mouse-yank-at-point t)
(set-fringe-mode 4)
(if window-system
    (progn
      (mouse-avoidance-mode 'animate)
      (setq x-select-enable-clipboard t)))

;; Modeline settings
(line-number-mode t)
(column-number-mode t)
(setq echo-keystrokes 0.01)
(setq display-time-load-average t)
(setq display-time-format "%T %d/%m/%y")
(setq display-time-interval 1)
(display-time)
(size-indication-mode)
;(timeclock-modeline-display)

;; Cursor settings
(when (fboundp 'blink-cursor-mode) (blink-cursor-mode -1))

;; Completions settings
(partial-completion-mode t)
(eval-after-load "icomplete" '(progn (require 'icomplete+)))
(require 'icomplete)
(icomplete-mode t)

;; Basic editing settings
(normal-erase-is-backspace-mode t)
(setq require-final-newline t)
(setq kill-whole-line t)
(setq track-eol t)
(setq set-mark-command-repeat-pop t)
(setq sentence-end-double-space nil)
;; (setq next-line-add-newlines t)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(setq grep-command "grep -n ")

;; Different limits
(setq message-log-max 3000)
(setq history-length 100)
(setq mark-ring-max 100)
(setq kill-ring-max 200)

;; View registers
(require 'list-register)
(global-set-key (kbd "C-x r v") 'list-registers)

;; Scrolling
;; (setq scroll-step 1)
;; (setq scroll-conservatively 50)
;; (setq scroll-preserve-screen-position nil)
;; (setq scroll-margin 0)
(require 'smooth-scrolling)

(require 'generic-x)

;; Reindent after yank
;; (defadvice yank (after indent-region activate)
;;   (indent-region (region-beginning) (region-end) nil))

;; Other settings
(pc-selection-mode)
(transient-mark-mode 1)
(global-font-lock-mode t)
(setq bookmark-save-flag 1)
(setq desktop-load-locked-desktop t)

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-foreground 'show-paren-match-face nil)
(set-face-background 'show-paren-match-face "gray22")

;; Window configurations settings
(windmove-default-keybindings 'meta)

(require 'winring)
(setq winring-show-names t)
(setq winring-prompt-on-create 'nil)

(winring-initialize)
(winring-new-configuration)
(winring-prev-configuration)

(winner-mode t)

;; Abbreviations
(setq-default abbrev-mode t)
(setq save-abbrevs t)
(if (file-exists-p  abbrev-file-name) (quietly-read-abbrev-file abbrev-file-name))

(require 'saveplace)
(setq-default save-place t)

;; Timestamp
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-active t)

;; File open and save settings
(auto-compression-mode t)
(setq backup-by-copying-when-linked t)
(setq backup-by-copying-when-mismatch t)
(add-hook 'write-file-hooks 'time-stamp)

;; Automatically make missing directories
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))

(defun fc-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(global-set-key (kbd "C-c C-e") 'eval-print-last-sexp)

;; (require 'whitespace)
;; (global-whitespace-mode)
;; (add-hook 'write-file-hooks 'whitespace-cleanup)

;; Strip trailing empty lines from a file
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(setq-default show-trailing-whitespace nil)

;; Startup and exit
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message (user-login-name))
(fset 'yes-or-no-p 'y-or-n-p)

;; Default mode
(setq default-major-mode 'text-mode)

;; Text settings
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default fill-column 70)
(setq-default indicate-empty-lines t)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Shell command completion
(require 'shell-command)
(shell-command-completion-mode)

;; Shell colors
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Recursive find-file
(require 'find-recursive)

;; Spell checking
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra"))
(setq ispell-dictionary "russian")

(setq gdb-many-windows t)
(setq gdb-show-changed-values t)
(setq gud-tooltip-echo-area t)
(setq gdb-use-separate-io-buffer t)

;; Flymake
;; (require 'flymake)
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; (setq flymake-gui-warnings-enabled nil)

;; (defun flymake-latex-master-file-p ()
;;   (interactive)
;;   (let* ((grep-cmd (concat grep-command  "\\\\documentclass " (buffer-file-name)))
;;          (res (call-process-shell-command grep-cmd)))
;;     (= 0 res)))

;; (defun flymake-latex-init ()
;;   (if (flymake-latex-master-file-p)
;;       (flymake-simple-tex-init)
;;     (flymake-master-tex-init)))

;; (defun flymake-latex-cleanup ()
;;   (flymake-master-cleanup)
;;   (let ((file-name (file-name-sans-extension flymake-temp-master-file-name)))
;;     (dolist (ext '(".aux" ".log" ".out" ".pdf" ".dvi" ".toc"))
;;       (flymake-safe-delete-file (concat file-name ext)))))

;; (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.tex\\'" flymake-latex-init flymake-latex-cleanup))

;; Flyspell
;; (add-hook 'tex-mode-hook 'flyspell-mode)
;; (add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'c-mode-common-hook 'flyspell-prog-mode)

;; Makefiles
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq show-trailing-whitespace t)))

;; Highlight current line
(global-hl-line-mode)
(set-face-background 'hl-line "gray9")

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

(defun dont-show-trailing-whitespace ()
  (interactive)
  (setq show-trailing-whitespace nil))

;; When saving files, set execute permission if #! is in first line.
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; Development
(which-function-mode)

;; Visual bookmarks
(setq bm-restore-repository-on-load t)
(require 'bm)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

;; make bookmarks persistent as default
(setq-default bm-buffer-persistence t)

;; Loading the repository from file when on start up.
(add-hook' after-init-hook 'bm-repository-load)

;; Restoring bookmarks when on file find.
(add-hook 'find-file-hooks 'bm-buffer-restore)

;; Saving bookmark data on killing a buffer
(add-hook 'kill-buffer-hook 'bm-buffer-save)

;; Saving the repository to file when on exit.
;; kill-buffer-hook is not called when emacs is killed, so we
;; must save all bookmarks first.
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))

;; Calendar settings
(setq european-calendar-style t)
(setq calendar-week-start-day 1)
(setq mark-holidays-in-calendar t)

;; Customization settings
(setq custom-file "~/emacs/custom.el")
(load custom-file 'noerror)

;; EDiff
(setq ediff-custom-diff-options "-u")
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; Mail settings
(setq user-full-name "Igor Akhmetov")
(setq user-mail-address "Igor.Akhmetov@gmail.com")
(setq mail-host-address "gmail.com")

;; Pager settings
(require 'pager)
(global-set-key "\C-v"            'pager-page-down)
(global-set-key [next]            'pager-page-down)
(global-set-key [(control next)]  'end-of-buffer)
(global-set-key [prior]           'pager-page-up)
(global-set-key [(control prior)] 'beginning-of-buffer)
(global-set-key [(meta v)]        'pager-page-up)

;; Hideshow mode
(require 'hideshow)

(global-set-key (kbd "s-<right>") 'hs-show-block)
(global-set-key (kbd "s-<left>")  'hs-hide-block)
(global-set-key (kbd "s-<up>")    'hs-hide-all)
(global-set-key (kbd "s-<down>")  'hs-show-all)

(defun maybe-turn-on-hs-mode ()
  (if (and (boundp 'comment-start)
           (boundp 'comment-end)
           comment-start comment-end
           (not (eq major-mode 'text-mode)))
      (hs-minor-mode)))

;(add-hook 'find-file-hooks 'maybe-turn-on-hs-mode)

(defun move-line (&optional n)
  "Move current line N (1) lines up/down leaving point in place."
  (interactive "p")
  (when (null n)
    (setq n 1))
  (let ((col (current-column)))
    (beginning-of-line)
    (next-line 1)
    (transpose-lines n)
    (previous-line 1)
    (forward-char col)))

(defun move-line-up (n)
  "Moves current line N (1) lines up leaving point in place."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Moves current line N (1) lines down leaving point in place."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (list (line-beginning-position)
         (line-beginning-position 2))))

(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Jump to start of the search when searching forward
(defun my-goto-match-beginning ()
  (when (and isearch-forward isearch-other-end)
    (goto-char isearch-other-end)))

(add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)

(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))

(define-key isearch-mode-map [(backspace)] 'isearch-del-char)
(define-key query-replace-map [return] 'act)

;; Wrap region
;; (require 'wrap-region)

;; AucTex
(load "auctex.el")
(load "preview-latex.el")
(require 'tex-mik)
(setq TeX-auto-save t
      TeX-parse-self t
      TeX-print-command "gsview32 %f"
      LaTeX-command "latex --enable-write18"
      TeX-PDF-mode t
      TeX-output-view-style (quote (("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "dvips %d -o && start \"\" %f") ("^dvi$" "." "yap -1 %dS %d") ("^pdf$" "." "gsview32 %o") ("^html?$" "." "start \"\" %o"))))

(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
(add-hook 'LaTeX-mode-hook
          (lambda()
            ;(flymake-mode)
            (LaTeX-math-mode)
            (define-key LaTeX-mode-map [return] 'reindent-then-newline-and-indent)))

;; Asymptote
(load "asy-init.el")

;; Dot mode
(require 'dot-mode)
(add-hook 'find-file-hooks 'dot-mode-on)
(dot-mode t)

;; Open recently visited files
(require 'recentf)
(recentf-mode t)
(setq recentf-max-saved-items 500)

;; Compilation settings
(defun compile-autoclose (buffer string)
  (cond ((and (string-match "finished" string)
              (not (string-match "warning" string)))
         (message "Build successful")
         (delete-window (get-buffer-window buffer t)))
        (t
         (message "Compilation exited abnormally: %s" string))))

(setq compilation-scroll-output t)
(setq compilation-window-height 15)
(setq compilation-finish-functions 'compile-autoclose)
(add-hook 'compilation-mode-hook (lambda () (next-error-follow-minor-mode)))

;; Occur
(add-hook 'occur-mode-hook (lambda () (next-error-follow-minor-mode)))

;; ElDoc
(eldoc-mode)

;; Intellectual indentation style auto-detecting
(require 'dtrt-indent)
(dtrt-indent-mode t)

(defun syntax-movements-bindings ()
  (local-set-key "\C-w" 'kill-syntax-backward)
  (local-set-key [(control backspace)] 'kill-syntax-backward)
  ;; (local-set-key "\C-d" 'kill-syntax-forward)
  (local-set-key "\M-f" 'next-syntax-boundary)
  (local-set-key "\M-b" 'prev-syntax-boundary)
  (local-set-key "\M-d" 'kill-syntax-forward))

;; CC settings
(setq c-tab-always-indent nil)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.inl\\'" . c++-mode))
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-style "stroustrup")
            (c-set-offset 'inline-open 0)
            (c-toggle-syntactic-indentation 1)
            (c-toggle-auto-hungry-state 1)
            (c-toggle-electric-state 1)
            (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\|XXX\\):" 1 font-lock-warning-face t)))
            (local-set-key (kbd "C-c o") 'ff-find-other-file)
            (syntax-movements-bindings)))

;; C sharp
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;; Slime
(require 'slime)
(slime-setup)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (syntax-movements-bindings)))

;; XML
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|csproj\\)\\'" . nxml-mode)
            auto-mode-alist))

;; Python settings
;; (setq ropemacs-loaded nil)
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (require 'pymacs)
;;             (when (not ropemacs-loaded)
;;               (pymacs-load "ropemacs" "rope-")
;;               (setq ropemacs-loaded t))
;;             (define-key python-mode-map [backspace] 'python-backspace)))

;; Lua settings
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))

;; Scheme settings
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Switch to interactive Scheme buffer." t)
(setq scheme-program-name "C:\\Development\\PLT\\MzScheme.exe")
(add-hook 'scheme-mode-hook
          '(lambda ()
             (define-key scheme-mode-map "\C-c\C-l"
               (lambda ()
                 (interactive)
                 (let ((file-name (buffer-file-name)))
                   (comint-check-source file-name)
                   (setq scheme-prev-l/c-dir/file (cons (file-name-directory    file-name)
                                                        (file-name-nondirectory file-name)))
                   (comint-send-string (scheme-proc) (concat "(load \""
                                                             file-name
                                                             "\"\)\n")))))))

;; Haskell
(autoload 'haskell-mode "haskell-site-file")
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; Ocaml
(load "ocaml/ocaml.emacs")

;; LilyPond
;;(load "lilypond-init")

;; Handy buffer switching
(require 'swbuff-y)
(swbuff-y-mode)
(setq swbuff-display-intermediate-buffers t)
(setq swbuff-delay-switch nil)
(setq swbuff-clear-delay 9)

(require 'misc-cmds)
(require 'wc)

;; Find file at point
;; (require 'ffap)
;; (ffap-bindings)
;; (setq ffap-require-prefix t)

;; Load CEDET
(load-file "~/emacs/cedet-1.0pre6/common/cedet.el")
(setq semanticdb-default-save-directory "~/backup")
(require 'semantic-complete)
(semantic-load-enable-code-helpers)

(setq senator-minor-mode-name "SN")
(setq semantic-imenu-auto-rebuild-directory-indexes nil)
(global-srecode-minor-mode 1)
(global-semantic-mru-bookmark-mode 1)
(require 'semantic-decorate-include)
(require 'semantic-ia)
(require 'eassist)

;; customisation of modes
(defun my-cedet-hook ()
  (local-set-key [(control meta return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key (kbd "M-m") 'eassist-list-methods)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\M-g"  'semantic-ia-fast-jump)
  (global-set-key "\M-g"  'semantic-ia-fast-jump)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))

(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'lisp-mode-hook 'my-cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'my-cedet-hook)

(custom-set-variables
 '(semantic-idle-scheduler-idle-time 1)
 '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
 '(global-semantic-tag-folding-mode t nil (semantic-util-modes)))
;(global-semantic-folding-mode 1)

(semantic-add-system-include "c:/dev/microsoft/Microsoft Visual Studio 9.0/VC/include" 'c++-mode)

;; dabbrev settings
(setq dabbrev-case-fold-search nil)

;; Yasnippet
(setq yas/next-field-key [(return)])
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/emacs/snippets")

;; Hippie expand settings
(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-expand-whole-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        senator-try-expand-semantic))

(defun my/yasnippet-p (ov)
  (overlay-get ov 'yas/snippet))

(defun my/do-inside-yasnippet-p ()
  (when (or (find-if 'my/yasnippet-p (overlays-at (point)))
            (find-if 'my/yasnippet-p (overlays-at (- (point) 1))))
    (yas/next-field-group)
    t))

(defadvice indent-according-to-mode (around indent-and-complete activate)
  (unless (my/do-inside-yasnippet-p)
    ;; indent-region
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      (progn
        ;; completing
        (when (looking-at "\\_>")
          (hippie-expand nil))
        ;; always indent line
        ad-do-it))))

(global-set-key [(tab)] 'indent-according-to-mode)

;; Ido
(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-enable-flex-matching nil)
(setq ido-max-prospects 6)
(setq ido-case-fold t)
(setq ido-use-filename-at-point nil)
(setq ido-use-url-at-point nil)
(setq ido-confirm-unique-completion t)

(add-to-list 'ido-ignore-buffers ".*\\.log")
(add-to-list 'ido-ignore-buffers ".*_flymake.*")
(add-to-list 'ido-ignore-buffers "_region_.tex")

(defun ido-execute ()
  (interactive)
  (call-interactively
   (intern
    (ido-completing-read
     "M-x "
     (let (cmd-list)
       (mapatoms (lambda (S) (when (commandp S) (setq cmd-list (cons (format "%S" S) cmd-list)))))
       cmd-list)))))

(global-set-key "\M-x" 'ido-execute)

(require 'w32-browser)

(defun ido-w32-browse ()
  (interactive)
  (w32-browser (ido-read-file-name "Open: ")))

(global-set-key [(super p)] 'ido-w32-browse)

(defun ido-goto-symbol ()
  "Will update the imenu index and then use ido to select a symbol to navigate to"
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (when (listp symbol)
                             (if (and (listp symbol) (imenu--subalist-p symbol))
                                 (addsymbols symbol)
                               (let ((name (car symbol)) (position (cdr symbol)))
                                 (unless (or (null position) (null name))
                                   (add-to-list 'symbol-names name)
                                   (add-to-list 'name-and-pos (cons name position))))))))))
      (addsymbols imenu--index-alist))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))

(defun ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (find-file (ido-completing-read "Open file: " recentf-list nil t)))

(require 'filecache)

(defun file-cache-add-this-file ()
  (and buffer-file-name
       (file-exists-p buffer-file-name)
       (file-cache-add-file buffer-file-name)))

;; (add-hook 'kill-buffer-hook 'file-cache-add-this-file)

(defun file-cache-add-files-from-file-dir ()
  (and buffer-file-name
       (file-exists-p buffer-file-name)
       (file-cache-add-directory (file-name-directory buffer-file-name))))

(add-hook 'find-file-hook 'file-cache-add-files-from-file-dir)

(defun file-cache-ido-find-file (file)
  "Using ido, interactively open file from file cache'.
First select a file, matched using ido-switch-buffer against the contents
in `file-cache-alist'. If the file exist in more than one
directory, select directory. Lastly the file is opened."
  (interactive (list (file-cache-ido-read "File: "
                                          (mapcar
                                           (lambda (x)
                                             (car x))
                                           file-cache-alist))))
  (let* ((record (assoc file file-cache-alist)))
    (find-file
     (expand-file-name
      file
      (if (= (length record) 2)
          (car (cdr record))
        (file-cache-ido-read
         (format "Find %s in dir: " file) (cdr record)))))))

(defun file-cache-ido-read (prompt choices)
  (let ((ido-make-buffer-list-hook
         (lambda ()
           (setq ido-temp-list choices))))
    (ido-read-buffer prompt)))

(eval-after-load
    "filecache"
  '(progn
     (message "Loading file cache...")
     (file-cache-add-directory-using-find "~/")))

;; VCS
(require 'git)
(autoload 'git-blame-mode "git-blame" "Minor mode for incremental blame for Git." t)
(autoload 'gitsum "gitsum" "Incremental git commit." t)

(require 'magit)
(add-hook 'magit-mode-hook
          (lambda ()
            (local-set-key [(tab)] 'magit-toggle-section)))

;; psvn
(setq svn-status-prefix-key '[(super n)])
(load "psvn")
(setq svn-status-hide-unknown t)
(setq svn-status-hide-unmodified t)

;; ECB
;; (setq ecb-layout-name "left7"
;;       ecb-tip-of-the-day nil
;;       ecb-windows-width 30
;;       ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))

;; (require 'ecb)
;; (ecb-activate)
;; (define-key ecb-mode-map "\C-c.d" 'ecb-dired-directory)

(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (ediff file1 file2)))

(add-to-list 'command-switch-alist '("diff" . command-line-diff))

(put 'dired-find-alternate-file 'disabled nil)
(setq dired-recursive-deletes 'top)
(setq dired-listing-switches "-alFsh --group-directories-first")
(add-hook 'dired-load-hook
          (lambda ()
            (require 'dired-x)
            (require 'ls-lisp)
            (require 'w32-browser)
            (define-key dired-mode-map [(backspace)] 'dired-up-directory)
            ;; (define-key dired-mode-map [(return)] 'dired-find-alternate-file)
            (define-key dired-mode-map [(backspace)] 'dired-up-directory)
            (define-key dired-mode-map "\C-xv" (lambda () (interactive) (vc-directory dired-directory dired-listing-switches)))
            (define-key dired-mode-map "\C-s" (lambda () (interactive) (goto-char (point-min)) (isearch-forward)))))

(setq ls-lisp-dirs-first t)
(setq ls-lisp-ignore-case t)

(defun dired-buffer-directory ()
  (interactive)
  (let ((name (buffer-file-name)))
    (when name
      (dired (file-name-directory name)))))

;; Browse the kill ring
(autoload 'browse-kill-ring "browse-kill-ring")

;; Smart compile
(autoload 'smart-compile "smart-compile")

;; Uniquify settings
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(autoload 'blank-mode           "blank-mode" "Toggle blank visualization."        t)
(autoload 'blank-toggle-options "blank-mode" "Toggle local `blank-mode' options." t)

(require 'htmlize)

(require 'marker-visit)
;; Enable useful disabled commands
(put 'narrow-to-region 'disabled nil)
(put 'erase-buffer 'disabled nil)

(defun dot-emacs ()
  "Visit .emacs"
  (interactive)
  (find-file "~/emacs/emacs.el"))

(defun switch-to-previous-buffer ()
  "Switch to previous buffer"
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun dos2unix ()
  "Convert a buffer from dos ^M end of lines to unix end of lines"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

(defun unix2dos ()
  "Convert a buffer from unix end of lines to dos ^M end of lines"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

(defun insert-date ()
  "Insert date at point"
  (interactive)
  (insert (format-time-string "%d.%m.%Y %H:%M")))

(defun ascii-table ()
  "Print the ascii table"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 32)
      (let ((j 0))
        (while (< j 8)
          (setq j (+ j 1))
          (let ((k (+ (* 8 i) j)))
            (insert (format "%6d %c" k k)))))
      (setq i (+ i 1))
      (insert "\n")))
  (goto-char (point-min)))

(defun autocompile ()
  "Compile itself if ~/.emacs"
  (interactive)
  (require 'bytecomp)
  (if (string= (downcase (buffer-file-name)) (downcase (expand-file-name "~/emacs/emacs.el")))
      (byte-compile-file (buffer-file-name))))

(add-hook 'after-save-hook 'autocompile)

(defun run-keywiz ()
  "Run keywiz"
  (interactive)
  (keywiz nil))

(defun fill-buffer ()
  "Fill each of the paragraphs in the buffer."
  (interactive)
  (let ((beg (point-min))
        (end (point-max)))
    (fill-region beg end)))

(defun kill-buffer-with-window ()
  (interactive)
  (if (one-window-p)
      (kill-this-buffer)
    (kill-buffer-and-window)))

(defun open-todo-list ()
  (interactive)
  (find-file-other-window "~/todo.org"))

(defun kill-compilation-window ()
  (interactive)
  (condition-case nil
      (kill-compilation)
    (error nil))
  (if (get-buffer "*compilation*")
      (progn
        (delete-windows-on (get-buffer "*compilation*"))
        (kill-buffer "*compilation*")))
  (if (get-buffer "*Compile-Log*")
      (progn
        (delete-windows-on (get-buffer "*Compile-Log*"))
        (kill-buffer "*Compile-Log*"))))

(defun zap-until-char (arg char)
  (interactive "p\ncZap until char: ")
  (if (char-table-p translation-table-for-input)
      (setq char (or (aref translation-table-for-input char) char)))
  (kill-region (point) (progn
                         (search-forward (char-to-string char) nil nil arg)
                         (backward-char)
                         (point))))

;; autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

;; behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (indent-according-to-mode))

;; behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

(defun isearch-forward-current-word-keep-offset ()
  "Mimic vi search foward at point feature."
  (interactive)
  (let ((re-curword) (curword) (offset (point))
        (old-case-fold-search case-fold-search) )
    (setq curword (thing-at-point 'symbol))
    (setq re-curword (concat "\\<" (thing-at-point 'symbol) "\\>") )
    (highlight-regexp re-curword 'isearch)
    (beginning-of-thing 'symbol)
    (setq offset (- offset (point))) ; offset from start of symbol/word
    (setq offset (- (length curword) offset)) ; offset from end
    (forward-char)
    (setq case-fold-search nil)
    (if (re-search-forward re-curword nil t)
        (backward-char offset)
      ;; else
      (progn (goto-char (point-min))
             (if (re-search-forward re-curword nil t)
                 (progn (message "Searching from top. %s" (what-line))
                        (backward-char offset))
               ;; else
               (message "Searching from top: Not found"))))
    (setq case-fold-search old-case-fold-search)))

(defun isearch-backward-current-word-keep-offset ()
  "Mimic vi search backwards at point feature."
  (interactive)
  (let ((re-curword) (curword) (offset (point))
        (old-case-fold-search case-fold-search) )
    (setq curword (thing-at-point 'symbol))
    (setq re-curword (concat "\\<" curword "\\>") )
    (highlight-regexp re-curword 'isearch)
    (beginning-of-thing 'symbol)
    (setq offset (- offset (point))) ; offset from start of symbol/word
    (forward-char)
    (setq case-fold-search nil)
    (if (re-search-backward re-curword nil t)
        (forward-char offset)
      ;; else
      (progn (goto-char (point-max))
             (if (re-search-backward re-curword nil t)
                 (progn (message "Searching from bottom. %s" (what-line))
                        (forward-char offset))
               ;; else
               (message "Searching from bottom: Not found"))))
    (setq case-fold-search old-case-fold-search)))

(defun occur-word-under-cursor ()
  (interactive)
  (let ((word (current-word)))
    (highlight-regexp word 'isearch)
    (occur word)))

(defun make-tags-table ()
  (interactive)
  (shell-command "etags *")
  (visit-tags-table "TAGS"))

;; for simulating Vi's % capability
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(")(forward-list 1)(backward-char 1))
        ((looking-at "\\s\)")(forward-char 1)(backward-list 1))
        (t (self-insert-command (or arg 1)))))

(global-set-key "%" 'match-paren)

(defun other-window-backward (&optional n)
  "Select Nth previous window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))

(defun my-join-line (&optional arg)
  (interactive "*P")
  (if arg
      (join-line)
    (join-line t)))

(defun recode-buffer-dangerous (target-coding-system)
  "* Recode buffer as if it were encoded with `target-coding-system'.
If current buffer is write-protected (`buffer-read-only'), temporarily toggle
read-only flag, recode, then turn it back."
  (interactive "zEnter target coding system: ")
  (labels ((do-recode nil
                      (encode-coding-region (point-min)
                                            (point-max)
                                            buffer-file-coding-system)
                      (decode-coding-region (point-min)
                                            (point-max)
                                            target-coding-system)
                      (set-buffer-file-coding-system target-coding-system)))
    (if buffer-read-only
        (let ((buffer-read-only nil))
          (do-recode)
          (set-buffer-modified-p nil))
      (do-recode))))

(defun my-comment-or-uncomment-region (arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not mark-active) (save-excursion (beginning-of-line) (not (looking-at "\\s-*$"))))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key (kbd "C-;") 'my-comment-or-uncomment-region)

(setq comment-style 'indent)

(defun scroll-one-line-up (&optional arg)
  "Scroll the selected window up (forward in the text) one line (or N lines)."
  (interactive "p")
  (scroll-up (or arg 1)))

(defun scroll-one-line-down (&optional arg)
  "Scroll the selected window down (backward in the text) one line (or N)."
  (interactive "p")
  (scroll-down (or arg 1)))

(defun my-mark-line ()
  (interactive)
  (beginning-of-line)
  (cua-set-mark)
  (end-of-line)
  (next-line)
  (beginning-of-line))

(defun invoke-make ()
  (interactive)
  (unless (or (file-exists-p "makefile")
              (file-exists-p "Makefile"))
    (set (make-local-variable 'compile-command)
         (concat "make -k "
                 (file-name-sans-extension buffer-file-name))))
  (compile compile-command))

(defun edit-makefile ()
  (interactive)
  (cond
   ((file-exists-p "makefile") (find-file "makefile"))
   ((file-exists-p "Makefile") (find-file "Makefile"))))

(defun next-syntax-boundary (&optional arg)
  (interactive "p")
  (if (< arg 0)
      (dotimes (n (abs arg))
        (let ((curpt (point)))
          (skip-syntax-backward (string (char-syntax (char-before))))
          (when (eq (point) curpt)
            (backward-char))))
    (dotimes (n arg)
      (let ((curpt (point)))
        (skip-syntax-forward (string (char-syntax (char-after))))
        (when (eq (point) curpt)
          (forward-char))))))

(defun prev-syntax-boundary (&optional arg)
  (interactive "p")
  (next-syntax-boundary (- (or arg 1))))

(defun kill-syntax-forward (&optional arg)
  (interactive "p")
  (kill-region (point) (progn (next-syntax-boundary arg) (point))))

(defun kill-syntax-backward (&optional arg)
  (interactive "p")
  (kill-region (point) (progn (prev-syntax-boundary arg) (point))))

(defun diff-buffer-with-associated-file ()
  "View the differences between BUFFER and its associated file.
This requires the external program \"diff\" to be in your `exec-path'.
Returns nil if no differences found, 't otherwise."
  (interactive)
  (let ((buf-filename buffer-file-name)
        (buffer (current-buffer)))
    (unless buf-filename
      (error "Buffer %s has no associated file" buffer))
    (let ((diff-buf (get-buffer-create
                     (concat "*Assoc file diff: "
                             (buffer-name)
                             "*"))))
      (with-current-buffer diff-buf
        (setq buffer-read-only nil)
        (erase-buffer))
      (let ((tempfile (make-temp-file "buffer-to-file-diff-")))
        (unwind-protect
            (progn
              (with-current-buffer buffer
                (write-region (point-min) (point-max) tempfile nil 'nomessage))
              (if (zerop
                   (apply #'call-process "diff" nil diff-buf nil
                          (append
                           (when (and (boundp 'ediff-custom-diff-options)
                                      (stringp ediff-custom-diff-options))
                             (list ediff-custom-diff-options))
                           (list buf-filename tempfile))))
                  (progn
                    (message "No differences found")
                    nil)
                (progn
                  (with-current-buffer diff-buf
                    (goto-char (point-min))
                    (if (fboundp 'diff-mode)
                        (diff-mode)
                      (fundamental-mode)))
                  (display-buffer diff-buf)
                  t)))
          (when (file-exists-p tempfile)
            (delete-file tempfile)))))))

;; tidy up diffs when closing the file
(defun kill-associated-diff-buf ()
  (let ((buf (get-buffer (concat "*Assoc file diff: "
                                 (buffer-name)
                                 "*"))))
    (when (bufferp buf)
      (kill-buffer buf))))

(add-hook 'kill-buffer-hook 'kill-associated-diff-buf)
(global-set-key (kbd "C-c d") 'diff-buffer-with-associated-file)
(global-set-key (kbd "C-c C-d") 'diff-buffer-with-associated-file)

(defun de-context-kill (arg)
  "Kill buffer, taking gnuclient into account."
  (interactive "p")
  (when (and (buffer-modified-p)
             buffer-file-name
             (not (string-match "\\*.*\\*" (buffer-name)))
             ;; erc buffers will be automatically saved
             (not (eq major-mode 'erc-mode))
             (= 1 arg))
    (let ((differences 't))
      (when (file-exists-p buffer-file-name)
        (setq differences (diff-buffer-with-associated-file)))
      (error (if differences
                 "Buffer has unsaved changes"
               "Buffer has unsaved changes, but no differences wrt. the file"))))
  (if (and (boundp 'gnuserv-minor-mode)
           gnuserv-minor-mode)
      (gnuserv-edit)
    (set-buffer-modified-p nil)
    (kill-buffer (current-buffer))))

(defun ido-context-kill-buffer ()
  (interactive)
  (ido-buffer-internal 'kill 'de-context-kill "Kill buffer: " (buffer-name (current-buffer)) nil 'ignore))

(defvar point-stack nil)

(defun point-stack-push ()
  "Push current location and buffer info onto stack."
  (interactive)
  (message "Location marked.")
  (setq point-stack (cons (list (current-buffer) (point)) point-stack)))

(defun point-stack-pop ()
  "Pop a location off the stack and move to buffer"
  (interactive)
  (if (null point-stack)
      (message "Stack is empty.")
    (switch-to-buffer (caar point-stack))
    (goto-char (cadar point-stack))
    (setq point-stack (cdr point-stack))))

(setq my-key-pairs
      '((?! ?1) (?@ ?2) (?# ?3) (?$ ?4) (?% ?5)
        (?^ ?6) (?& ?7) (?* ?8) (?( ?9) (?) ?0)
        (?{ ?[) (?} ?]) ; (?| ?\\) (?- ?_) (?\" ?')
        ))

(defun my-key-swap1 (key-pairs)
  (if (eq key-pairs nil)
      (message "Keyboard zapped!! Shift-F10 to restore!")
    (progn
      (keyboard-translate (caar key-pairs)  (cadar key-pairs))
      (keyboard-translate (cadar key-pairs) (caar key-pairs))
      (my-key-swap1 (cdr key-pairs)))))

(defun my-key-swap ()
  (interactive)
  (my-key-swap1 my-key-pairs))

(defun my-key-restore1 (key-pairs)
  (if (eq key-pairs nil)
      (message "Keyboard restored!! F10 to Zap!")
    (progn
      (keyboard-translate (caar key-pairs)  (caar key-pairs))
      (keyboard-translate (cadar key-pairs) (cadar key-pairs))
      (my-key-restore1 (cdr key-pairs)))))

(defun my-key-restore ()
  (interactive)
  (my-key-restore1 my-key-pairs))

(semantic-add-system-include "c:/work/src/include" 'c++-mode)
(semantic-add-system-include "c:/work/src/areator/source/include" 'c++-mode)
(semantic-add-system-include "c:/dev/microsoft/Microsoft Visual Studio 9.0/VC/include" 'c++-mode)
(semantic-add-system-include "c:/Program Files/Microsoft SDKs/Windows/v6.0A/Include" 'c++-mode)

(defun areator ()
  (interactive)
  (file-cache-add-directory-recursively "c:/work/src/Include")
  (file-cache-add-directory-recursively "c:/work/src/Areator/Source")

  (setq areator-projects
        (apply 'append
               '("SensorDV" "VisExport" "HeightSensor" "Areator" "Areator.UserData")
               (mapcar (lambda (arg) (list (concat arg "G") (concat arg "DV")))
                       '("CoastLine" "Contours" "ProcObjects" "RmContours" "TopoData"
                         "Triangulator" "Terrain" "AIData" "Chart"))))

  (sort areator-projects 'string-lessp)

  (defun areator-set-config ()
    (interactive)
    (setq areator-config
          (ido-completing-read "Build configuration: " '("Debug" "Release"))))

  (defun areator-build ()
    (interactive)
    (let ((compile-cmd (concat "devenv.com c:/work/src/Areator/Areator.sln /build " areator-config)))
      (compile compile-cmd)))

  (defun areator-build-project (proj)
    (interactive)
    (let ((compile-cmd (concat "devenv.com c:/work/src/Areator/Areator.sln /build " areator-config " /project " proj)))
      (compile compile-cmd)))

  (setq areator-find-string
        (concat "find c:/work/src/Include c:/work/src/Areator "
                "-type f ( -iname \"*.cpp\" -o -iname \"*.h\" -o -iname \"*.cs\" -o -iname \"*.inl\" \) "))

  (defun areator-tags ()
    (interactive)
    (shell-command (concat areator-find-string " | etags -f c:/work/src/TAGS -"))
    (visit-tags-table "c:/work/src/TAGS"))

  (defun areator-hook ()
    (interactive)
    (local-set-key [f7] (lambda () (interactive) (areator-build-project areator-project)))
    (local-set-key [f8] (lambda () (interactive) (magit-status "c:/work/src")))
    (local-set-key [(control shift d)]
                   (lambda ()
                     (interactive)
                     (setq areator-config "Debug")
                     (message "Debug configuration set")))
    (local-set-key [(control shift r)]
                   (lambda ()
                     (interactive)
                     (setq areator-config "Release")
                     (message "Release configuration set")))
    (local-set-key [(control shift p)]
                   (lambda ()
                     (interactive)
                     (setq areator-project
                           (ido-completing-read "Current project: " areator-projects))))
    (local-set-key [(control shift f)]
                   (lambda (arg)
                     (interactive "sFind string: ")
                     (grep-find
                      (concat areator-find-string " -print0 | xargs -0 grep -in \"" arg "\"")))))

  (add-hook 'c-mode-common-hook 'areator-hook t))

;;(global-set-key [(alt k)] 'my-mark-line)

;; Functional keys
(global-set-key [f1] 'other-window)
(global-set-key [(shift f1)] 'other-window-backward)
(global-set-key [f3] 'isearch-forward-current-word-keep-offset)
;(global-set-key [f3] (lambda () (interactive) (isearch-mode t (current-word))))
(global-set-key [(shift f3)] 'isearch-backward-current-word-keep-offset)
(global-set-key [(meta f3)] 'occur-word-under-cursor)
(global-set-key [f4] 'file-cache-ido-find-file)
(global-set-key [(meta f4)] 'ido-choose-from-recentf)
(global-set-key [(control f4)] 'recentf-open-files)
(global-set-key [f5] (lambda ()
                       (interactive)
                       (shell-command (file-name-sans-extension buffer-file-name) "*Shell Command Output*")))
(global-set-key [f6] 'next-error)
(global-set-key [(shift f6)] 'previous-error)
(global-set-key [(control f6)] 'previous-error)
(global-set-key [f7] 'invoke-make)
(global-set-key [(control f7)] 'kill-compilation-window)
(global-set-key [(meta f7)] 'edit-makefile)
(global-set-key [f9] 'bookmark-jump)
(global-set-key [(control f9)] 'bookmark-set)
(global-set-key [f10] 'point-stack-push)
(global-set-key [(control f10)] 'point-stack-pop)
(global-set-key [f11] 'open-todo-list)

(autoload 'shell-toggle "shell-toggle")
(autoload 'shell-toggle-cd "shell-toggle")
(global-set-key [f12] 'shell-toggle-cd)
(global-set-key [(control f12)] 'shell-toggle)

;; http://www.kuro5hin.org/story/2003/4/1/21741/10470
;; http://www.emacswiki.org/cgi-bin/emacs-en/WThirtyTwoDev

;; Various keybindings
;; (global-set-key "\C-h" 'backward-delete-char-untabify)
;; (define-key isearch-mode-map "\C-h" 'isearch-delete-char)
;; (global-set-key [(super h)] 'help-command)

(require 'rect-mark)
(add-hook 'picture-mode-hook 'rm-example-picture-mode-bindings)

(global-set-key (kbd "C-x r <down-mouse-1>") 'rm-mouse-drag-region)
(global-set-key (kbd "C-x r C-x") 'rm-exchange-point-and-mark)
(global-set-key (kbd "C-x r C-SPC") 'rm-set-mark)
(global-set-key (kbd "C-x C-k")
                '(lambda(b e) (interactive "r")
                   (if rm-mark-active
                       (rm-kill-region b e) (kill-region b e))))
(global-set-key (kbd "M-w")
                '(lambda(b e) (interactive "r")
                   (if rm-mark-active
                       (rm-kill-ring-save b e) (kill-ring-save b e))))
(global-set-key (kbd "C-x C-x")
                '(lambda(&optional p) (interactive "p")
                   (if rm-mark-active
                       (rm-exchange-point-and-mark p) (exchange-point-and-mark p))))

(global-set-key [(control return)] 'open-previous-line)
(global-set-key [(control shift return)] 'open-next-line)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-a" 'beginning-or-indentation)
(global-set-key [(home)] 'beginning-or-indentation)
(global-set-key "\C-e" 'end-of-line+)
(global-set-key [(end)] 'end-of-line+)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-x\C-b" 'ibuffer)
(global-set-key "\C-xb" 'ibuffer)
(global-set-key "\C-\M-j" 'my-join-line)
(global-set-key "\C-z" 'zap-until-char)

;; (my-key-swap)
(global-set-key (kbd "C-x !") 'delete-other-windows)

;; (require 'buffer-stack)
;; (global-set-key [(ctrl tab)] 'buffer-stack-bury)
(global-set-key [(shift tab)] 'ido-switch-buffer)

(global-set-key "\M-+" '(lambda() (interactive) (shrink-window -1)))
(global-set-key "\M--" '(lambda() (interactive) (shrink-window 1)))

(global-set-key "\M-[" 'backward-paragraph)
(global-set-key "\M-]" 'forward-paragraph)

(global-set-key "\M-k" 'kill-buffer-with-window)
(global-set-key [(meta ?`)] 'dot-emacs)
(global-set-key "\C-x\C-d" 'dired-buffer-directory)

;; Faster point movement
(global-set-key "\M-\C-p" '(lambda () (interactive) (previous-line 5)))
(global-set-key "\M-\C-n" '(lambda () (interactive) (next-line 5)))

(global-set-key [(super s)] '(lambda () (interactive) (switch-to-buffer "*scratch*")))

;; (global-set-key [C-up]  'scroll-one-line-down)
;; (global-set-key [C-down] 'scroll-one-line-up)
(global-set-key [(control up)] 'move-line-up)
(global-set-key [(control down)] 'move-line-down)

(global-set-key [(ctrl shift left)] 'winring-prev-configuration)
(global-set-key [(ctrl shift right)] 'winring-next-configuration)

(global-set-key [(shift prior)] 'previous-multiframe-window)
(global-set-key [(shift next)] 'next-multiframe-window)

(global-set-key [(control prior)] 'previous-multiframe-window)
(global-set-key [(control next)] 'next-multiframe-window)

(global-set-key [(control return)] 'semantic-complete-jump)

(require 'nav)
(global-set-key "\C-\M-l" 'nav)

(defalias 'igs 'ido-goto-symbol)
(defalias 'ff 'find-function)

(defun my-done ()
  (interactive)
  (server-edit)
  (make-frame-invisible nil t))

(global-set-key (kbd "C-x C-c") 'my-done)

(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; Restore desktop state
(require 'desktop)
(desktop-save-mode 1)
(desktop-read)

(setq debug-on-error nil)
