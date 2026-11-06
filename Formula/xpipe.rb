class Xpipe < Formula
  desc "Split input and feed it into the given utility"
  homepage "https://www.netmeister.org/apps/xpipe.html"
  url "https://www.netmeister.org/apps/xpipe-2.2.tar.gz"
  sha256 "a381be1047adcfa937072dffa6b463455d1f0777db6bc5ea2682cd6321dc5add"
  license "BSD-2-Clause"

  livecheck do
    url "https://www.netmeister.org/apps/"
    regex(/href=.*?xpipe[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f9a3f0ae70ed0e8dc8366a2c6719052c0c1a7e3e95173c94d1b70feddfecb778"
  end

  on_linux do
    depends_on "libbsd"
  end


  def install
    inreplace "Makefile", "${PREFIX}/include/bsd", "#{formula_opt_include("libbsd")}/bsd"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "echo foo | xpipe -b 1 -J % /bin/sh -c 'cat >%'"
    assert_path_exists testpath/"1"
    assert_path_exists testpath/"2"
    assert_path_exists testpath/"3"
  end
end
