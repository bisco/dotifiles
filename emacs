(setq system-uses-terminfo nil)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;======================================================================
; 言語・文字コード関連の設定
;======================================================================
(when (equal emacs-major-version 21) (require 'un-define))
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)

(when (featurep 'mule)
  ;; Mule-UCS-Unicode for emacsen 20.x and 21.x
  (when (and (>= emacs-major-version 20)
	     (<= emacs-major-version 21))
    (if (fboundp 'un-define-debian-jisx0213)
	(un-define-debian-jisx0213)
      (when (locate-library "un-define")
	(if (featurep 'xemacs)
	    (require 'un-define)
	  (require 'jisx0213)))))
  (let ((case-fold-search t)
	locale vars cs)
    (setq vars '("LC_ALL" "LC_CTYPE" "LANG"))
    (while (and vars (not (setq locale (getenv (car vars)))))
      (setq vars (cdr vars)))
    (or locale (setq locale "C"))
    (when (string-match "^ja" locale)
      ;; prefer japanese-jisx0208 characters
      (when (and (featurep 'un-define)
		 (not (featurep 'xemacs))) ;; for Emacs 20.x and 21.x
	(require 'un-supple)
	(un-supple-enable 'jisx0221)
	(un-supple-enable 'windows))
      (when (fboundp 'utf-translate-cjk-set-unicode-range)
	;; for Emacs 22.x, see also emacs/lisp/international/subst-*
	(utf-translate-cjk-set-unicode-range
	 '((#x00a2 . #x00a3) (#x00a7 . #x00a8) (#x00ac . #x00ac)
	   (#x00b0 . #x00b1) (#x00b4 . #x00b4) (#x00b6 . #x00b6)
	   (#x00d7 . #x00d7) (#x00f7 . #x00f7) (#x0370 . #x03ff)
	   (#x0400 . #x04ff) (#x2000 . #x206f) (#x2100 . #x214f)
	   (#x2190 . #x21ff) (#x2200 . #x22ff) (#x2300 . #x23ff)
	   ;;(#x2460 . #x2473)
	   (#x2500 . #x257f) (#x25a0 . #x25ff) (#x2600 . #x26ff)
	   (#x2e80 . #xd7a3) (#xff00 . #xffef))))
      (set-language-environment "Japanese")
      (prefer-coding-system 'utf-8)
      (prefer-coding-system 'shift_jis)
      (prefer-coding-system 'euc-jp))
    (cond
     ((string-match "UTF-?8" locale)
      (setq cs 'utf-8))
     ((and (string-match "EUC-?JIS" locale) (featurep 'jisx0213))
      (setq cs 'euc-jisx0213))
     ((and (string-match "Shift_?JIS[-X2]" locale) (featurep 'jisx0213))
      (setq cs 'shift_jisx0213))
     ((string-match "EUC-?J" locale)
      (setq cs 'euc-jp))
     ((string-match "SJIS\\|Shift_?JIS" locale)
      (setq cs 'shift_jis)))
    (when cs
      (prefer-coding-system cs)
      (set-keyboard-coding-system cs)
      (set-terminal-coding-system cs))))
;=======================================================================
;フレームサイズ・位置・色など
;=======================================================================
(set-face-background 'region "SkyBlue")
(set-face-foreground 'region "black")
;(set-face-foreground 'modeline "white")
;(set-face-background 'modeline "DarkGreen")
(set-face-background 'region "LightBlue")
;(set-face-foreground 'mode-line-inactive "gray30")
;(set-face-background 'mode-line-inactive "gray85")
(setq initial-frame-alist
	(append (list
		   '(foreground-color . "white")		;; 文字色
		   '(background-color . "gray10")		;; 背景色
		   '(border-color . "DarkGray")
		   '(mouse-color . "orange")
		   '(cursor-color . "green")
		   '(width . 100)				;; フレームの幅
		   '(height . 35)				;; フレームの高さ
		   ;'(top . 30)					;; Y 表示位置
		   ;'(left . 200)				;; X 表示位置
		   )
		initial-frame-alist))
(setq default-frame-alist initial-frame-alist)
;;
;=======================================================================
; Misc
;=======================================================================
(mouse-wheel-mode)						;;ホイールマウス
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)

(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))
(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot)

(setq load-path (cons "~/.emacs.d/lisp" load-path))
(global-font-lock-mode t)					;;文字の色つけ
(setq line-number-mode t)					;;カーソルのある行番号を表示
(auto-compression-mode t)					;;日本語infoの文字化け防止
(global-set-key "\C-z" 'undo)					;;UNDO
(setq frame-title-format "%b")
(setq make-backup-files nil)					;;バックアップファイルを作成しない
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq initial-scratch-message "")

(setq truncate-partial-width-windows nil)
(set-scroll-bar-mode nil)
(transient-mark-mode 1)
(setq ring-bell-function 'ignore)

(setq auto-mode-alist
	        (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))

(defun bis-c-mode-hook ()
  (c-set-style "linux")
  (setq tab-width 4)
  (setq c-basic-offset tab-width)
  (setq	c-argdecl-indent	     4)
  (setq	c-indent-level		     0)
  (setq	c-continued-statement-offset 4)
  (setq	c-continued-brace-offset    -4)

  (setq	c-brace-offset		     4)
  (setq	c-brace-imaginary-offset     4)
  (setq	c-label-offset		    -4)
)
(add-hook 'c-mode-hook 'bis-c-mode-hook)


;折り返し
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

(load "ce-scroll")
(setq ce-smooth-scroll nil)

;;=================
;;kill ring browser
;;=================
(require 'browse-kill-ring)
(global-set-key "\M-y" 'browse-kill-ring)
;; kill-ring を一行で表示
(setq browse-kill-ring-display-style 'one-line)
;; browse-kill-ring 終了時にバッファを kill する
(setq browse-kill-ring-quit-action 'kill-and-delete-window)
;; 必要に応じて browse-kill-ring のウィンドウの大きさを変更する
(setq browse-kill-ring-resize-window t)
;; kill-ring の内容を表示する際の区切りを指定する
(setq browse-kill-ring-separator "-------")
;; 現在選択中の kill-ring のハイライトする
(setq browse-kill-ring-highlight-current-entry t)
;; 区切り文字のフェイスを指定する
(setq browse-kill-ring-separator-face 'region)
;; 一覧で表示する文字数を指定する． nil ならすべて表示される．
(setq browse-kill-ring-maximum-display-length 200)


;---------
(require 'linum)
(defvar my-linum-min-width 5)
(setq linum-format
      (lambda (line)
	(let ((fmt (format
		    "%%%dd"
		    (max
		     my-linum-min-width
		     (length (number-to-string
			      (count-lines (point-min) (point-max))))))))
	  (propertize (format fmt line) 'face 'linum)))
)
(global-linum-mode t)
;---------

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/lisp/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)             ; 互換性確保
(setq load-path (cons "~/.emacs.d/lisp/auto-install/" load-path))

(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
	  '(lambda ()
		 (local-set-key "\M-t" 'gtags-find-tag)
		 (local-set-key "\M-r" 'gtags-find-rtag)
		 (local-set-key "\M-s" 'gtags-find-symbol)
		 (local-set-key "\C-t" 'gtags-pop-stack)
		 ))
(add-hook 'c-mode-common-hook
		  '(lambda()
			 (gtags-mode 1)
			 (gtags-make-complete-list)
			 ))


(when (require 'auto-complete nil t)
  (require 'auto-complete-config)

  (global-auto-complete-mode t)
  (set-face-background 'ac-candidate-face "lightgray")
  (set-face-underline 'ac-candidate-face "darkgray")
  (set-face-background 'ac-selection-face "steelblue")

  (define-key ac-complete-mode-map "\M-/" 'ac-start)
  (define-key ac-complete-mode-map "\t" 'ac-expand)
  (define-key ac-complete-mode-map "\r" 'ac-complete)
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-set-trigger-key "TAB")

  (setq ac-auto-start nil)
  (setq ac-dwim t)
  (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer))
  
  (add-hook 'auto-complete-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-filename)
              (add-to-list 'ac-sources 'ac-source-words-in-buffer)))

  (add-hook 'c-mode-hook
            (lambda ()
              (setq ac-sources '(ac-source-gtags ac-source-yasnippet))))

)
(require 'anything-startup)
(ffap-bindings)
(require 'recentf-ext)
(global-set-key "\C-q" 'anything-filelist+) 
(require 'ac-anything)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))
(global-set-key [(meta return)] 'toggle-fullscreen) 
