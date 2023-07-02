{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "gitui";
  version = "gpg-commit-signing";

  src = fetchFromGitHub {
    owner = "hendrikmaus";
    repo = pname;
    rev = version;
    sha256 = "0kh2sck24sp096zpw9jc3xgsva49v9920k6465q7123npm51bxln";
  };

  cargoSha256 = lib.fakeSha256;

  meta = with lib; {
    platforms = lib.platforms.linux;
  };
}