;; Cosmetic changes
(column-number-mode 1)
(show-paren-mode 1)
;(global-hl-line-mode 1)

;; Bind goto-line to M-g
(global-set-key "\M-g" 'goto-line)

;; Remove backup save files and semantic.cache files
(setq make-backup-files nil)
(setq semanticdb-default-save-directory "/tmp")

;; Use spaces instead of tabs, unless the mode sets otherwise.
(setq-default indent-tabs-mode nil)

;; Set a default auto-fill width
(setq-default fill-column 78)

;; C/C++/Java settings: only spaces for tabs, and a basic offset of 4 spaces
;; See <www.gnu.org/software/emacs/manual/html_node/ccmode/Config-Basics.html>
;;     <www.borkware.com/quickies/one?topic=emacs>
(defun mpd-c-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq c-default-style "k&r"))
(defun mpd-java-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq c-default-style "java"))
(add-hook 'c-mode-hook 'mpd-c-hook)
(add-hook 'c++-mode-hook 'mpd-c-hook)
(add-hook 'java-mode-hook 'mpd-java-hook)

;; C- syntax highlighting
(setq auto-mode-alist (cons '("\\.cm$" . c-mode) auto-mode-alist))

;; Insert a date string
(defun insert-today ()
  "Insert today's date."
  (interactive)
  (insert (format-time-string "%A, %B %e, %Y")))
(defun insert-date-string ()
  "Insert today's date with ISO formatting."
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))
(global-set-key (kbd "C-c t") 'insert-today)
(global-set-key (kbd "C-c y") 'insert-date-string)

;; Show donuts
(defun donuts ()
  (interactive)
  (print "Mmmm, donuts. Yahhhhhhhhh!"))

;; Indent the whole file
(defun indent-all ()
  "Re-indent the file in the current buffer"
  (interactive)
  (indent-region (point-min) (point-max) nil))

;; Trim all whitespace
(defun trim ()
  "Delete trailing whitespace in buffer"
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (replace-regexp "[ \t]+$" "")
      (goto-char (point-max))
      (skip-chars-backward "\n")
      (if (not (eobp))
          (delete-region (1+ (point)) (point-max))))))

;; Everyone likes the look of disapproval
(defun look-of-disapproval ()
  "I do not approve"
  (interactive)
  (insert "ಠ_ಠ"))

;; Derp-a-derpa
(defun derp ()
  "Rob Schneider derpa-derp-de-derpity-derp"
  (interactive)
  (insert "☉⏝⚆"))
