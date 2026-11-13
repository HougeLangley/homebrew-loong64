class Tnftp < Formula
  desc "NetBSD's FTP client"
  homepage "https://cdn.netbsd.org/pub/NetBSD/misc/tnftp/"
  url "https://cdn.netbsd.org/pub/NetBSD/misc/tnftp/tnftp-20260211.tar.gz"
  mirror "https://www.mirrorservice.org/sites/ftp.netbsd.org/pub/NetBSD/misc/tnftp/tnftp-20260211.tar.gz"
  sha256 "101cda6927e5de4338ad9d4b264304d7d15d6a78b435968a7b95093e0a2efe03"
  license all_of: [
    "BSD-2-Clause",
    "BSD-3-Clause", # src/domacro.c
    "ISC", # libnetbsd/{strlcat.c,strlcpy.c} (Linux)
  ]

  livecheck do
    url :homepage
    regex(/href=.*?tnftp[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c468219a0fab70a8c687fdfd2e58f613a1c6b30bf304a6e7ecd5ece92a0c7eb2"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "libedit"
  uses_from_macos "ncurses"

  conflicts_with "inetutils", because: "both install `ftp' binaries"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Remove bundled libedit. Still need Makefile.in to configure
    rm_r(Dir["libedit/*"] - ["libedit/Makefile.in"])

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--without-local-libedit", *std_configure_args
    system "make", "install"

    # Add compatibility symlinks as we used to manually install as `ftp`
    bin.install_symlink "tnftp" => "ftp"
    man1.install_symlink "tnftp.1" => "ftp.1"
  end

  test do
    system bin/"tnftp", "ftp://ftp.netbsd.org/pub/NetBSD/README"
    assert_match "This directory contains files related to NetBSD", File.read("README")
  end
end
