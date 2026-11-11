class ArpScan < Formula
  desc "ARP scanning and fingerprinting tool"
  homepage "https://github.com/royhills/arp-scan"
  url "https://github.com/royhills/arp-scan/releases/download/1.10.0/arp-scan-1.10.0.tar.gz"
  sha256 "a078fe8711ecbb8b99121c3d8be26ae7e7f339f11010ef61318be4f33394d012"
  license all_of: [
    "GPL-3.0-or-later",
    "BSD-3-Clause", # mt19937ar.c
    "ISC", # strlcpy.c (Linux)
  ]


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7e19938631105ce6c59af54bd0a721006b17be41180e9d5f082f5af2c2012dfa"
  end

  head do
    url "https://github.com/royhills/arp-scan.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  uses_from_macos "libpcap"

  conflicts_with "arp-scan-rs", because: "both install `arp-scan` binaries"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"arp-scan", "-V"
  end
end
