{
  config,
  pkgs,
  ...
}: let
  bosl2 = pkgs.fetchFromGitHub {
    owner = "BelfrySCAD";
    repo = "BOSL2";
    rev = "master";
    sha256 = "sha256-i8N3L0W/lP4Du+3VCOx8gN594wJDRmikVei/fWGW2PU=";
  };
in {
  # OpenSCAD, the binary
  home.packages = with pkgs; [(config.lib.nixGL.wrap openscad-unstable)];

  # Create the library directory and symlink BOSL2
  home.file.".local/share/OpenSCAD/libraries/BOSL2".source = bosl2;
}
