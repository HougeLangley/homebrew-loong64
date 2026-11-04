class Dnswire < Formula
  desc "Library for encoding/decoding different DNS encapsulations"
  homepage "https://codeberg.org/DNS-OARC/dnswire"
  url "https://www.dns-oarc.net/files/dnswire/dnswire-0.5.1.tar.gz"
  sha256 "b0b52b95e20eda768256794097080b5f5725d9fe841ef03568c51987b02673b4"
  license "GPL-3.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "27078ee198a52dce0720e404fe7404462f9dc8ff463fab6653e5e42601355530"
  end

  depends_on "pkgconf" => [:build, :test]
  depends_on "libuv"
  depends_on "protobuf-c"
  depends_on "tinyframe"

  deny_network_access!

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <dnswire/version.h>
      #include <stdio.h>

      int main(int argc, char *argv[]) {
        printf("Version %s", DNSWIRE_VERSION_STRING);
        return 0;
      }
    C
    flags = shell_output("pkgconf --cflags --libs libdnswire").chomp.split
    system ENV.cc, "test.c", "-o", "test", *flags
    assert_match version.to_s, shell_output("./test")
  end
end
