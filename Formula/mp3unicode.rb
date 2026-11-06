class Mp3unicode < Formula
  desc "Command-line utility to convert mp3 tags between different encodings"
  homepage "https://mp3unicode.sourceforge.net/"
  license "GPL-2.0-only"

  stable do
    url "https://github.com/alonbl/mp3unicode/releases/download/mp3unicode-1.2.1/mp3unicode-1.2.1.tar.bz2"
    sha256 "375b432ce784407e74fceb055d115bf83b1bd04a83b95256171e1a36e00cfe07"

    # Backport support for taglib 2
    patch do
      url "https://github.com/alonbl/mp3unicode/commit/a4958c3b5cbfd7464a2d05f5212c0eb21ddf7210.patch?full_index=1"
      sha256 "7cdaf35bb09b5d4ee9c3ef4703bed415ed9df8be5e64f06dc7b4654739e58ab4"
      type :backport
      resolves "https://github.com/alonbl/mp3unicode/pull/5"
    end
  end

  livecheck do
    url :stable
    regex(/^mp3unicode-v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "bb6f4342ae38fd4f585c3f51cbd402c664feedcfc095e05d20f9879cb24a306e"
  end

  head do
    url "https://github.com/alonbl/mp3unicode.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "taglib"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.append "ICONV_LIBS", "-liconv" if OS.mac?
    ENV.append "CXXFLAGS", "-std=c++17"

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"mp3unicode", "-s", "ASCII", "-w", test_fixtures("test.mp3")
  end
end
