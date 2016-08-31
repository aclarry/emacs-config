;------------------------;
;; Modal Programming FTW ;
;------------------------;

(require 'evil)
(evil-mode 1)

;; Use when you want to insert into a mode by default
;(evil-set-initial-state 'mode 'insert)

(define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-visual-state-map "\C-e" 'evil-end-of-line)
(define-key evil-motion-state-map "\C-e" 'evil-end-of-line)

(define-key evil-normal-state-map "\C-a" 'evil-start-of-line)
(define-key evil-insert-state-map "\C-a" 'start-of-line)
(define-key evil-visual-state-map "\C-a" 'evil-start-of-line)
(define-key evil-motion-state-map "\C-a" 'evil-start-of-line)

(define-key evil-normal-state-map "\C-b" 'evil-backward-char)
(define-key evil-insert-state-map "\C-b" 'evil-backward-char)
(define-key evil-visual-state-map "\C-b" 'evil-backward-char)
(define-key evil-motion-state-map "\C-b" 'evil-backward-char)

(define-key evil-normal-state-map "\C-f" 'evil-forward-char)
(define-key evil-insert-state-map "\C-f" 'evil-forward-char)
(define-key evil-visual-state-map "\C-f" 'evil-forward-char)
(define-key evil-motion-state-map "\C-f" 'evil-forward-char)

(define-key evil-normal-state-map "\C-n" 'evil-next-line)
(define-key evil-insert-state-map "\C-n" 'evil-next-line)
(define-key evil-visual-state-map "\C-n" 'evil-next-line)
(define-key evil-motion-state-map "\C-n" 'evil-next-line)

(define-key evil-normal-state-map "\C-p" 'evil-previous-line)
(define-key evil-insert-state-map "\C-p" 'evil-previous-line)
(define-key evil-visual-state-map "\C-p" 'evil-previous-line)
(define-key evil-motion-state-map "\C-p" 'evil-previous-line)

(defun vimlike-quit ()
  "Vimlike ':q' behaviour: closes the current window if there are split windows,
    otherwise close the current tabs (elscreen)"
  (interactive)
  (let (;(one-elscreen (elscreen-one-screen-p))
        (one-window (one-window-p))
        (one-buffer (= (length (buffer-list)) 1))
        )
    (cond
     ((not one-window)
      (delete-window)
      (balance-windows)
      nil)
     ;((not one-elscreen)
     ; (elscreen-kill)
     ; nil)
     ;(one-elscreen
     ; (evil-quit)
     ; nil)
     ;((and one-window (not one-buffer))
     ; (kill-buffer (current-buffer))
     ; nil)
     (one-window
      (kill-buffer (current-buffer))
      nil)
     )))

(defun vimlike-write-quit ()
  "Vimlike ':wq' behaviour: write then close."
  (interactive)
  (save-buffer)
  (vimlike-quit))

(evil-ex-define-cmd "q" 'vimlike-quit)
(evil-ex-define-cmd "wq" 'vimlike-write-quit)


(provide 'evil-settings)
