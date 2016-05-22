(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

;; set local recipes, el-get-sources should only accept PLIST element
(setq
 el-get-sources
 '((:name buffer-move			; have to add your own keys
	  :after (progn
		   (global-set-key (kbd "<C-S-up>")     'buf-move-up)
		   (global-set-key (kbd "<C-S-down>")   'buf-move-down)
		   (global-set-key (kbd "<C-S-left>")   'buf-move-left)
		   (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

   (:name smex				; a better (ido like) M-x
	  :after (progn
		   (setq smex-save-file "~/.emacs.d/.smex-items")
		   (global-set-key (kbd "M-x") 'smex)
		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

;   (:name magit				; git meet emacs, and a binding
;	  :after (progn
;		   (global-set-key (kbd "C-x C-z") 'magit-status)))

   (:name goto-last-change		; move pointer back to last change
	  :after (progn
		   ;; when using AZERTY keyboard, consider C-x C-_
		   (global-set-key (kbd "C-x C-/") 'goto-last-change)))))

;; now set our own packages
(setq
 my:el-get-packages
 '(el-get				; el-get is self-hosting
   escreen            			; screen for emacs, C-\ C-h
   php-mode-improved			; if you're into php...
   switch-window			; takes over C-x o
   auto-complete			; complete as you type with overlays
   zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
   color-theme		                ; nice looking emacs
   color-theme-tango))	                ; check out color-theme-solarized

;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;

(when (el-get-executable-find "svn")
  (loop for p in '(psvn    		; M-x svn-status
		   yasnippet		; powerful snippet mode
		   )
	do (add-to-list 'my:el-get-packages p)))

(setq my:el-get-packages
      (append my:el-get-packages
              (mapcar #'el-get-source-name el-get-sources)))

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)

;from here is my configuration
(set-language-environment 'Chinese-GB)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

;;----------windows--style---
(set-foreground-color "gray")
(set-background-color "black")
(set-cursor-color "gold1")
(set-mouse-color "gold1")

;; erase scroll bar
;(set-scroll-bar-mode nil)

;;
;;(tool-bar-mode nil)

(setq default-frame-alist
      '((vertical-scroll-bars)
	(top . 25)
	(left . 45)
	(width . 142)
	(height . 49)
	(background-color . "black")
	(foreground-color . "grey")
	(cursor-color . "gold1")
	(mouse-color . "gold1")
	(tool-bar-lines . 0)
	(menu-bar-lines . 1)
	(right-fringe)
	(left-fringe)))


;; syntax highlight
(set-face-foreground 'highlight "white")
(set-face-background 'highlight "blue")
(set-face-foreground 'region "cyan")
(set-face-background 'region "blue")
(set-face-foreground 'secondary-selection "skyblue")
(set-face-background 'secondary-selection "darkblue")


;; time
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-use-mail-icon t)
(setq display-time-interval 10)

;; pwd
(setq default-directory "~/")
(ido-mode t)

;; shutdown bell when an error happens
(setq visible-bell nil)

(setq inhibit-startup-message t)


(setq font-lock-maximum-decoration t)
(setq font-lock-global-modes '(not shell-mode text-mode))
(setq font-lock-verbose t)
(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))

;; display line number
(setq column-number-mode t)
(setq line-number-mode t)
(global-linum-mode t)

(setq mouse-yank-at-point t)

;; set tab width
(setq-default auto-fill-function 'do-auto-fill)
(setq default-tab-width 4)
(setq tab-stop-list ())
(setq tab-width 4
indent-tabs-mode t
c-basic-offset 4)

;; about parenthesis such as ()
(show-paren-mode t)
(setq show-paren-style 'parenthesis)

;; let emacs open picture
(setq auto-image-file-mode t)

(setq global-font-lock-mode t)

;; no backup
(setq make-backup-files nil)

(setq-default make-backup-file nil)

(put 'scroll-left 'disabled nil) 
(put 'scroll-right 'disabled nil) 
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)

(setq x-select-enable-clipboard t)

(setq user-full-name "bracken")
(setq user-mail-address "brackenbo@hotmail.com")

(setq require-final-newline t)

(setq track-eol t)

(defun du-onekey-compile ()
  "Save buffers and start compile"
  (interactive)
  (save-some-buffers t)
  (switch-to-buffer-other-window "*compilation*")
  (compile compile-command))
  (global-set-key [C-f5] 'compile)
  (global-set-key [f5] 'du-onekey-compile)

(global-set-key [f6] 'gdb)

;; alt-g goto-line 
(global-set-key (kbd "M-g") 'goto-line)

(setq calendar-load-hook
'(lambda ()
(set-face-foreground 'diary-face "skyblue")
(set-face-background 'holiday-face "slate blue")
(set-face-foreground 'holiday-face "white")))

(setq calendar-latitude +39.54)
(setq calendar-longitude +116.28)
(setq calendar-location-name "±±¾©")


(load-library "hideshow")
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'php-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)


;; very userful paren auto-pair () [] {}
(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist '(
    (?` ?` _ "''")
    (?\(? _ ")")
    (?\[? _ "]")
    (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-c-mode-auto-pair) 

(add-hook 'c-mode-hook
'(lambda ()
(c-set-style "k&r")))


(setq py-install-directory "~/python_app/flask_learn/python-mode-master")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/markdown-mode/")  
(autoload 'markdown-mode "markdown-mode.el"  
"Major mode for editing Markdown files" t)  
(setq auto-mode-alist  
(cons '(".markdown" . markdown-mode) auto-mode-alist))


;; After js2 has parsed a js file, we look for jslint globals decl comment ("/* global Fred, _, Harry */") and
    ;; add any symbols to a buffer-local var of acceptable global vars
    ;; Note that we also support the "symbol: true" way of specifying names via a hack (remove any ":true"
    ;; to make it look like a plain decl, and any ':false' are left behind so they'll effectively be ignored as
    ;; you can;t have a symbol called "someName:false"
    (add-hook 'js2-post-parse-callbacks
              (lambda ()
                (when (> (buffer-size) 0)
                  (let ((btext (replace-regexp-in-string
                                ": *true" " "
                                (replace-regexp-in-string "[\n\t ]+" " " (buffer-substring-no-properties 1 (buffer-size)) t t))))
                    (mapc (apply-partially 'add-to-list 'js2-additional-externs)
                          (split-string
                           (if (string-match "/\\* *global *\\(.*?\\) *\\*/" btext) (match-string-no-properties 1 btext) "")
                           " *, *" t))
                    ))))
