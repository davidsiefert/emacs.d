;; TODO run these commands if keyed exec does not exist:
;; goimports=go get golang.org/x/tools/cmd/goimports
;; godef=go get github.com/rogpeppe/godef

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(setq package-list '(go-mode exec-path-from-shell auto-complete go-autocomplete flycheck go-eldoc yasnippet go-snippets go-guru))
;; I manually symlinked the go-mode snippets to the default snippets dir path

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(yas-global-mode)

(defun go-mode-hooks ()
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (linum-mode)
  (flycheck-mode)
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  (auto-complete-mode 1)
  (require 'go-eldoc)
  (go-eldoc-setup)
  (require 'go-guru)
  (go-guru-hl-identifier-mode)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
	   "go build -v && go test -v && go vet")))
(add-hook 'go-mode-hook 'go-mode-hooks)
(with-eval-after-load 'go-mode (require 'go-autocomplete))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (exec-path-from-shell go-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
