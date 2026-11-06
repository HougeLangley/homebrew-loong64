class Onioncat < Formula
  desc "VPN-adapter that provides location privacy using Tor or I2P"
  homepage "https://github.com/rahra/onioncat"
  url "https://github.com/rahra/onioncat/releases/download/v4.11.0/onioncat-4.11.0.tar.gz"
  sha256 "5413a02baa94ef4d986628e6ffc1d03e9dbb231db7bfa5a615cc0726c3aea686"
  license "GPL-3.0-only"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2bdcf38e57755bdebeaeade821eabcf7133e9a5155feb307762c49e541a064a9"
  end


  head do
    url "https://github.com/rahra/onioncat.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "tor"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"ocat", "-i", "fncuwbiisyh6ak3i.onion" # convert keybase's address to IPv6 address format
  end
end
