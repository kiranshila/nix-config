{
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  libpng,
  openexr,
  jasper,
  lcms,
  fmt,
  imgui,
  spdlog,
  nlohmann_json,
  libraw,
  opencolorio,
  openimageio,
  minizip-ng,
  exiv2,
  glfw,
  glew,
  ...
}: let
  openimageioWithRaw = openimageio.overrideAttrs (prev: {
    buildInputs = prev.buildInputs ++ [libraw];
  });
in
  stdenv.mkDerivation rec {
    pname = "filmvert";
    version = "1.1.1";

    src = fetchFromGitHub {
      owner = "montoyatim01";
      repo = "Filmvert";
      tag = "v${version}";
      hash = "sha256-Ha0ZY1N3eh5Cns+0WZc8DL2QF4phzo6DdWn/GyT+zRI=";
    };

    nativeBuildInputs = [
      cmake
      pkg-config
    ];

    cmakeFlags = [
      "-DCMAKE_BUILD_TYPE=Release"
    ];

    buildInputs = [
      libpng
      openexr
      jasper
      lcms
      fmt
      imgui
      spdlog
      nlohmann_json
      libraw
      opencolorio
      openimageioWithRaw
      minizip-ng
      exiv2
      glfw
      glew
    ];
  }
