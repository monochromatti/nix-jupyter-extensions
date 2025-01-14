{
  description = "A flake to test default.nix build using flake-parts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      perSystem = { pkgs, inputs', system, lib, ... }:
        let
          python = pkgs.python3;
          lib = pkgs.lib;
        in
        {
          packages = {
            jupyterlab-widgets = import ./jupyterlab-widgets {
              inherit lib python;
            };

            jupyterlab-indent-guides = import ./jupyterlab-indent-guides {
              inherit lib python;
            };

            jupyterlab-unfold = import ./jupyterlab-unfold {
              inherit lib python;
            };

            jupyterlab-code-formatter = import ./jupyterlab-code-formatter {
              inherit lib python;
            };

            jupyterlab-search-replace = import ./jupyterlab-search-replace {
              inherit lib python;
            };
          };
        };
    };
}
