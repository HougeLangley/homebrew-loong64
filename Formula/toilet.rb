class Toilet < Formula
  desc "Color-based alternative to figlet (uses libcaca)"
  homepage "http://caca.zoy.org/wiki/toilet"
  url "https://deb.debian.org/debian/pool/main/t/toilet/toilet_0.3.orig.tar.gz"
  mirror "http://caca.zoy.org/raw-attachment/wiki/toilet/toilet-0.3.tar.gz"
  sha256 "89d4b530c394313cc3f3a4e07a7394fa82a6091f44df44dfcd0ebcb3300a81de"
  license "WTFPL"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "69aebb7a5d3fa16517934b78d37d00c7109da3f31b7786c4957badcc05ee375f"
  end

  livecheck do
    url "http://caca.zoy.org/raw-attachment/wiki/toilet/"
    regex(/href=.*?toilet[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "https://github.com/cacalabs/toilet.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "libcaca"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./bootstrap" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"toilet", "--version"
  end
end
