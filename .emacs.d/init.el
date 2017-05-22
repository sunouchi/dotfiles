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
;; 起動時のメッセージを非表示にする
(setq inhibit-startup-message t)
;; yesかnoかではなく、yかnで答えられるようにする
(defalias 'yes-or-no-p 'y-or-n-p)
;; ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
;; 対応する括弧を強調表示する
(show-paren-mode t)

;; ショートカットでコメント化
(transient-mark-mode t)



;; load-pathを追加する関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	     (expand-file-name (concat user-emacs-directory path))))
	   (add-to-list 'load-path default-directory)
	   (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	       (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")



;; 現在行のハイライト
(defface my-hl-line-face
  ;; 背景がdarkならば背景色を紺に
  '((((class color) (background dark))
     (:background "NavyBlur" t))
   ;; 背景がlightならば背景色を緑に
    (((class color) (background light))
     (:background "LightGoldenrodYellow" t))
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
;; カーソル位置の行を強調表示する
(global-hl-line-mode t)
