{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
            tools = with pkgs; [
              pandoc
              nodePackages.cspell
              marktext
              nodePackages.vscode-langservers-extracted
              zola
              wkhtmltopdf-bin

            ];
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/reference/options/
                  packages = tools;
                  env = {
                    PLAYWRIGHT_BROWSERS_PATH=pkgs.playwright-driver.browsers;
                  };

                  processes.zola-serve.exec = "zola serve"; 
                  enterShell = ''
                    hello
                  '';
                }
              ];
            };
          });
    };
}
