((ac-octave status "installed" recipe
	    (:name ac-octave :type emacswiki :description "octave completions support for auto-complete" :autoloads t))
 (android-mode status "removed" recipe nil)
 (ascii status "installed" recipe
	(:name ascii :auto-generated t :type emacswiki :description "ASCII code display." :website "https://raw.github.com/emacsmirror/emacswiki.org/master/ascii.el"))
 (auto-complete status "installed" recipe
		(:name auto-complete :website "http://auto-complete.org/" :description "The most intelligent auto-completion extension." :type github :pkgname "auto-complete/auto-complete" :depends
		       (popup fuzzy)))
 (auto-complete-emacs-lisp status "installed" recipe
			   (:name auto-complete-emacs-lisp :description "Auto-complete sources for emacs lisp" :type http :url "http://www.cx4a.org/pub/auto-complete-emacs-lisp.el" :depends auto-complete))
 (cedet status "installed" recipe
	(:name cedet :website "http://cedet.sourceforge.net/" :description "CEDET is a Collection of Emacs Development Environment Tools written with the end goal of creating an advanced development environment in Emacs." :type git :url "http://git.randomsample.de/cedet.git" :build
	       `(("sh" "-c" "touch `find . -name Makefile`")
		 ("make" ,(format "EMACS=%s"
				  (shell-quote-argument el-get-emacs))))
	       :build/berkeley-unix
	       `(("sh" "-c" "touch `find . -name Makefile`")
		 ("gmake" ,(format "EMACS=%s"
				   (shell-quote-argument el-get-emacs))))
	       :build/windows-nt
	       ("echo #!/bin/sh > tmp.sh & echo touch `/usr/bin/find . -name Makefile` >> tmp.sh & echo make FIND=/usr/bin/find >> tmp.sh" "sed 's/^M$//' tmp.sh  > tmp2.sh" "sh ./tmp2.sh" "rm ./tmp.sh ./tmp2.sh")
	       :features nil :lazy nil :post-init
	       (unless
		   (featurep 'cedet-devel-load)
		 (load
		  (expand-file-name "cedet-devel-load.el" pdir)))))
 (cl-lib status "removed" recipe nil)
 (color-theme status "installed" recipe
	      (:name color-theme :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme" :website "http://www.nongnu.org/color-theme/" :type http-tar :options
		     ("xzf")
		     :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz" :load "color-theme.el" :features "color-theme" :post-init
		     (progn
		       (color-theme-initialize)
		       (setq color-theme-is-global t))))
 (doxymacs status "installed" recipe
	   (:name doxymacs :website "http://doxymacs.sourceforge.net/" :description "Doxymacs is Doxygen + {X}Emacs." :type git :url "git://doxymacs.git.sourceforge.net/gitroot/doxymacs/doxymacs" :load-path
		  ("./lisp")
		  :build
		  ("./bootstrap" "./configure" "make")
		  :features doxymacs))
 (echoline-mode status "installed" recipe
		(:name echoline-mode :auto-generated t :type emacswiki :description "A minor mode for octave which highlights " echoing " lines" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/echoline-mode.el"))
 (ediff+ status "installed" recipe
	 (:name ediff+ :auto-generated t :type emacswiki :description "Enhancements to Ediff" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/ediff+.el"))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :features el-get :info "." :load "el-get.el"))
 (emacs-w3m status "installed" recipe
	    (:name emacs-w3m :description "A simple Emacs interface to w3m" :type cvs :module "emacs-w3m" :url ":pserver:anonymous@cvs.namazu.org:/storage/cvsroot" :build
		   `("autoconf"
		     ("./configure" ,(concat "--with-emacs=" el-get-emacs))
		     "make")
		   :build/windows-nt
		   ("sh /usr/bin/autoconf" "sh ./configure" "make")
		   :info "doc"))
 (erc status "installed" recipe
      (:name erc :description "A powerful, modular, and extensible Emacs InternetRelayChat client." :type elpa))
 (fuzzy status "installed" recipe
	(:name fuzzy :website "https://github.com/auto-complete/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "auto-complete/fuzzy-el"))
 (golden-ratio status "installed" recipe
	       (:name golden-ratio :website "https://github.com/roman/golden-ratio.el" :description "Automatically resizes the windows you are working on to the size specified in the Golden Ratio." :type github :pkgname "roman/golden-ratio.el"))
 (header2 status "installed" recipe
	  (:name header2 :description "Support for creation and update of file headers." :type emacswiki :features "header2"))
 (jekyll-el status "installed" recipe
	    (:name jekyll-el :description "Jekyll Integration for emacs" :type github :pkgname "diasjorge/jekyll.el" :load-path
		   (".")
		   :features jekyll))
 (markdown-mode status "installed" recipe
		(:name markdown-mode :description "Major mode to edit Markdown files in Emacs" :type git :url "git://jblevins.org/git/markdown-mode.git" :post-init
		       (add-to-list 'auto-mode-alist
				    '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))))
 (matlab-mode status "installed" recipe
	      (:name matlab-mode :description "Major mode for MATLAB(R) dot-m files" :type cvs :module "matlab-emacs" :url ":pserver:anonymous@matlab-emacs.cvs.sourceforge.net:/cvsroot/matlab-emacs" :depends cedet :build
		     ("make")
		     :load-path
		     (".")
		     :features matlab-load))
 (org status "installed" recipe
      (:name org :auto-generated t :type elpa :description "Outline-based notes management and organizer"))
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin 24 :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
		 (progn
		   (setq package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))
			 package-directory-list
			 (list
			  (file-name-as-directory package-user-dir)
			  "/usr/share/emacs/site-lisp/elpa/"))
		   (make-directory package-user-dir t)
		   (unless
		       (boundp 'package-subdirectory-regexp)
		     (defconst package-subdirectory-regexp "^\\([^.].*\\)-\\([0-9]+\\(?:[.][0-9]+\\)*\\)$" "Regular expression matching the name of\n a package subdirectory. The first subexpression is the package\n name. The second subexpression is the version string."))
		   (setq package-archives
			 '(("ELPA" . "http://tromey.com/elpa/")
			   ("gnu" . "http://elpa.gnu.org/packages/")
			   ("marmalade" . "http://marmalade-repo.org/packages/")
			   ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (php-mode status "installed" recipe
	   (:name php-mode :description "A PHP mode for GNU Emacs " :type github :pkgname ejmr/php-mode :website "https://github.com/ejmr/php-mode"))
 (popup status "installed" recipe
	(:name popup :website "https://github.com/auto-complete/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :pkgname "auto-complete/popup-el"))
 (rope status "installed" recipe
       (:name rope :description "A python refactoring library" :post-init
	      (el-get-envpath-prepend "PYTHONPATH" default-directory)
	      :type hg :url "http://bitbucket.org/agr/rope"))
 (ropemacs status "installed" recipe
	   (:name ropemacs :description "An Emacs minor mode for using rope python refactoring library in emacs." :post-init
		  (progn
		    (unless
			(boundp 'pymacs-load-path)
		      (setq pymacs-load-path nil))
		    (add-to-list 'pymacs-load-path default-directory))
		  :depends
		  (rope ropemode)
		  :type hg :url "http://bitbucket.org/agr/ropemacs"))
 (ropemode status "installed" recipe
	   (:name ropemode :description "Common parts of ropemacs and ropevim." :post-init
		  (progn
		    (unless
			(boundp 'pymacs-load-path)
		      (setq pymacs-load-path nil))
		    (add-to-list 'pymacs-load-path default-directory))
		  :type hg :url "http://bitbucket.org/agr/ropemode"))
 (simplenote status "installed" recipe
	     (:name simplenote :website "https://github.com/cefstat/simplenote.el#readme" :description "Helper functions for simple-note.appspot.com" :type github :pkgname "cefstat/simplenote.el" :features simplenote :load "simplenote.el" :compile "simplenote.el" :post-init
		    (simplenote-setup)))
 (wc-mode status "installed" recipe
	  (:name wc-mode :auto-generated t :type emacswiki :description "show wc-like information in status bar" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/wc-mode.el"))
 (yaml-mode status "installed" recipe
	    (:name yaml-mode :description "Simple major mode to edit YAML file for emacs" :type github :pkgname "yoshiki/yaml-mode" :prepare
		   (progn
		     (autoload 'yaml-mode "yaml-mode" nil t)
		     (add-to-list 'auto-mode-alist
				  '("\\.ya?ml\\'" . yaml-mode)))))
 (yasnippet status "installed" recipe
	    (:name yasnippet :website "https://github.com/capitaomorte/yasnippet.git" :description "YASnippet is a template system for Emacs." :type github :pkgname "capitaomorte/yasnippet" :features "yasnippet" :pre-init
		   (unless
		       (or
			(boundp 'yas/snippet-dirs)
			(get 'yas/snippet-dirs 'customized-value))
		     (setq yas/snippet-dirs
			   (list
			    (concat el-get-dir
				    (file-name-as-directory "yasnippet")
				    "snippets"))))
		   :post-init
		   (put 'yas/snippet-dirs 'standard-value
			(list
			 (list 'quote
			       (list
				(concat el-get-dir
					(file-name-as-directory "yasnippet")
					"snippets")))))
		   :compile nil :submodule nil)))
