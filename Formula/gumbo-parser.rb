class GumboParser < Formula
  desc "C99 library for parsing HTML5"
  homepage "https://codeberg.org/gumbo-parser/gumbo-parser"
  url "https://codeberg.org/gumbo-parser/gumbo-parser/archive/0.14.1.tar.gz"
  sha256 "ba5d13b9b508ec693613b3b61518163aced38f8e885f7e28dc047348a4e61365"
  license "Apache-2.0"
  compatibility_version 2


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "382ffdef22f8619badafe2e7ff23b8142996dd53f08311a1434c28f86fb37717"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    system "./autogen.sh"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "gumbo.h"

      int main() {
        GumboOutput* output = gumbo_parse("<h1>Hello, World!</h1>");
        gumbo_destroy_output(&kGumboDefaultOptions, output);
        return 0;
      }
    CPP
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lgumbo", "-o", "test"
    system "./test"
  end
end
