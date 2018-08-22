{ stdenv, fetchFromGitHub, fetchpatch, autoreconfHook }:

stdenv.mkDerivation rec {
  name = "numactl-${version}";
  version = "2.0.12";

  src = fetchFromGitHub {
    owner = "numactl";
    repo = "numactl";
    rev = "v${version}";
    sha256 = "0crhpxwakp0gvd7wwpbkfd3brnrdf89lkbf03axnbrs0b6kaygg2";
  };

  nativeBuildInputs = [ autoreconfHook ];

  patches = stdenv.lib.optional stdenv.hostPlatform.isMusl (fetchpatch {
      url = https://git.alpinelinux.org/cgit/aports/plain/testing/numactl/musl.patch?id=0592b128c71c3e70d493bc7a13caed0d7fae91dd;
      sha256 = "080b0sygmg7104qbbh1amh3b322yyiajwi2d3d0vayffgva0720v";
    });

  meta = with stdenv.lib; {
    description = "Library and tools for non-uniform memory access (NUMA) machines";
    homepage = http://oss.sgi.com/projects/libnuma/;
    license = licenses.gpl2;
    platforms = [ "i686-linux" "x86_64-linux" "aarch64-linux" ];
    maintainers = with maintainers; [ wkennington ];
  };
}
