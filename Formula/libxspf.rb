class Libxspf < Formula
  desc "C++ library for XSPF playlist reading and writing"
  homepage "https://libspiff.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/libspiff/Sources/1.2.1/libxspf-1.2.1.tar.bz2"
  sha256 "ce78a7f7df73b7420b6a54b5766f9b74e396d5e0b37661c9a448f2f589754a49"
  license "BSD-3-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a6fe60f87c87fae7ecbf40686b2ccac36beadd6328bd6bf94c0789a3fde31d04"
  end


  depends_on "pkgconf" => :build
  depends_on "uriparser"

  uses_from_macos "expat"

  resource "check.cpp" do
    url "https://gitlab.xiph.org/xiph/libxspf/-/raw/master/examples/check/check.cpp"
    sha256 "fdd1e586c4f5b724890eb2ce6a3cd3b9910a8e74ee454fe462ba8eb802f7c4b9"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # src/XspfReader.cpp:65:3: error: uriparser 0.7.2 or later is required
    # https://sourceforge.net/p/libspiff/bugs/6/
    inreplace "src/XspfReader.cpp",
              "#if (URI_VER_MINOR < 7) || ((URI_VER_MINOR == 7) && (URI_VER_RELEASE < 2))",
              "#if (URI_VER_MAJOR == 0) && ((URI_VER_MINOR < 7) || ((URI_VER_MINOR == 7) && (URI_VER_RELEASE < 2)))"

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-test", *std_configure_args
    system "make", "install"
  end

  test do
    resource("check.cpp").stage(testpath)
    flags = "-I#{include} -L#{lib} -lxspf".split
    system ENV.cxx, "check.cpp", "-o", "check", *flags
  end
end
