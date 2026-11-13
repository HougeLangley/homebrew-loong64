class E2tools < Formula
  desc "Utilities to read, write, and manipulate files in ext2/3/4 filesystems"
  homepage "https://e2tools.github.io/"
  url "https://github.com/e2tools/e2tools/releases/download/v0.1.2/e2tools-0.1.2.tar.gz"
  sha256 "b19593bbfc85e9c14c0d2bc8525887901c8fe02588c76df60ab843bf0573c4a2"
  license "GPL-2.0-only"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "847f615eafe5b9938916d1629706e9ccc11d9b3fb339269cf23e8b3ad0b9b792"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "e2fsprogs"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    system Formula["e2fsprogs"].opt_sbin/"mkfs.ext2", "test.raw", "1024"
    assert_match "lost+found", shell_output("#{bin}/e2ls test.raw")
  end
end
