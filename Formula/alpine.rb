class Alpine < Formula
  desc "News and email agent"
  homepage "https://alpineapp.email"
  license "Apache-2.0"
  head "https://repo.or.cz/alpine.git", branch: "master"

  stable do
    url "https://alpineapp.email/alpine/release/src/alpine-2.26.tar.xz"
    # keep mirror even though `brew audit --strict --online` complains
    mirror "https://alpineapp.email/alpine/release/src/Old/alpine-2.26.tar.xz"
    sha256 "c0779c2be6c47d30554854a3e14ef5e36539502b331068851329275898a9baba"

    # patch for macOS obtained from developer; see git commit
    # https://repo.or.cz/alpine.git/commitdiff/701aebc00aff0585ce6c96653714e4ba94834c9c
    # Local copy excludes pith/pine.hlp change due to conflict
    patch do
      file "Patches/alpine/701aebc00aff0585ce6c96653714e4ba94834c9c.diff"
      type :backport
    end

    # fix `error: incompatible function pointer types`
    patch do
      url "https://raw.githubusercontent.com/gentoo/gentoo/37cdeedd76ed2f1f9d169431ac98c9e40afe9372/mail-client/alpine/files/alpine-2.26-fix-clang16-build-no-chappa.patch"
      sha256 "0e51e8253f9e5ff7fc9599845ec2bd3a0007a1bffb097a603dfd8d6fa6362797"
      type :unofficial
    end
  end

  livecheck do
    url :homepage
    regex(/href=.*?alpine[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2be1048de69f7c07ae9dee19bf36f83a6dbdff287a8070957720a69de32d9a45"
  end

  depends_on "openssl@3"

  uses_from_macos "krb5"
  uses_from_macos "ncurses"
  uses_from_macos "openldap"

  on_linux do
    depends_on "linux-pam"
  end

  conflicts_with "macpine", because: "both install `alpine` binaries"

  deny_network_access!

  def install
    ENV.deparallelize

    args = %W[
      --with-ssl-dir=#{formula_opt_prefix("openssl@3")}
      --with-ssl-certs-dir=#{etc}/openssl@3
      --with-bundled-tools
    ]

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"alpine", "-conf"
  end
end
