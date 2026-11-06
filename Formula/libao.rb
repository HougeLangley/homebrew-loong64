class Libao < Formula
  desc "Cross-platform Audio Library"
  homepage "https://www.xiph.org/ao/"
  url "https://gitlab.xiph.org/xiph/libao/-/archive/1.2.2/libao-1.2.2.tar.gz"
  sha256 "df8a6d0e238feeccb26a783e778716fb41a801536fe7b6fce068e313c0e2bf4d"
  license "GPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "68e01335f770899dbc48037704228cb1034e4bcd6babd8e5c2ef7d9f5ee3a282"
  end

  compatibility_version 1
  head "https://gitlab.xiph.org/xiph/libao.git", branch: "main"


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV["AUTOMAKE_FLAGS"] = "--include-deps"
    system "./autogen.sh"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--enable-static", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <ao/ao.h>
      int main() {
        ao_initialize();
        return 0;
      }
    CPP
    system ENV.cc, "test.cpp", "-I#{include}", "-L#{lib}", "-lao", "-o", "test"
    system "./test"
  end
end
