;; 行数を表示する
(global-linum-mode t)
;; メニューバーを非表示にする
(menu-bar-mode 0)
;; ツールバーを非表示にする
(tool-bar-mode 0)
;; スクロールバーを非表示にする
(scroll-bar-mode 0)
;; モードラインにカーソル位置の行番号を表示する
(line-number-mode 1)
;; モードラインにカーソル位置の列番号を表示する
(column-number-mode 1)
;; カーソル位置の行を強調表示する
(global-hl-line-mode t)
;; 起動時のメッセージを非表示にする
(setq inhibit-startup-message t)
;; yesかnoかではなく、yかnで答えられるようにする
(defalias 'yes-or-no-p 'y-or-n-p)
;; ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
;; 対応する括弧を強調表示する
(show-paren-mode t)
