{ pkgs, ...}:

{
  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];

  programs.emacs.init.usePackage = {
    latex = {
      enable = true;
      after = [ "tex" ];
      hook = [
        "(LaTeX-mode . reftex-mode)"
      ];
      general = ''
        (general-nmap
          :keymaps 'LaTeX-mode-map
          :prefix "SPC m"
          "\\" '(TeX-insert-macro :which-key "insert macro")
          "-"  '(TeX-recenter-output-buffer :which-key "recenter output buffer")
          "%"  '(TeX-comment-or-uncomment-paragraph :which-key "(un)comment paragraph")
          ";"  '(TeX-comment-or-uncomment-region :which-key "(un)comment region")
          "a"  '(TeX-command-run-all :which-key "run all")
          "cc"  `(reftex-citation :which-key "cite")
          "e"  '(LaTeX-environment :which-key "insert environment")
          "m"  '(TeX-insert-macro :which-key "insert macro")
          "p"  '(preview-buffer :which-key "preview")
          "rl" '(reftex-label :which "add label")
          "rr" '(reftex-reference :which "refer label")
          "v"  '(TeX-view :which-key "view"))
        ''; 
    };

    tex-site = {
      enable = true;
      package = _: pkgs.auctex;
      mode = [
        ''("\\.tex\\'" . TeX-latex-mode)''
      ];

      config = ''
        (setq TeX-parse-self t
	            TeX-auto-save t
              reftex-plug-into-AUCTeX t)
      '';
    };
  };
}
