class Cheops < Formula
  desc "CHEss OPponent Simulator"
  homepage "https://logological.org/cheops"
  url "https://files.nothingisreal.com/software/cheops/cheops-1.3.tar.bz2"
  mirror "https://github.com/logological/cheops/releases/download/1.3/cheops-1.3.tar.bz2"
  sha256 "a3ce2e94f73068159827a1ec93703b5075c7edfdf5b0c1aba4d71b3e43fe984e"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3e62c4c010cfe83e450d63c16ba131c381e492e38502b74bd7354aec2167e26a"
  end

  livecheck do
    url "https://files.nothingisreal.com/software/cheops/"
    regex(/href=.*?cheops[._-]v?(\d+(?:\.\d+)+)\.t/i)
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
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"cheops", "--version"
  end
end
