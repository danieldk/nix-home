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

  vendorSha256 = "1cji5lxcikg917jvgx6dgkkm20j7dqlyq2abhpf9q8r0ladsspyy";

  postInstall = ''
    find $out/bin -type f ! -name 'gopls' -delete
  '';
}
