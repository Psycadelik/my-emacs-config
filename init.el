;; .emacs.d/init.el

;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Add the elegant theme to emacs
(defun load-relative-file (f)
  (load-file (expand-file-name f (file-name-directory load-file-name))))

(load-relative-file "elegant-emacs/sanity.el")
(load-relative-file "elegant-emacs/elegance.el")
(elegance-light)

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    elpy                            ;; Emacs Lisp Python Environment
    flycheck                        ;; On the fly syntax checking
    py-autopep8                     ;; Run autopep8 on save
    magit                           ;; Git integration
    material-theme                  ;; Theme
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; ===================================
;; Basic Customization
;; ===================================

(setq inhibit-startup-message t)    ;; Hide the startup message
;;(load-theme 'material t)            ;; Load material theme
(global-linum-mode t)               ;; Enable line numbers globally

;;;; Org mode configuration
(require 'org)
;; make org mode work with files ending in .org
 (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; ====================================
;; Development Setup
;; ====================================

;; Add wakatime
;; wakatime api-key: e4e951a9-7395-44f0-a429-d0f348671ae3
(global-wakatime-mode)

;; User-Defined init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(package-selected-packages
   '(counsel format-all wakatime-mode magit py-autopep8 flycheck elpy material-theme better-defaults))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)

;; Run/highlight code using babel in org mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (C . t)
   (python . t)
   ;; Include other languages here
   ))
;;Syntax highlight in #+BEGIN_SRC blocks
(setq org-src-fontify-natively t)
;; Don't promt before running code in org
(setq org-confirm-babel-evaluate nil)
;; Fix an incompatibility issue between ob-sync and ob-ipython packages
;;(setq ob-sync-no-async-languages-alist '("ipython")')
;; set babel to use python3
(setq org-babel-python-command "python3")
(setq python-shell-completion-native-enable nil)
