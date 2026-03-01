;;; whitespace-hl-mode.el --- Highlight whitespace on current line -*- lexical-binding: t; -*-

;; ;; The "Bright" faces (for the current line)
(defface my-whitespace-hl-active-whitespace-face
  '((t (:inherit default :foreground "#665c54" :weight bold)))
  "Face for spaces/trailing spaces on the current line."
  :group 'whitespace)

(defface my-whitespace-hl-active-tab-face
  '((t (:background "#d65d0e" :foreground "#fbf1c7" :weight bold))) ; orange bg
  "Face for tab characters on the current line."
  :group 'whitespace)

(defface my-whitespace-hl-active-trailing-face
  '((t (:foreground "#fbf1c7")))
  "Face for tab characters on the current line."
  :group 'whitespace)

(defface my-whitespace-hl-active-newline-face
  '((t (:foreground "#665c54" :weight bold)))
  "Face for newline characters on the current line."
  :group 'whitespace)

(defface my-whitespace-hl-default-trailing-face
  '((t (:background "#cc241d" :foreground "#fbf1c7"))) ; Added Red Background
  "Face for trailing whitespace on non-current lines."
  :group 'whitespace)

(defface my-whitespace-hl-default-whitespace-face
  '((t (:foreground "#3c3836")))
  "Face for whitespace elsewhere in the buffer."
  :group 'whitespace)

(defvar my-whitespace-default-keywords
  '(("[ \t\n]+" 0 'my-whitespace-hl-default-whitespace-face prepend)
    ("[ \t]+$" 0 'my-whitespace-hl-default-trailing-face prepend))
  "Font lock keywords for dimming background whitespace.")

(defvar-local my-whitespace-hl-original-display-table nil
  "Original display table before our mode modified it.")

(defvar-local my-whitespace-overlays nil
  "A list of currently active whitespace overlays.")

(defvar-local my-whitespace-hl--last-line nil
  "Internal variable to track the last line processed.")

(defun my-whitespace-hl-update-current-line ()
  "Scans the current line and places overlays on whitespace."

  (let ((current-line (line-number-at-pos)))
    ;; Clean up old overlays
    (mapc #'delete-overlay my-whitespace-overlays)
    (setq my-whitespace-overlays nil)

    ;; Scan and Highlight
    (save-excursion
      (let ((line-start (pos-bol))
            (line-end (pos-eol)))
        ;; Find the whitespace
        (goto-char line-start)
        (while (re-search-forward "[ \t]" line-end t)
          (let* ((match-beg (match-beginning 0))
                 (match-end (match-end 0))
                 (char-matched (char-after match-beg))
                 (face (if (eq char-matched ?\t)
                           'my-whitespace-hl-active-tab-face
                         'my-whitespace-hl-active-whitespace-face))
                 (ov (make-overlay match-beg match-end)))
            (overlay-put ov 'face face)
            (push ov my-whitespace-overlays)))

        ;; Find the newline character if it exists
        (when (eq (char-after line-end) ?\n)
          (let* ((face 'my-whitespace-hl-active-newline-face)
                 (ov (make-overlay line-end (1+ line-end))))
            (overlay-put ov 'face face)
            (push ov my-whitespace-overlays)))))))

(defun my-whitespace-hl-mode-init ()
  (add-hook 'post-command-hook #'my-whitespace-hl-update-current-line nil t)

  (setq my-whitespace-hl-original-display-table buffer-display-table)

  (setq buffer-display-table
    (if buffer-display-table
      (copy-sequence buffer-display-table)
    (make-display-table)))

  ;; Set the glyphs that we want to use to represent whitespace
  (aset buffer-display-table ?\s [?·])
  (aset buffer-display-table ?\t [?»])
  (aset buffer-display-table ?\n [?↵ ?\n])

  (font-lock-add-keywords nil my-whitespace-default-keywords t)
  (font-lock-flush)

  (message "whitespace-hl-mode enabled"))

(defun my-whitespace-hl-mode-cleanup ()
  (mapc #'delete-overlay my-whitespace-overlays)
  (setq my-whitespace-overlays nil)

  (setq my-whitespace-hl--last-line nil)

  (setq buffer-display-table my-whitespace-hl-original-display-table)
  (setq my-whitespace-hl-original-display-table nil)

  (font-lock-remove-keywords nil my-whitespace-default-keywords)
  (font-lock-flush)

  (message "whitespace-hl-mode disabled"))

(define-minor-mode my-whitespace-hl-mode
  "Show whitespace prominently on curent line, dimly elsewhere."
  :lighter " WSH"
  :keymap nil
  (if my-whitespace-hl-mode
      (my-whitespace-hl-mode-init)
    (my-whitespace-hl-mode-cleanup)))

;; (setq buffer-display-table (make-display-table))

(provide 'whitespace-hl-mode)

