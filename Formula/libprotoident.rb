class Libprotoident < Formula
  desc "Performs application layer protocol identification for flows"
  homepage "https://github.com/LibtraceTeam/libprotoident"
  url "https://github.com/LibtraceTeam/libprotoident/archive/refs/tags/2.0.15-2.tar.gz"
  sha256 "2b43a492fe1d7ada2e7b7b164c8e35220b35bf816bd971c7f77decc74b69801e"
  license "LGPL-3.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "024231d472b8a65f42e38539294a7e22049b8dcc08c5f5267a09ad53ed2678b5"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libflowmanager"
  depends_on "libtrace"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <libprotoident.h>

      int main() {
        lpi_init_library();
        return 0;
      }
    CPP
    system ENV.cc, "test.cpp", "-L#{lib}", "-lprotoident", "-o", "test"
    system "./test"
  end
end
