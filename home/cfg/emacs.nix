{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;

    init = {
      enable = true;

      recommendedGcSettings = true;

      prelude =
        let
          fontSize = if pkgs.stdenv.isDarwin then "15" else "10";
        in ''
          (require 'bind-key)
  
          (setq inhibit-startup-screen t)
  
          (when window-system
            (set-frame-font "Source Code Pro ${fontSize}")

            (dolist (mode
              '(tool-bar-mode
                tooltip-mode
                scroll-bar-mode
                menu-bar-mode
                blink-cursor-mode))
              (funcall mode 0)))
      '';

      usePackageVerbose = true;

      usePackage = {
        company = {
          enable = true;
          diminish = [ "company-mode" ];
          config = ''
            (company-mode)
          '';
        };

        counsel = {
          enable = true;

          bindStar = {
            "M-x"     = "counsel-M-x";
            "C-x C-f" = "counsel-find-file";
            "C-x C-r" = "counsel-recentf";
            "C-c f"   = "counsel-git";
            "C-c s"   = "counsel-git-grep";
            "C-c /"   = "counsel-rg";
            "C-c l"   = "counsel-locate";
            "M-y"     = "counsel-yank-pop";
          };

          general = ''
            (general-nmap
              :prefix "SPC"
              "SPC" '(counsel-M-x :which-key "M-x")
              "fo"  '(counsel-find-file :which-key "find file")
              "s"   '(:ignore t :which-key "search")
              "sc"  '(counsel-unicode-char :which-key "find character")
              "sg"  '(counsel-rg :which-key "rg git"))
          '';
        };

        cython-mode = {
          enable = true;
        };

        direnv = {
          enable = true;
          config = ''
            (direnv-mode)
          '';
        };

        doom-themes = {
          enable = true;
          after = [ "solaire-mode" ];
          config = ''
            (setq doom-themes-enable-bold t
                  doom-themes-enable-italic t)
            (load-theme 'doom-one t)
            (doom-themes-visual-bell-config)
            (doom-themes-org-config)
          '';
        };

        editorconfig = {
          enable = true;
          config = ''
            (editorconfig-mode 1)
          '';
        };

        evil = {
          enable = true;
          after = [ "undo-tree" ];
          init = ''
            (setq evil-want-C-i-jump nil)
            (setq evil-undo-system 'undo-tree)
          '';
          config = ''
            (evil-mode 1)
          '';
        };

        evil-magit = {
          enable = true;
          after = [ "magit" ];
        };

        flycheck = {
          enable = true;
          diminish = [ "flycheck-mode" ];
          config = ''
            (global-flycheck-mode)
          '';
        };

        lsp-mode = {
          enable = true;
          command = [ "lsp" ];
          hook = [
            "(lsp-mode . lsp-enable-which-key-integration)"
          ];
        };

        lsp-ui = {
          enable = true;
          after = [ "lsp" ];
          command = [ "lsp-ui-mode" ];
        };

        lsp-ivy = {
          enable = true;
          after = [ "lsp" "ivy" ];
          command = [ "lsp-ivy-workspace-symbol" ];
        };

        nlinum-relative = {
          enable = true;
          after = [ "evil" ];
          config = ''
            (nlinum-relative-setup-evil)
            (add-hook 'prog-mode-hook 'nlinum-relative-mode)
            (add-hook 'org-mode-hook 'nlinum-relative-mode)
          '';
        };

        general = {
          enable = true;
          after = [ "evil" "which-key" ];
          config = ''
            (general-evil-setup)

            (general-mmap
              ";" 'evil-ex
              ":" 'evil-repeat-find-char)

            (general-create-definer my-leader-def
              :prefix "SPC")

            (general-create-definer my-local-leader-def
              :prefix "SPC m")

            (general-nmap
              :prefix "SPC"
              "b"  '(:ignore t :which-key "buffer")
              "bd" '(kill-this-buffer :which-key "kill buffer")

              "f"  '(:ignore t :which-key "file")
              "ff" '(find-file :which-key "find")
              "fs" '(save-buffer :which-key "save")

              "m"  '(:ignore t :which-key "mode")

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
        };

        ivy = {
          enable = true;
          demand = true;
          diminish = [ "ivy-mode" ];
          config = ''
            (ivy-mode 1)
            (setq ivy-use-virtual-buffers t
                  ivy-hight 20
                  ivy-count-format "(%d/%d) "
                  ivy-initial-inputs-alist nil)
          '';
          general = ''
            (general-nmap
              :prefix "SPC"
              "bb" '(ivy-switch-buffer :which-key "switch buffer")
              "fr" '(ivy-recentf :which-key "recent file"))
          '';
        };

        magit = {
          enable = true;

          general = ''
            (general-nmap
              :prefix "SPC"
              "g" '(:ignore t :which-key "Git")
              "gs" 'magit-status)
          '';
        };

        markdown-mode = {
          enable = true;
          command = [ "markdown-mode" "gfm-mode" ];
          mode = [
            ''("README\\.md\\'" . gfm-mode)''
            ''("\\.md\\'" . markdown-mode)''
            ''("\\.markdown\\'" . markdown-mode)''
          ];
        };

        nix = {
          enable = true;
        };

        nix-mode = {
          enable = true;
          mode = [ ''"\\.nix\\'"'' ];
          bindLocal = {
            nix-mode-map = {
              "C-i" = "nix-indent-line";
            };
          };
        };

        nix-prettify-mode = {
          enable = true;
          config = ''
            (nix-prettify-global-mode)
          '';
        };

        nix-drv-mode = {
          enable = true;
          mode = [ ''"\\.drv\\'"'' ];
        };

        projectile = {
          enable = true;
          after = [ "ivy" ];
          diminish = [ "projectile-mode" ];
          config = ''
            (projectile-mode 1)
            (progn
              (setq projectile-enable-caching t)
              (setq projectile-require-project-root nil)
              (setq projectile-completion-system 'ivy)
              (add-to-list 'projectile-globally-ignored-files ".DS_Store"))
          '';
          general = ''
            (general-nmap
              :prefix "SPC"
              "p"  '(:ignore t :which-key "Project")
              "pf" '(projectile-find-file :which-key "Find in project")
              "pl" '(projectile-switch-project :which-key "Switch project"))
          '';
        };

        protobuf-mode = {
          enable = true;
        };

        # Visually distinguish file-visiting windows from other types of
        # windows when using the Doom themes.
        solaire-mode = {
          enable = true;
          hook = [ "(after-init . solaire-global-mode)" ];
        };

        swiper = {
          enable = true;

          bindStar = {
            "\C-s" = "swiper";
          };

          general = ''
            (general-nmap
              :prefix "SPC"
              "ss" '(swiper :which-key "swiper"))
          '';
        };

        undo-tree = {
          enable = true;
          config = ''
            (global-undo-tree-mode)
          '';
        };

        which-key = {
          enable = true;
          diminish = [ "which-key-mode" ];
          config = ''
            (which-key-mode)
            (which-key-setup-side-window-right-bottom)
            (setq which-key-sort-order 'which-key-key-order-alpha
                  which-key-side-window-max-width 0.33
                  which-key-idle-delay 0.05)
          '';
        };

        yaml-mode = {
          enable = true;
          mode = [
            ''("\\.yml\\'" . yaml-mode)''
            ''("\\.yaml\\'" . yaml-mode)''
          ];
        };

        yasnippet = {
          enable = true;
          diminish = [ "yas-minor-mode" ];
          hook = [ "(lsp-mode . yas-minor-mode)" ];
          command = [ "yas-minor-mode" ];
          config = ''
            (yas-reload-all)
          '';
        };

        yasnippet-snippets = {
          enable = true;
          after = [ "yasnippet" ];
        };
      };
    };
  };
}
