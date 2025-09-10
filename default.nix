let
  # Change to this if you want to use your configured channel
  #  nixpkgs = <nixpkgs>;

  # Otherwise, use nixos-25.05 from Sept 2025:
  nixpkgs = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/7c815e5.tar.gz";
    sha256 = "0nysdk5i3arc88k5ibx3rgl0ihd7km52hr61l8qx280nf7sjf6zm";
  };

  pkgs = (import nixpkgs {});

  tex = pkgs.texliveMedium.withPackages
    ( ps: with ps;
      [
        # Customize packages you want to include here.
        # You can search for them at
        #   https://search.nixos.org/packages
        wrapfig amsmath ulem hyperref capt-of
        setspace tkz-euclide
        stackengine tabstackengine
      ]);

in
  pkgs.stdenvNoCC.mkDerivation {
    name = "shell";
    dontUnpack = "true";
    buildInputs = [ tex pkgs.gnumake ];

    # prevent nixpkgs from being garbage-collected
    inherit nixpkgs;

    builder = builtins.toFile "builder.sh" ''
      source $stdenv/setup
      eval $shellHook

      {
        echo "#!$SHELL"
        for var in PATH SHELL nixpkgs
        do echo "declare -x $var=\"''${!var}\""
        done
        echo "declare -x PS1='\n\033[1;32m[nix-shell:\w]\$\033[0m '"
        echo "exec \"$SHELL\" --norc --noprofile \"\$@\""
      } > "$out"

      chmod a+x "$out"
    '';
  }
