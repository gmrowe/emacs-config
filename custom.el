;;  -*- lexical-binding: t; -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6843739510a2707c5b2822427bf11d46e952f09d8df8589ff577f5e3c4efd31a"
     "0f68254564bd44e1959e3483179f3ea6bcb36d35a0578a2fa7bace67360febb8"
     "9655ef5a1221c33b53d9cbdd1a04090ca8a458015a1dd365344e1bb3c3cfcf81"
     "1d51919e9a075a4f56396681dc99adecefa152ab29819178403cbf6ae5bc0dd8"
     default))
 '(package-selected-packages
   '(ace-window cider clang-format-lite company corfu flycheck-clj-kondo
                flycheck-rust ivy lsp-mode move-text neotree
                org-superstar paredit parinfer-rust-mode projectile
                rustic simplicity-theme smex which-key zprint-mode))
 '(safe-local-variable-directories
   '("/Users/garrettrowe/dev/graph/" "/Users/garrettrowe/dev/anim8/"))
 '(safe-local-variable-values
   '((eval setq-local company-clang-arguments
           (list
            (concat "-I"
                    (expand-file-name "raylib/src"
                                      (projectile-project-root)))))))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(font-lock-keyword-face ((t (:foreground "#fe8019"))))
 '(font-lock-type-face ((t (:foreground "#b8bb26")))))
