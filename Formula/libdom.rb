class Libdom < Formula
  desc "Implementation of the W3C DOM"
  homepage "https://www.netsurf-browser.org/projects/libdom/"
  url "https://download.netsurf-browser.org/libs/releases/libdom-0.4.2-src.tar.gz"
  sha256 "d05e45af16547014c2b0a3aecf3670fa13d419f505b3f5fc7ac8a1491fc30f3c"
  license "MIT"

  livecheck do
    url "https://download.netsurf-browser.org/libs/releases/"
    regex(/href=.*?libdom[._-]v?(\d+(?:\.\d+)+)[._-]src\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f1862e6dc4a6cfcecc771ea635034842997d3a4c98c2a5e06e06042873fcc5eb"
  end

  depends_on "netsurf-buildsystem" => :build
  depends_on "pkgconf" => [:build, :test]
  depends_on "libhubbub"
  depends_on "libparserutils"
  depends_on "libwapcaplet"

  uses_from_macos "expat"

  def install
    args = %W[
      NSSHARED=#{Formula["netsurf-buildsystem"].opt_pkgshare}
      PREFIX=#{prefix}
    ]

    system "make", "install", "COMPONENT_TYPE=lib-shared", *args
  end

  test do
    (testpath/"test.c").write <<~C
      #include <dom/dom.h>
      #include <stdint.h>

      int main() {
        const uint8_t *data = (const uint8_t *)"test";
        dom_string *str;
        dom_exception ex = dom_string_create(data, 4, &str);
        return ex == DOM_NO_ERR ? 0 : 1;
      }
    C

    flags = shell_output("pkgconf --cflags --libs libdom").chomp.split
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
