{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    # devenv.url = "github:cachix/devenv/v0.6.3";
  };

  nixConfig = {
    # extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    # extra-substituters = "https://devenv.cachix.org";
  };

  outputs = {
    nixpkgs,
    # devenv,
    systems,
    ...
  }: let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    devShells =
      forEachSystem
      (system: let
        pkgs = import nixpkgs {
          inherit system;
          config.permittedInsecurePackages = [
            "openssl-1.1.1w" # for "wkhtmltopdf-bin"
          ];
        };
        tools = with pkgs; [
          pandoc
          texliveSmall
          nodePackages.cspell
          typos
          marktext
          nodePackages.vscode-langservers-extracted
          zola
          bore-cli
          wkhtmltopdf-bin
          python311
        ];
      in {
        default = pkgs.mkShell {
          name = "ssg env";
          buildInputs = tools;
        };
      });
  };
}
