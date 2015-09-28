;; fancy grep functions from ahei

(defun find-grep-in-dir (arg)
  "Run `find-grep' in directory DIR."
  (interactive (list (ido-read-directory-name "Directory to find in: " default-directory "" t)))
  (let ((prompting (concat "find " arg " -type f ! -path \"*/.svn*\" ! -path \"*~\" ! -path \"cscope*\" -path \"*.php\" -print0 | xargs -0 -e grep -nH -e ")))
    (set-grep-command prompting)
    (call-interactively 'find-grep)
	(setq grep-host-defaults-alist nil))); this REALLY SUCKS!! why do i should have use this!!!

;;;###autoload
(defun find-grep-in-current-dir (dir)
  "Run `find-grep' in current directory."
  (find-grep-in-dir default-directory))

;;;###autoload
(defun find-grep-current-word (dir &optional is-prompt)
  "Run `grep' to find current word in directory DIR."
  (interactive
   (list
    (read-directory-name "Directory to grep in: " default-directory "" t)
    current-prefix-arg))
  (set-grep-command   (concat "find " dir " -type f ! -path \"*/.svn*\" ! -path \"*~\" -print0 | xargs -0 -e grep -nH -e "))
  (let* ((word (current-word)) command-args)
    (if (not word)
        (message "No word under cursor.")
      (setq command-args
            (if grep-find-command
                (concat grep-find-command word)
              (concat grep-command word " " dir "/*")))
      (if is-prompt
          (grep (read-shell-command "Run grep (like this): " command-args 'grep-history))
        (grep command-args))))
  )

;;;###autoload
(defun find-grep-current-word-in-current-dir (&optional is-prompt)
  "Run `grep' to find current word in directory DIR."
  (interactive "P")
  (find-grep-current-word default-directory is-prompt))

;; for code jump 
(defun find-tag-current-word ()
  "Find the current word without any prompting"
  (interactive)
  (let* ((word (current-word))) 
	(if (not word)
		(message "No word under cursor.")
	  (find-tag word))))

(defun set-grep-command (command)
  "Set `grep-command'."
  (setq grep-find-command command))

; Blog saving function
(defun save-blog-today ()
  "Save the current buffer as the blog on dropbox disk with the current date as the name"
  (interactive
   (write-file (concat "~/Dropbox/blog/" (format-time-string "%Y%m%d" t1) ".org"))
   )
)

; Quick open todo file
(defun open-todo-file ()
  "Open the todo file"
  (interactive)
  (find-file "~/Dropbox/Ubuntu/todo.org")
)

;; Quick open init emacs file
(defun open-init-file ()
  "Open the emacs default config file"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; Quick open this file 
(defun open-my-el-file ()
  "Open this file to edit"
  (interactive) 
  (find-file "~/.emacs.d/mylisp/my.el"))


;; self defined functions

(defun call-current-songid()
  "Call the current link with google chrome"
  (interactive)
  (setq myStr (thing-at-point 'symbol))
  (message myStr)
  (shell-command (concat "google-chrome \"http://play.baidu.com/?__m=mboxCtrl.playSong&__a=" myStr "\""))
)

(defun search-current-line-in-baidu-music()
  "Search current line by baidu music"
  (interactive)
  (setq myStr (thing-at-point 'line))
  (when (string-match "[ \t\n]*" myStr)
	(setq myStr (replace-match "+" nil nil myStr))
  )
  (shell-command (concat "google-chrome \"http://music.baidu.com/search?key=" myStr "\""))
)

(defun copy-current-word-to-other-window()
  "copy the current word on point to the other window"
  (interactive)
  (copy-current-thing-to-other-window 'symbol)
)

(defun copy-current-line-to-other-window()
  "copy the current line on point to the other window"
  (interactive)
  (copy-current-thing-to-other-window 'line)
)

(defun copy-current-thing-to-other-window(thing)
  "copyt current stuff to other window, the thing to copy could be line or symbol"
  (setq myStr (thing-at-point thing))
  (setq myStr (chomp myStr))
  (other-window 1)
  (princ (concat myStr "\n") (current-buffer))
  (other-window 1)
)

(defun chomp(str)
  "Chomp leading and tailing whitespace from STR."
  (when (string-match "[ \t\n]*$" str)
	(setq str (replace-match "" nil nil str))
  )
  str
)

;; curl function, ez to inspect respond json code from local url request
(defun url-json-calling-on-current-line ()
  "Call the url on current line"
  (interactive)
  (message (thing-at-point 'line))
  (let ((content (chomp (thing-at-point 'line))))
	(message (concat "Getting: " content))
	(url-json-calling content)))

(defun url-json-calling (call-url)
  "Call the `CALL-URL` and get the respond, put it into a json readable format. put into a new buffer and display it"
  (interactive
   (list (read-string "Retrive url: " )))
  (let(
	   (url-request-method "GET")
	   (url-request-extra-headers '(("Content-Type" . "application/x-www-form-urlencoded"))))
	(url-retrieve
	 call-url 'json-dealing)))

(defun json-dealing (status)
  "Deal with the respond url and format it into json readable format"
  (switch-to-buffer (current-buffer))
  (goto-char (point-min))
  (search-forward-regexp "^$" nil t)
  (kill-region (1+ (point)) (point-max))
  (kill-buffer)
  (delete-other-windows)
  (split-window-right)
  (other-window 1)
  (switch-to-buffer "output")
  (goto-char (point-min))
  (yank)
  (kill-region (1+ (point)) (point-max))
  (json-mode)
  (json-reformat-region (point-min) (point-max))
  (other-window 1))


;; markdown functions
;; insert source code block
(defun markdown-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE` type source code block into pygemnts support markdown mode"
  (interactive
   (let ((src-code-types
		  '("ruby" "python" "php" "C" "java" "bash" "C++" "css"
			"text" "raw" "dot" "lisp" "matlab" "latex" "org" "perl")))
	 (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
	(newline-and-indent)
	(insert (format "{%s highlight %s %s}\n" "%" src-code-type "%"))
	(newline-and-indent)
	(insert "{% endhighlight %}\n")
	(previous-line 2)))

;; org functions
;; insert source code block
(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))

(setq org-publish-project-alist
      '(

		("org-dkblog-post"
		 ;; Path to your org files.
		 :base-directory "~/Document/blog/org/"
		 :base-extension "org"

		 ;; Path to your Jekyll project.
		 :publishing-directory "~/Document/blog/githubblog/"
		 :recursive t
		 :publishing-function org-html-publish-org-to-html
		 :headline-levels 4 
		 :html-extension "html"
		 :body-only t ;; Only export section between <body> </body>
		 )


		("org-static-dk"
		 :base-directory "~/Document/blog/org/"
		 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
		 :publishing-directory "~/Document/blog/githubblog/"
		 :recursive t
		 :publishing-function org-publish-attachment)

		("dkblog" :components ("org-dbblog-post" "org-static-dk"))

		))

;; geben test
(defun my-php-debug ()
  "Run current PHP script for debugging with geben"
  (interactive)
  (call-interactively 'geben)
  (shell-command
    (concat "XDEBUG_CONFIG='idekey=my-php-dong' /usr/bin/php "
    (buffer-file-name) " &"))
  )

;; windows settings
(set-background-color "LightYellow2")

;; quick keys:
(global-set-key (kbd "C-c C-h") 'org-html-export-to-html)
(global-set-key (kbd "C-c s i") 'org-insert-src-block)
(global-set-key (kbd "M-RET") 'markdown-insert-list-item)
(global-set-key (kbd "C-c f") 'elisp-index-search)
;; deprecated
;(global-set-key (kbd "M-s M-s") 'call-current-songid)
;(global-set-key (kbd "M-s M-a") 'copy-current-word-to-other-window)
;(global-set-key (kbd "M-s M-d") 'copy-current-line-to-other-window)
;(global-set-key (kbd "M-s M-w") 'search-current-line-in-baidu-music)
(global-set-key (kbd "M-s i") 'open-init-file)
(global-set-key (kbd "M-s m") 'open-my-el-file)
(global-set-key (kbd "M-]") 'find-tag-current-word)
(global-set-key (kbd "M-p") 'pop-tag-mark)
(global-set-key (kbd "C-c C-g") 'org-set-tags)
(global-set-key (kbd "C-M-_") 'find-grep-in-dir)
(global-set-key (kbd "C-M-]") 'find-grep-current-word)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "M-s c") 'url-json-calling-on-current-line)
(global-set-key (kbd "M-s l") 'markdown-insert-src-block)
(global-set-key (kbd "C-x v p") 'vc-version-diff)
(global-set-key [f5] 'toggle-truncate-lines)


; for semantic 
(global-set-key [f12] 'semantic-ia-fast-jump)
(global-set-key [S-f12]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

