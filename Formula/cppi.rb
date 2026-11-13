class Cppi < Formula
  desc "Indent C preprocessor directives to reflect their nesting"
  homepage "https://www.gnu.org/software/cppi/"
  url "https://ftpmirror.gnu.org/cppi/cppi-1.18.tar.xz"
  mirror "https://ftp.gnu.org/gnu/cppi/cppi-1.18.tar.xz"
  sha256 "12a505b98863f6c5cf1f749f9080be3b42b3eac5a35b59630e67bea7241364ca"
  license "GPL-3.0-or-later"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5c2e322d0113bbf2d0054763f16a4259a8cdbfb0bb9c4af871e61b6412f74cec"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
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
