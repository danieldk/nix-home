{ pkgs, ... }:

{
  imports = [ ./emacs/emacs-init.nix ];

  programs.emacs.enable = true;
  programs.emacs.package = if pkgs.stdenv.isDarwin then pkgs.emacsMacport else pkgs.emacs;

  programs.emacs.init = {
    enable = true;
    recommendedGcSettings = true;

    prelude = ''
      (general-create-definer my-leader-def
        :keymaps 'override
        :states '(emacs normal visual motion insert)
        :non-normal-prefix "C-SPC"
        :prefix "SPC")

        (general-create-definer my-local-leader-def
          :prefix "SPC m")

      (my-leader-def
       "b"  '(:ignore t :which-key "buffer")
       "bd" '(kill-this-buffer :which-key "kill buffer")

       "f"  '(:ignore t :which-key "file")
       "ff" '(find-file :which-key "find")
       "fs" '(save-buffer :which-key "save")

       "m"  '(:ignore t :which-key "mode")

       "s"   '(:ignore t :which-key "search")

       "t"  '(:ignore t :which-key "toggle")
       "tf" '(toggle-frame-fullscreen :which-key "fullscreen")

       "wv" '(split-window-horizontally :which-key "split vertical")
       "ws" '(split-window-vertically :which-key "split horizontal")
       "wk" '(evil-window-up :which-key "up")
       "wj" '(evil-window-down :which-key "down")
       "wh" '(evil-window-left :which-key "left")
       "wl" '(evil-window-right :which-key "right")
       "wd" '(delete-window :which-key "delete")

       "q"  '(:ignore t :which-key "quit")
       "qq" '(save-buffers-kill-emacs :which-key "quit"))
 
    '';

    usePackage = {
      leuven-theme = {
        enable = true;
        config = "(load-theme 'leuven t)";
      };

      evil = {
        enable = true;
        config = ''
          (setq evil-want-C-i-jump nil)
          (evil-mode 1)
          (general-evil-setup t)
        '';

        general = ''
        '';
      };

      nlinum-relative = {
        enable = true;
        config = ''
          (nlinum-relative-setup-evil)
          (add-hook 'prog-mode-hook 'nlinum-relative-mode)
          (add-hook 'org-mode-hook 'nlinum-relative-mode)
        '';
      };

      which-key = {
        enable = true;
        diminish = [ "which-key-mode" ];
        config = ''
          (which-key-mode)
          (which-key-setup-side-window-right-bottom)
          (setq
            which-key-sort-order 'which-key-key-order-alpha
            which-key-side-window-max-width 0.33
            which-key-idle-delay 0.05)
        '';
      };

      general = {
        enable = true;
        config = ''

          (general-def 'motion
            ";" 'evil-ex
            ":" 'evil-repeat-find-char)

       '';
      };

      ivy = {
        enable = true;
        config = ''
          (ivy-mode 1)
          (setq ivy-use-virtual-buffers t
            ivy-height 20
            ivy-count-format "(%d/%d) "
            ivy-initial-inputs-alist nil)

          (my-leader-def
           "bb" '(ivy-switch-buffer :which-key "switch buffer")
           "fr" '(ivy-recentf :which-key "recent file"))
        '';
      };

      counsel = {
        enable = true;
        demand = true;
        config = ''
          (my-leader-def
            "SPC" '(counsel-M-x :which-key "M-x")
            "fo"  '(counsel-find-file :which-key "find file")
            "sc"  '(counsel-unicode-char :which-key "find character")
            "sg"  '(counsel-rg :which-key "rg git"))
        '';
        diminish = [ "counsel-mode" ];
      };

      swiper = {
        enable = true;
        bind = {
          "C-s" = "swiper";
        };
        config = ''
          (my-leader-def
            "ss" '(swiper :which-key "swiper"))
        '';
      };

      magit = {
        enable = true;
        config = ''
          (my-leader-def
            "g"  '(:ignore t :which-key "Git")
            "gs" 'magit-status)
        '';
      };

      evil-magit = {
        enable = true;
        after = [ "magit" ];
      };

      projectile = {
        enable = true;
        config = ''
        (projectile-mode 1)

        (progn
          (setq projectile-enable-caching t)
          (setq projectile-require-project-root nil)
          (setq projectile-completion-system 'ivy)
          (add-to-list 'projectile-globally-ignored-files ".DS_Store"))
        (my-leader-def
         "p"  '(:ignore t :which-key "Project")
         "pf" '(projectile-find-file :which-key "Find in project")
         "pl" '(projectile-switch-project :which-key "Switch project"))
        '';
        diminish = [ "projectile-mode" ];
      };

      direnv = {
        enable = true;
        config = "(direnv-mode)";
      };

      company = {
        enable = true;
        diminish = [ "company-mode" ];
        config = "(company-mode)";
      };

      flycheck = {
        enable = true;
        diminish = [ "flycheck-mode" ];
        config = "(global-flycheck-mode)";
      };

      rust-mode = {
        enable = true;
        mode = [ "\\.rs\\'" ];
      };
    };
  };
}
