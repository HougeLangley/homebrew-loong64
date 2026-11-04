class Libwps < Formula
  desc "Library to import files in MS Works format"
  homepage "https://libwps.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/libwps/libwps/libwps-0.4.14/libwps-0.4.14.tar.xz"
  sha256 "365b968e270e85a8469c6b160aa6af5619a4e6c995dbb04c1ecc1b4dd13e80de"
  license any_of: ["LGPL-2.1-or-later", "MPL-2.0"]

  livecheck do
    url :stable
    regex(%r{url=.*?/libwps(?:/|[._-])v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0a613ccbe158f56e724ceece37cb9b8e0f98e6d9b600bf0cc527d26bcd8f01c5"
  end

  depends_on "pkgconf" => :build
  depends_on "librevenge"

  def install
    # Installing Doxygen docs trips up make install
    system "./configure", "--without-docs", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <libwps/libwps.h>
      int main() {
        return libwps::WPS_OK;
      }
    CPP
    system ENV.cc, "test.cpp", "-o", "test",
                  "-I#{include}/libwps-0.4",
                  "-I#{formula_opt_include("librevenge")}/librevenge-0.0",
                  "-L#{lib}", "-lwps-0.4",
                  "-L#{formula_opt_lib("librevenge")}", "-lrevenge-0.0"
    system "./test"
  end
end
