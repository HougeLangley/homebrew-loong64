class Swfmill < Formula
  desc "Processor of xml2swf and swf2xml"
  homepage "https://www.swfmill.org/"
  url "https://www.swfmill.org/releases/swfmill-0.3.6.tar.gz"
  sha256 "db24f63963957faec02bb14b8b61cdaf7096774f8cfdeb9d3573e2e19231548e"
  license "GPL-2.0-only"
  revision 1


  # adobe flash player EOL 12/31/2020, https://www.adobe.com/products/flashplayer/end-of-life-alternative.html
  deprecate! date: "2025-01-12", because: :unmaintained
  disable! date: "2026-01-12", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "628f1cde2c29097e91cecd9c8eb1bb116f79fe81c94af640cdb8a4a8e3363f1f"
  end

  depends_on "pkgconf" => :build
  depends_on "freetype"
  depends_on "libpng"

  uses_from_macos "libxml2"
  uses_from_macos "libxslt"
  uses_from_macos "zlib"

  deny_network_access!

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

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    false
  end
end
