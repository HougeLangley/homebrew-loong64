class Snowball < Formula
  desc "Stemming algorithms"
  homepage "https://snowballstem.org"
  url "https://github.com/snowballstem/snowball/archive/refs/tags/v3.1.1.tar.gz"
  sha256 "d8714aa91ed4333654708472a7a98b529c867a8f99b05c5e66febf4ca72c44c7"
  license "BSD-3-Clause"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "52ece7b65667a5f7e1c6d9c39962f7341b8776227e096fa1e878ac5d31cd0959"
  end

  def install
    system "make"

    lib.install "libstemmer.a"
    include.install Dir["include/*"]
    pkgshare.install "examples"
  end

  test do
    (testpath/"test.txt").write("connection")
    cp pkgshare/"examples/stemwords.c", testpath
    system ENV.cc, "stemwords.c", "-L#{lib}", "-lstemmer", "-o", "test"
    assert_equal "connect\n", shell_output("./test -i test.txt")
  end
end
