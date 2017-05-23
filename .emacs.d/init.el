;;メニューバーを非表示にする

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
(setq kill-whole-linet t)
;;ログの記録量を増やす
(setq message-log-max 10000)
;;履歴数を増やす
(setq history-length 1000)
;;重複する履歴は保存しない
(setq history-delete-duplicates t)
;;ショートカットでコメント化
;;必要なプラグインをインストールできていないので無効化
;;(transient-mark-mode t)


;; -----------------------------------
;; キーバインド設定
;; -----------------------------------
;;カーソル前の文字を1文字消す
(global-set-key "\C-h" 'delete-backward-char)
;;カーソル前の1語を削除する
(global-set-key (kbd "M-h") 'backward-kill-ward)
;;入力した行にジャンプする
(global-set-key (kbd "M-g") 'goto-line)
;;改行して、インデントの調節を行う
(global-set-key (kbd "C-m") 'newline-and-indent)



;; -----------------------------------
;; パッケージ設定
;; -----------------------------------
;;行数を表示する
(global-linum-mode t)
;;行番号の表示領域として4桁分を予め確保する
(setq linum-format "%5d")
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



;; -----------------------------------
;; elispパッケージの有効化
;; -----------------------------------
;;パッケージ有効化
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)




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



;;現在行のハイライト
(defface my-hl-line-face
;;背景がdarkならば背景色を紺に
'((((class color) (background dark))
   (:background "NavyBlur" t))
   ;;背景がlightならば背景色を緑に
   (((class color) (background light))
    (:background "LightGoldenrodYellow" t))
   (t (:bold t)))
"hl-line'smyface")
(setq hl-line-face 'my-hl-line-face)
;;カーソル位置の行を強調表示する
(global-hl-line-mode t)



;; -----------------------------------
;; 各パッケージ設定
;; -----------------------------------
(require 'helm-config)

(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%y%m%d/%H%M%S.")
(global-set-key (kbd "C-x C-z") 'open-junk-file)

