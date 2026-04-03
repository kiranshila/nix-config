{
  config,
  pkgs,
  ...
}: let
  bosl2 = pkgs.fetchFromGitHub {
    owner = "BelfrySCAD";
    repo = "BOSL2";
    rev = "fb625bf243af208f4a15747b99e5e1c96a39ea9f";
    sha256 = "sha256-7faq+PkZP/E8VLxun7yQPXNUZcRQFzM0FLLPprgyu/c=";
  };
in {
  # OpenSCAD, the binary
  home.packages = with pkgs; [(config.lib.nixGL.wrap openscad-unstable)];

  # Create the library directory and symlink BOSL2
  home.file.".local/share/OpenSCAD/libraries/BOSL2".source = bosl2;
}
