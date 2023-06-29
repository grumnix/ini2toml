{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonPackages = pkgs.python310Packages;
      in {
        packages = rec {
          default = ini2toml;

          ini2toml = pythonPackages.buildPythonPackage rec {
            pname = "ini2toml";
            version = "0.12";

            src = pythonPackages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-1FnVNYeOD7lc0LDDiJ8Fa3/zkD6C6RnTlOn4W3Fn9ew=";
            };

            propagatedBuildInputs = with pythonPackages; [
              packaging
              toml
            ];
          };
        };
      }
    );
}
