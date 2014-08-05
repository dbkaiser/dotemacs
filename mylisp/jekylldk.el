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
;; Last-Updated: 日  8  3 22:27:46 2014 (+0800)
;;           By: DongBo
;;     Update #: 1
;; 
;;; Code:

;; Jekyll路径
(setq jekyll-workdir (expand-file-name "$HOME/Documents/blog/githublog"))


(defun jekyll-rake (command)
  "run rake commands"
  (let ((command-str (format "bash -l -c 'source $HOME/.rvm/scripts/rvm && rvm use ruby-1.9.2-p320 && cd %s && rake %s'" octopress-workdir command))) ;; RVM变量设置
    (shell-command-to-string command-str)))


(defun jekyll-new (class title)
  (let* ((command-str (format "new_%s[\"%s\"]" class title))
         (command-result (octopress-rake command-str))
         (regexp-str (format "Creating new %s: " class))
         (filename))
    (progn
      (setq filename (concat octopress-workdir "/"
                             (replace-regexp-in-string regexp-str ""
                                                       (car (cdr (reverse (split-string command-result "\n")))))))
      (find-file filename))))


(defun octopress-new-post (title)
  "begin a new post in source/_posts"
  (interactive "MTitle: ")
  (octopress-new "post" title))


(defun octopress-new-page (title)
  "create a new page in source/(filename)/index.markdown"
  (interactive "MTitle: ")
  (octopress-new "page" title))


(defun octopress-generate ()
  "generate jekyll site"
  (interactive)
  (octopress-rake "generate")
  (message "Generate site OK"))


(defun octopress-deploy ()
  "default deploy task"
  (interactive)
  (octopress-rake "deploy")
  (message "Deploy site OK"))

(defun octopress-rsync ()
  "deploy website via rsync"
  (octopress-rake "rsync")
  (message "Rsync site OK"))

(defun octopress-gen-deploy ()
  "generate website and deploy"
  (interactive)
  (octopress-rake "gen_deploy")
  (message "Generate and Deploy OK"))


(defun octopress-preview ()
  "preview the site in a web browser"
  (interactive)
  (octopress-rake "preview"))

(provide 'octopress)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; jekylldk.el ends here
