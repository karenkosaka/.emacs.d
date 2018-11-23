;;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

(set-language-environment 'Japanese)

(set-face-attribute 'default nil :height 140)
(set-frame-font "Monospace" 50)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))


(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;;(setq inhibit-startup-screen t)
(find-file "~/.emacs.d/init.el")
;;(split-window-horizontally)
;; 以下、http://keisanbutsuriya.hateblo.jp/entry/2015/11/16/004926から引用
(if window-system (progn
      (global-set-key (kbd "C-x C-c") 'kill-this-buffer)
     ;; (menu-bar-mode 0)                   ;; メニューバーを表示しない
      ;;(tool-bar-mode 0)                   ;; ツールバーを表示しない
      (set-frame-parameter nil 'fullscreen 'maximized)            ;; 最大化して開く
      (add-to-list 'default-frame-alist '(alpha . (90 85)))     ;; 透過
      (load-theme 'deeper-blue t)
      (require 'server)
      (unless (server-running-p)
        (server-start) ) ;; GUIで起動するときはサーバーも起動
      )
  )


(prefer-coding-system 'utf-8)
(setq x-select-enable-clipboard t)

(global-hl-line-mode)
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(hl-line ((t (:background "color-236")))))

(global-linum-mode t)

;; helm
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-;") 'helm-mini)(global-set-key (kbd "C-x C-f") 'helm-find-files)


;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode 1)

;;eshell

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)


(setq ring-bell-function 'ignore)
(setq
 ;; ホイールでスクロールする行数を設定
 mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control)))
 ;; 速度を無視する
 
)

;;eww

(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))


(setq eww-search-prefix "http://www.google.co.jp/search?q=")

;;クリップボードコピー
(defun copy-from-osx ()
 (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
 (let ((process-connection-type nil))
     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
       (process-send-string proc text)
       (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;----------------------------------------------------------------------
(require 'seq)
;;org-agenda
(setq org-log-done 'time)


;; 見出しをインデントする
(setq org-startup-indented t)


;; 見出しをインデントした時にアスタリスクが減るのを防ぐ
(setq org-indent-mode-turns-on-hiding-stars nil)

(global-set-key (kbd "C-c c") 'org-capture)
;;org-captureの見出し
(setq org-capture-templates
      '(
	("t" "関谷さんの話してくれてることなどメモ" entry (file+datetree "~/tier4_memo/iroiro.org"))
	("n" "日記" plain (file+datetree "~/TODO/memo/life/nikki.org")"\n~~~~~~~~~~~~~~~~~~~~%T--------------------\n%?")))
	 
;; インデントの幅を設定
(setq org-indent-indentation-per-level 4)
;; 見出しの初期状態（見出しだけ表示）
(setq org-startup-folded 'content)


;(define-key global-map (kbd "C-c l") 'org-store-link)

(setq org-log-done 'time)
(setq org-agenda-files (append (list "~/TODO/life_management")
			       (list "~/TODO/memo")))

(global-set-key (kbd "C-c a") 'org-agenda)


     



;
;; Auto Complete
;;
;; auto-complete-config の設定ファイルを読み込む。
(require 'auto-complete-config)

;; よくわからない
(ac-config-default)

;; TABキーで自動補完を有効にする
(ac-set-trigger-key "TAB")

;; auto-complete-mode を起動時に有効にする
(global-auto-complete-mode t);;
;; Auto Completec


(put 'dired-find-alternate-file 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(org-capture-templates
;;   (quote
;    (("n" "日記" plain
;      (file+datetree "~/TODO/memo/life/nikki.org")
 ;     "
;~~~~~~~~~~~~~~~~~~~~%T--------------------
;%?"))) t)
 '(package-selected-packages
   (quote
    (highlight-indentation indent-guide flycheck-gometalinter company-go flycheck exec-path-from-shell undo-tree helm helm-ebdb auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)


(when (require 'package nil t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize))

;;indent-guide
(require 'indent-guide)
(indent-guide-global-mode)
(set-face-foreground 'indent-guide-face "cyan")
(setq highlight-indent-guide t)

;; Goのパスを通す
(add-to-list 'exec-path (expand-file-name "$HOME/go"))
;; go get で入れたツールのパスを通す
(add-to-list 'exec-path (expand-file-name "$PATH:$GOPATH/bin"))
;;gofmt
(add-hook 'before-save-hook 'gofmt-before-save)

;; 諸々の有効化、設定
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook (lambda()
           (add-hook 'before-save-hook' 'gofmt-before-save)
           (local-set-key (kbd "M-.") 'godef-jump)
           (set (make-local-variable 'company-backends) '(company-go))
           (company-mode)
           (setq indent-tabs-mode nil)    ; タブを利用
           (setq c-basic-offset 4)        ; tabサイズを4にする
           (setq tab-width 4)))
(global-flycheck-mode)


;;neo-tree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
