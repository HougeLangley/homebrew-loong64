class Gloox < Formula
  desc "C++ Jabber/XMPP library that handles the low-level protocol"
  homepage "https://camaya.net/gloox/"
  url "https://camaya.net/download/gloox-1.0.28.tar.bz2"
  sha256 "591bd12c249ede0b50a1ef6b99ac0de8ef9c1ba4fd2e186f97a740215cc5966c"
  license "GPL-3.0-only" => { with: "openvpn-openssl-exception" }

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "414993f1785219d2554fb045a5b4cc0e556873b945b86c97edcc5c93792f135d"
  end

  livecheck do
    url :homepage
    regex(/Latest stable version.*?href=.*?gloox[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "pkgconf" => :build
  depends_on "gnutls"
  depends_on "libidn"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules",
                          "--with-zlib",
                          "--without-tests",
                          "--without-examples",
                          *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"gloox-config", "--cflags", "--libs", "--version"
  end
end
