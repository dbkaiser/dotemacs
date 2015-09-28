;; init file for emacs
;; dongbo

;;melpa
(require 'package)
(add-to-list 'package-archives
  '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; custom scripts
(add-to-list 'load-path "~/.emacs.d/mylisp/")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(setq el-get-user-package-directory "~/.emacs.d/el-get-user")

;; some packages requires elpa and emacswiki
(setq my-packages 
      '(
	cl-lib  ;; this is required by yasnippet etc. of later version
	php-mode
	ascii
	el-get
	emacs-w3m
	wc-mode
	org-mode
	json-mode ;; json mode
	markdown-mode
	auto-complete
	auto-complete-emacs-lisp
	yasnippet
	cedet
	erc
	doxymacs
	yaml-mode
	golden-ratio
	color-theme
	simplenote
	ac-octave
	echoline-mode
;	header2 ;;this will be moved as self specified script
	pymacs   ;; required by ropmacs
	ropemacs ;; require hg to install ;; it's a little tricky. for the rope and ropemacs are written in python , so we need to install them firstly by running python setup.py in relevant directories. then written certain configurations as down below
	magit ;;for git operation 
	graphviz-dot-mode
;	jdee  ;; attention: this might require you to change the recipt file to another svn repo
	geben
	hl-line+
	malabar-mode
	psvn
	jekyll-el ;; for sth of jekyll.
        ))

(el-get 'sync my-packages)

; somegthing is wrong with el-get for jdee. so put it manually.
;(add-to-list 'load-path "~/.emacs.d/third-party/jdee-2.4.1/lisp")
;(load "jde")

;; cedet config
;; mode config
(require 'semantic)
(global-ede-mode t)                      ; Enable the Project management system
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)           ; enable start completion jump
(semantic-load-enable-gaudy-code-helpers)      ; Enable prototype help and smart completion and function start prompt
(global-srecode-minor-mode 1)            ; Enable template insertion menu

;; cscope config
(require 'xcscope)

;; format config
;; set the window patterns
(show-paren-mode t)
;; set the tab width
(setq tab-width 4)
(setq default-tab-width 4)
(setq c-default-style "linux" 
	  c-basic-offset 4)
;; ido mode
(ido-mode t)


;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
;(global-set-key (kbd "C-c h") 'helm-command-prefix)
;(global-unset-key (kbd "C-x c"))

;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
;(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
;(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;(when (executable-find "curl")
;n  (setq helm-google-suggest-use-curl-p t))

;(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
;      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
;      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
;      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
;      helm-ff-file-name-history-use-recentf t)
;(helm-mode 1)

;; auto mode
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)) ;; yaml
(add-to-list 'auto-mode-alist '("\\.bash_alias" . sh-mode)) ;; shell
(add-to-list 'auto-mode-alist '("\\.m" . octave-mode)) ;; shell
;; php
(add-to-list 'auto-mode-alist
	     '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.proto\\'" . c-mode))

;;markdown
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode)) ;; md file
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode)) ;; markdown file

;; blog jekyll things
(require 'jekylldk)

;; key config
;; avoid c-space 
(global-set-key (kbd "C-SPC") 'nil)

;; doxygen mode
(add-hook 'c-mode-common-hook 'doxymacs-mode)

;;yasnippet mode
(yas-global-mode 1)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; golden ratio mode
(golden-ratio-mode 0)

;; higlight current line
(hl-line-toggle-when-idle 1)
;(hl-line-mode t)
;(set-face-background hl-line-face "green")


;; themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; temperarily use this theme
;;(color-theme-aalto-light)

;; simplenote
(require 'simplenote)
(setq simplenote-email "dbkaiser@gmail.com")
(setq simplenote-password nil);; so will ask pwd
(simplenote-setup)

;; auto-header 
(require 'header2)
(autoload 'auto-update-file-header "header2")
(autoload 'auto-make-header "header2")
(add-hook 'write-file-hooks 'auto-update-file-header)
(add-hook 'emacs-lisp-mode-hook 'auto-make-header)
;(add-hook 'c-mode-common-hook   'auto-make-header)
(add-hook 'c-mode-hook   'auto-make-header)
(add-hook 'c++-mode-hook   'auto-make-header)
(add-hook 'awk-mode-hook   'auto-make-header)
(add-hook 'python-mode-hook   'auto-make-header)
(add-hook 'sh-mode-hook   'auto-make-header)


;; rope emacs configurations


;; android mode setting
;;(require 'cl-lib)
;;(require 'android-mode)
;;(defcustom android-mode-sdk-dir "~/tool/android-sdks")

;;===========================
;; self coding lisp
;(require 'my)
(load "~/.emacs.d/mylisp/my.el")

;; quick mode for loading emacs configure file
;; TODO 

;;;; FONTS
(if (eq system-type 'darwin) 
	(progn 
	  (set-language-environment 'UTF-8)
	  (set-locale-environment "UTF-8")
	  (set-default-font "Dejavu Mono 16")
	  (if (and (fboundp 'daemonp) (daemonp))
		  (add-hook 'after-make-frame-functions
					(lambda (frame)
					  (with-selected-frame frame
						(set-fontset-font "fontset-default"
										  'unicode "黑体 16"))))
		(set-fontset-font "fontset-default" 'unicode "黑体 16")))
)
(setq org-src-fontify-natively t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("eb8701083acffcb4ae592fb78f236b3d5f62cdc841e2b83cefbbfdd4126f205c" default)))
 '(org-agenda-files (quote ("~/workspace/docs/todo.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
