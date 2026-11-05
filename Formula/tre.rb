class Tre < Formula
  desc "Lightweight, POSIX-compliant regular expression (regex) library"
  homepage "https://github.com/laurikari/tre"
  url "https://github.com/laurikari/tre/releases/download/v0.9.0/tre-0.9.0.tar.gz"
  sha256 "f57f5698cafdfe516d11fb0b71705916fe1162f14b08cf69d7cf86923b5a2477"
  license "BSD-2-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a91c694fc589d54838110de2ad9fa21be7180f8cc50813110e4b780d913ee631"
  end


  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "brow", pipe_output("#{bin}/agrep -1 brew", "brow", 0)
  end
end
