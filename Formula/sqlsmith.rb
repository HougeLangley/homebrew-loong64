class Sqlsmith < Formula
  desc "Random SQL query generator"
  homepage "https://github.com/anse1/sqlsmith"
  # TODO: Switch to the release tarball when the next release is made
  url "https://github.com/anse1/sqlsmith/archive/refs/tags/v1.5.tar.gz"
  sha256 "828ee3e816b94848627e8132d32ade6339dbcbba5469437dc9a6a8335d4dab23"
  license "GPL-3.0-only"
  revision 1
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7e6d3e6ee61c9b2e8e08e95f2e31c639570d8b80330e69e54ee9466cd6ff1f44"
  end

  head "https://github.com/anse1/sqlsmith.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end



  depends_on "autoconf" => :build
  depends_on "autoconf-archive" => :build # required for AX_CXX_COMPILE_STDCXX_17
  depends_on "automake" => :build

  depends_on "pkgconf" => :build
  depends_on "libpq"
  depends_on "libpqxx"

  uses_from_macos "sqlite"

  def install
    ENV.append_to_cflags "-DNDEBUG"
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    cmd = %W[
      #{bin}/sqlsmith
      --sqlite
      --max-queries=100
      --verbose
      --seed=1
      2>&1
    ].join(" ")
    output = shell_output(cmd)

    assert_match "Loading tables...done.", output
    assert_match "Loading columns and constraints...done.", output
    assert_match "Generating indexes...done.", output
    assert_match "queries: 100", output
    assert_match "impedance report:", output
  end
end
