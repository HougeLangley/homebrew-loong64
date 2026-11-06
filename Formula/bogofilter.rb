class Bogofilter < Formula
  desc "Mail filter via statistical analysis"
  homepage "https://bogofilter.sourceforge.io"
  url "https://downloads.sourceforge.net/project/bogofilter/bogofilter-stable/bogofilter-1.2.5.tar.xz"
  sha256 "3248a1373bff552c500834adbea4b6caee04224516ae581fb25a4c6a6dee89ea"
  license all_of: ["GPL-2.0-or-later", "GPL-3.0-or-later"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "550686bc70381f4c5b4d27ee80df245023aa40eebf9341b582bc7928a99c8fc9"
  end

  livecheck do
    url "https://sourceforge.net/projects/bogofilter/rss?path=/bogofilter-stable"
  end


  uses_from_macos "sqlite"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules",
                          "--with-database=sqlite3",
                          *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"bogofilter", "--version"
  end
end
