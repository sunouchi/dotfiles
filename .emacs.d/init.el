;; -----------------------------------
;; elispパッケージの有効化
;; -----------------------------------
;;パッケージ有効化
(package-initialize)
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)


;; -----------------------------------
;; frame
;; -----------------------------------
;;メニューバーを非表示にする
(menu-bar-mode 0)
;;ツールバーを非表示にする
(tool-bar-mode 0)
;;スクロールバーを非表示にする
(scroll-bar-mode 0)
;;モードラインにカーソル位置の行番号を表示する
(line-number-mode 1)
;;モードラインにカーソル位置の列番号を表示する
(column-number-mode 1)
;;起動時のメッセージを非表示にする
(setq inhibit-startup-message t)
;;yesかnoかではなく、yかnで答えられるようにする
(defalias 'yes-or-no-p' y-or-n-p)
;;ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
;;対応する括弧を強調表示する
(show-paren-mode t)
;;ガベッジコレクションを実行するまでの割当メモリの閾値を増やす
(setq gc-cons-threshold(* 50 gc-cons-threshold))
;;kill-lineで行末も削除する
(setq kill-whole-line t)
;;ログの記録量を増やす
(setq message-log-max 10000)
;;履歴数を増やす
(setq history-length 1000)
;;重複する履歴は保存しない
(setq history-delete-duplicates t)
;;ショートカットでコメント化
;;必要なプラグインをインストールできていないので無効化
;;(transient-mark-mode t)
;;ファイルサイズを表示
(size-indication-mode t)
;;タイトルバーにファイルのフルパスを表示する
;;表示が反映されないのでコメントアウト
;(setq frame-title-format "%f")
;;タブ文字の表示幅
(setq-default tab-width 4)
;;インデントにタブ文字を使用しない
(setq-default indent-tabs-mode nil)



;; -----------------------------------
;; key binding
;; -----------------------------------
;;カーソル前の文字を1文字消す
(global-set-key "\C-h" 'delete-backward-char)
;;カーソル前の1語を削除する
(global-set-key (kbd "M-h") 'backward-kill-ward)
;;入力した行にジャンプする
(global-set-key (kbd "M-g") 'goto-line)
;;改行して、インデントの調節を行う
(global-set-key (kbd "C-m") 'newline-and-indent)
;;"C-t"でウィンドウを切り替える
(global-set-key (kbd "C-t") 'other-window)



;; -----------------------------------
;; theme
;; -----------------------------------
;;テーマの読み込み
(load-theme 'dark-mint)
;;カーソル位置の行を強調表示する
(global-hl-line-mode t)



;; -----------------------------------
;; バックアップとオートセーブ
;; -----------------------------------
;;バックアップファイルの作成場所をシステムのTempディレクトリに変更する
;(setq backup-directry-alist
;      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))



;; -----------------------------------
;; 矩形編集
;; -----------------------------------
;;cua-modeの設定
;;矩形編集できないので、いったん無効化する
;(cua-mode t)
;;CUAキーバインドを無効化
;(setq cua-enable-cua-keys nil)



;; -----------------------------------
;; パッケージ設定
;; -----------------------------------
;;行数を表示する
;(global-linum-mode t)
;;行番号の表示領域として4桁分を予め確保する
;(setq linum-format "%5d")
;;カーソルがどの関数の中にあるかを
;;モードラインに表示する
(which-function-mode 1)
;;最近使ったファイルを記録する
(require 'recentf)
(setq recentf-save-file "~/.recentf")
(setq recentf-exclude '("~/.recentf"))
(setq recentf-max-saved-items 5000)
(setq recentf-auto-cleanup '10)
(run-with-idle-timer 30 t 'recentf-save-list)
(recentf-mode 1)







;;load-pathを追加する関数
(defun add-to-load-path(&rest paths)
  (let (path)
    (dolist (pathpathspaths)
      (let ((default-directory
	(expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	(normal-top-level-add-subdirs-to-load-path))))))

;;引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")






;; -----------------------------------
;; 各パッケージ設定
;; -----------------------------------
;;helm
(require 'helm-config)
;;open-junk-file
(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%y%m%d/%H%M%S.")
(global-set-key (kbd "C-x j") 'open-junk-file)
;;lispxmp
;;emacs-lisp-modeでC-c C-dを押すと解釈
(require 'lispxmp)
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)
;;括弧の対応を取りながら編集
;(require 'paredit)
;(add-hook 'emacs-lisp-mode-hook 'enable-paredit-hook)
;;~/junk/以外で自動バイトコンパイル
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
;;括弧に色付け
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
;;emacsclient
;;error: (void-function server-running-p)と出てエラーになるので、とりあえず無効化
;(require 'server)
;(unless (server-running-p)
;  (server-start))

;;auto-insatllの設定
;(when (require 'auto-install nil t)
                                        ;
;;インストールディレクトリの設定
;  (setq auto-install-directory "~/.emacs.d/elisp/")
;  ;;EmacsWikiに登録されているelispの名前を取得する
;  (auto-install-update-emacswiki-package-name t)
;  ;;install-lispの関数を利用可能にする
;  (auto-install-compatibility-setup))

;;auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)        ;text-modeでも自動的に有効化する
(add-to-list 'ac-modes 'fundamental-mode) ;fundamental-modeでも自動的に有効化する
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t) ;補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t) ;曖昧マッチ

;;Elscreen
;;elscreenのプレフィックスキーを変更する（初期値はC-z）
;(setq elscreen-prefix-key (kbd "C-t"))
;(elscreen-start)
;(when (require 'elscreen nil t)
;  ;; C-z C-zをタイプした場合にデフォルトのC-zを利用する
;  (if window-system
;      (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
;    (define-key elscreen-map (kbd "C-z") 'supend-emacs)))





(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("1b1e54d9e0b607010937d697556cd5ea66ec9c01e555bb7acea776471da59055" default)))
 '(package-selected-packages
   (quote
    (elscreen auto-complete auto-install dark-mint-theme ag rainbow-delimiters auto-async-byte-compile paredit lispxmp open-junk-file helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
