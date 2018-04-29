; ~/.emacs

(add-to-list 'load-path "~/emacs")
;(add-to-list 'load-path (expand-file-name "~/emacs/cedet/common"))
;(add-to-list 'load-path "~/emacs/ecb")
;(add-to-list 'load-path (expand-file-name "~/emacs/elib"))
;(add-to-list 'load-path (expand-file-name "~/emacs/jde/lisp"))
;(add-to-list 'load-path "/opt/local/share/scala-2.8/misc/scala-tool-support/emacs")

; Disable a bunch of unneeded clutter.
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

; We don't like to exit emacs.  Always ask for confirmation.
(setq confirm-kill-emacs 'yes-or-no-p)

; Do not insert tabs in place of multiple spaces when formatting a region.
(setq-default indent-tabs-mode nil)

; Turn on Font Lock mode automatically.
(global-font-lock-mode t)

; Highlight the kill/yank region.
(transient-mark-mode 1)

; Generally set color scheme to a white text on a black background.
; Font Lock mode can still override this with more specific colors.
(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color "white")
(set-face-background 'region "blue")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(comint-completion-addsuffix t)
 '(comint-completion-autolist t)
 '(comint-input-ignoredups t)
 '(comint-move-point-for-output t)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(comint-scroll-to-bottom-on-output t)
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("~/java-test" "~/jraph")))
 '(ecb-tree-buffer-style (quote ascii-guides))
 '(jde-jdk (quote ("1.6")))
 '(jde-jdk-registry (quote (("1.6" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0"))))
 '(line-number-mode t)
 '(inhibit-startup-screen t))



; shell support: Enable ANSI color output from shell commands.
(ansi-color-for-comint-mode-on)

; shell support: Make completion buffers disappear after 3 seconds.
;(add-hook 'completion-setup-hook
;  (lambda () (run-at-time 3 nil
;    (lambda () (delete-windows-on "*Completions*")))))

; shell support: Automatically choose a unique name for new shell buffers.
(add-hook 'shell-mode-hook 'rename-uniquely)

; shell support: Automatically turn off echoing for password prompts.
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

; Maximize window on startup.
;(require 'maxframe)
;(add-hook 'window-setup-hook 'maximize-frame t)

; Make the window a little bit transparent.
(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))

(add-hook 'c++-mode-hook (lambda ()
  ;(print "c++-mode-hook" (get-buffer "*scratch*"))
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0)))

;(add-hook 'c++-mode-hook
;  (lambda ()
;    (print "Hello c++-mode-hook to STDOUT." (get-buffer "*scratch*"))
;    (setq c++-tab-always-index t)
;    (setq c-basic-offset 4)
;    (setq c-indent-level 4)
;    (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
;    (setq tab-width 4)
;    (setq defun-block-intro 4))

;(load-file "~/emacs/cedet/common/cedet.el")
; TODO: Execution stops here on re-eval for some reason.

;(global-ede-mode t)
;(semantic-load-enable-minimum-features)
;(require 'semantic-ia)
;(require 'ecb)

;(require 'jde)

(setq visible-bell t)

;(setq php-mode-force-pear 1)
;(load "php-mode")

;(require `scala-mode-auto)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(add-hook 'after-init-hook #'global-flycheck-mode)

; EOF
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
