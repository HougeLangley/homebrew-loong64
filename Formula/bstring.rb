class Bstring < Formula
  desc "Fork of Paul Hsieh's Better String Library"
  homepage "https://mike.steinert.ca/bstring/"
  url "https://github.com/msteinert/bstring/releases/download/v1.1.1/bstring-1.1.1.tar.xz"
  sha256 "caaa9770c763dfc31a34e86d4afe50a9d3b3e6c43f9b410fa4f3130192ea47f1"
  license "BSD-3-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6964c5de5f76dc47fee95a037cb594a238be1f7314b6d6b6c8e7687203d84562"
  end

  head "https://github.com/msteinert/bstring.git", branch: "main"



  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "check" => :test

  deny_network_access!

  def install
    args = %w[-Denable-docs=false -Denable-tests=false]
    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
    pkgshare.install "tests"
  end

  test do
    cp pkgshare/"tests/bstest.c", "."

    check = Formula["check"]
    ENV.append_to_cflags "-I#{include} -I#{check.opt_include}"
    ENV.append "LDFLAGS", "-L#{lib} -L#{check.opt_lib}"
    ENV.append "LDLIBS", "-lbstring -lcheck"

    system "make", "bstest"
    system "./bstest"
  end
end
