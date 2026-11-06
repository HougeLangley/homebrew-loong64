class Icu4cAT78 < Formula
  desc "C/C++ and Java libraries for Unicode and globalization"
  homepage "https://icu.unicode.org/home"
  url "https://github.com/unicode-org/icu/releases/download/release-78.3/icu4c-78.3-sources.tgz"
  sha256 "3a2e7a47604ba702f345878308e6fefeca612ee895cf4a5f222e7955fabfe0c0"
  license "Unicode-3.0"
  revision 1
  compatibility_version 1

  livecheck do
    url :stable
    regex(/^release[._-]v?(78(?:[.-]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("-", ".") }
    end
  end


  keg_only :versioned_formula

  deprecate! date: "2026-10-30", because: :versioned_formula
  disable! date: "2027-10-30", because: :versioned_formula

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e55e96381c6a2f91e3562bbb7c90c30f616a03b7998ca06c99d0f21e23cf6afc"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %w[
      --disable-samples
      --disable-tests
      --enable-static
      --with-library-bits=64
    ]

    cd "source" do
      system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
      system "make"
      system "make", "install"
    end

    inreplace [bin/"icu-config", *lib.glob("pkgconfig/icu-*.pc")], prefix, opt_prefix
  end

  test do
    if File.exist? "/usr/share/dict/words"
      system bin/"gendict", "--uchars", "/usr/share/dict/words", "dict"
    else
      (testpath/"hello").write "hello\nworld\n"
      system bin/"gendict", "--uchars", "hello", "dict"
    end
  end
end
