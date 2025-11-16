{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
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
            version = "0.15";

            src = pythonPackages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-1hkTmxuakqkqVs0vJKT7Mb8QobdcKWjY/o8O069dZM4=";
            };

            pyproject = true;
            build-system = [ pythonPackages.setuptools-scm ];

            propagatedBuildInputs = with pythonPackages; [
              packaging
              toml
            ];
          };
        };
      }
    );
}
