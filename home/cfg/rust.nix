{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #cargo
    #rust-analyzer
    #rustfmt
    rustup
  ];

  programs.emacs.init.usePackage = {
    cargo = {
      enable = true;
      general = ''
        (general-nmap
          :keymaps 'rust-mode-map
          :prefix "SPC m"
          "c." 'cargo-process-repeat
          "cC" 'cargo-process-clean
          "cX" 'cargo-process-run-example
          "cc" 'cargo-process-build
          "cd" 'cargo-process-doc
          "ce" 'cargo-process-bench
          "cf" 'cargo-process-current-test
          "cf" 'cargo-process-fmt
          "ci" 'cargo-process-init
          "cn" 'cargo-process-new
          "co" 'cargo-process-current-file-tests
          "cs" 'cargo-process-search
          "cu" 'cargo-process-update
          "cx" 'cargo-process-run
          "t"  'cargo-process-test)
      '';
    };

    lsp-mode = {
      hook = [
        "(rust-mode . lsp)"
      ];

      config = ''
        (setq lsp-rust-server 'rust-analyzer)
      '';
    };

    rust-mode = {
      enable = true;
      mode = [ ''"\\.rs\\'"'' ];
      config = ''
        (setq rust-format-on-save t)
      '';
    };
  };
}
