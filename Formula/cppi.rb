class Cppi < Formula
  desc "Indent C preprocessor directives to reflect their nesting"
  homepage "https://www.gnu.org/software/cppi/"
  url "https://ftpmirror.gnu.org/cppi/cppi-1.18.tar.xz"
  mirror "https://ftp.gnu.org/gnu/cppi/cppi-1.18.tar.xz"
  sha256 "12a505b98863f6c5cf1f749f9080be3b42b3eac5a35b59630e67bea7241364ca"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a361fcb5b79699810c156643977467455085e94799ba47e9502b22a88fbce787"
  end


  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    test = <<~C
      #ifdef TEST
      #include <homebrew.h>
      #endif
    C
    assert_equal <<~C, pipe_output(bin/"cppi", test, 0)
      #ifdef TEST
      # include <homebrew.h>
      #endif
    C
  end
end
