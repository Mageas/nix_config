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

  cargoSha256 = "1i96d895xrqz6k9f7x23k1lsavifg067v0x86w30pgxpjnacsk6j";

  meta = with lib; {
    platforms = lib.platforms.linux;
  };
}