class Sqtop < Formula
  desc "Display information about active connections for a Squid proxy"
  homepage "https://github.com/paleg/sqtop"
  url "https://github.com/paleg/sqtop/archive/refs/tags/v2015-02-08.tar.gz"
  sha256 "eae4c8bc16dbfe70c776d990ecf14328acab0ed736f0bf3bd1647a3ac2f5e8bf"
  license "GPL-2.0-only"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e496692c424a1b81bde95d5afac195a900023098adf1adb33407ae35563a1adb"
  end


  uses_from_macos "ncurses"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sqtop --help")
  end
end
