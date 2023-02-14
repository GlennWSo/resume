with  (import <nixpkgs> {}) ;



mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    
    nativeBuildInputs = [
        buildPackages.nodePackages.cspell
        buildPackages.texlive.combined.scheme-medium
        buildPackages.pandoc
        buildPackages.marktext
    ];
    
    name = "doc tools";
    shellHook = " echo Entering documentation shell";
}
