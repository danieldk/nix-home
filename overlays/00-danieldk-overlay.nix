self: super: {
  danieldk = import (self.fetchFromGitHub {
    owner = "danieldk";
    repo = "nixpkgs";
    rev = "known-good";
    sha256 = "0slcnhdh081cqflc3g17sfl0q628yf2dfpm8vxs672x9nvj0pyq5";
  }) {};
}
