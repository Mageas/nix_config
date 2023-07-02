{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "gitui";
  version = "gpg-commit-signing";

  src = fetchFromGitHub {
    owner = "hendrikmaus";
    repo = pname;
    rev = version;
    sha256 = "sha256-zAywvg5/VcRTiR64wEXUy4YymTwAUBKw26X4Pvgsa2k=";
  };

  cargoSha256 = "sha256-zAywvg5/VcRTiR64wEXUy4YymTwAUBKw26X4Pvgsa2k=";

  meta = with lib; {
    platforms = lib.platforms.linux;
  };
}