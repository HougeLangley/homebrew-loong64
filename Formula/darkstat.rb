class Darkstat < Formula
  desc "Network traffic analyzer"
  homepage "https://unix4lyfe.org/darkstat/"
  url "https://github.com/emikulic/darkstat/archive/refs/tags/3.0.722.tar.gz"
  sha256 "5c8e66d4c478b6d7e58f4c842823a09125509bf6851017ff70e32b32ce95b01b"
  license all_of: [
    "GPL-2.0-only",
    "ISC",
    "BSD-2-Clause", # tree.h
    "BSD-3-Clause", # queue.h
  ]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2396cda29985ed216a9eca783dcc8688e863e81e3e581b31195fbc13a1a329d8"
  end

  head "https://github.com/emikulic/darkstat.git", branch: "master"


  depends_on "autoconf" => :build
  depends_on "automake" => :build

  uses_from_macos "libpcap"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Patch reported to upstream on 2017-10-08
  # Work around `redefinition of clockid_t` issue on 10.12 SDK or newer
  patch do
    file "Patches/darkstat/clock_gettime.patch"
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

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    system sbin/"darkstat", "--verbose", "-r", test_fixtures("test.pcap")
  end
end
