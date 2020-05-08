{ stdenv, fetchFromGitHub, buildGoModule }:

buildGoModule {
  name = "gopls";
  version = "2020-05-02";

  src = fetchFromGitHub {
    owner = "golang";
    repo = "tools";
    rev = "26f46d2f7ef8d36fd8840d0a2d8e1a7ff1dad367";
    sha256 = "1k84bzzhk4armf7vyyakni2gwjbq3cl8is71l2wdbn3mhfrlr1s7";
  };

  modRoot = "gopls";

  modSha256 = "1p0g28i707xyxz1g6hb56qlc4km9ik7vjky0v80hw7n73vzs5mr9";

  postInstall = ''
    find $out/bin -type f ! -name 'gopls' -delete
  '';
}
