class Inspircd < Formula
  desc "Modular C++ Internet Relay Chat daemon"
  homepage "https://www.inspircd.org/"
  url "https://github.com/inspircd/inspircd/archive/refs/tags/v4.12.1.tar.gz"
  sha256 "d88d16014349c572776d5dc0a55e4b28e61caba857b5fbee47c3a49ca1591fef"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6eb8d4564f026ebc432aff280c37377079ab2a2f735e59282492bd3b74363c1a"
  end

  depends_on "pkgconf" => :build
  depends_on "argon2"
  depends_on "gnutls"
  depends_on "libpq"
  depends_on "mariadb-connector-c"

  uses_from_macos "openldap"

  on_linux do
    depends_on "libpsl"
  end

  skip_clean "data"
  skip_clean "logs"

  def install
    system "./configure", "--enable-extras",
                          "argon2 ldap mysql pgsql regex_posix ssl_gnutls sslrehashsignal"
    system "./configure", "--disable-auto-extras",
                          "--distribution-label", "homebrew-#{revision}",
                          "--prefix", prefix
    system "make", "install"
  end

  test do
    assert_match("Cannot find config file", shell_output(bin/"inspircd", 1))
  end
end
