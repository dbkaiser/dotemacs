;;; jekylldk.el --- 
;; 
;; Filename: jekylldk.el
;; encoding=utf-8: 
;; Description: Automatically run rake command for jekyll post etc.
;; Usage: 
;; Author: DongBo
;; Copyright: Baidu Inc. 2013-2014
;; Created: 三  7 30 22:38:20 2014 (+0800)
;; Version: 
;; Last-Updated: Sat Aug 23 17:39:21 2014 (+0800)
;;           By: dongbo
;;     Update #: 28
;; 
;;; Code:

;; Jekyll working directory

(setq jekyll-workdir (expand-file-name "~/Documents/blog/githublog"))


(defun jekyll-rake (command)
  "run rake commands"
  (let ((command-str (format "bash -c \"cd %s && rake %s\"" jekyll-workdir command))) 
	(shell-command-to-string command-str)))


(defun jekyll-new (class title)
  (let* ((command-str (format "%s'%s'" class title))
         (command-result (jekyll-rake command-str))
         (filename))
	(message command-result)
    (progn
      (setq filename (concat jekyll-workdir "/" (get-last-word command-result)))
      (find-file filename))))


(defun jekyll-new-post (title)
  "begin a new post in source/_posts"
  (interactive "MTitle: ")
  (jekyll-new "post title=" title))


(defun jekyll-new-page (title)
  "create a new page in root directory"
  (interactive "MTitle: ")
  (jekyll-new "page name=" title))

; deprecated use it outside
;(defun jekyll-preview ()
;  "preview the site in a web browser. has bug."
;  (interactive)
;  (async-shell-command "cd ~/Documents/blog/githublog & jekyll serve &")

(defun jekyll-stop ()
  "Stop the jekyll server"
  (interactive)
  (shell-command "kill `ps -ef | grep jekyll | grep -v \"grep\" | awk '{print $2}'`")
  (message "Killed"))

(defun get-last-word (str)
  "Get the last word of a string"
  (car (last (split-string str)))
  )

(provide 'jekylldk)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; jekylldk.el ends here
