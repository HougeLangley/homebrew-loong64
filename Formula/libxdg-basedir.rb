class LibxdgBasedir < Formula
  desc "C implementation of the XDG Base Directory specifications"
  homepage "https://github.com/devnev/libxdg-basedir"
  url "https://github.com/devnev/libxdg-basedir/archive/refs/tags/libxdg-basedir-1.2.3.tar.gz"
  sha256 "ff30c60161f7043df4dcc6e7cdea8e064e382aa06c73dcc3d1885c7d2c77451d"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d5744d8bed5f18c207df31e2765e00da73d53af91568c7741cd50d75833ab471"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh"
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <basedir.h>
      int main() {
        xdgHandle handle;
        if (!xdgInitHandle(&handle)) return 1;
        xdgWipeHandle(&handle);
        return 0;
      }
    CPP
    system ENV.cc, "test.cpp", "-L#{lib}", "-lxdg-basedir", "-o", "test"
    system "./test"
  end
end
