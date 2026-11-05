class Sipsak < Formula
  desc "SIP Swiss army knife"
  homepage "https://github.com/nils-ohlmeier/sipsak/"
  url "https://github.com/nils-ohlmeier/sipsak/releases/download/0.9.8.1/sipsak-0.9.8.1.tar.gz"
  sha256 "c6faa022cd8c002165875d4aac83b7a2b59194f0491802924117fc6ac980c778"
  license "GPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "36e0b3bfbbf53a5f2c69f1ec2ceb823ba04b89636612590af58a8abf0271cd05"
  end

  revision 1


  depends_on "openssl@4"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.append "CFLAGS", "-std=gnu89"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system bin/"sipsak", "-V"
  end
end
