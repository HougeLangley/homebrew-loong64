class Wget < Formula
  desc "Internet file retriever"
  homepage "https://www.gnu.org/software/wget/"
  url "https://ftp.gnu.org/gnu/wget/wget-1.25.0.tar.gz"
  sha256 "766e48423e79359ea31e41db9e5c289675947a7fcf2efdcedb726ac9d0da3784"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/bottles/loong64"
    rebuild 2
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "db6afce6562894b9bb43d59cd59a0b1a76c53f478159a390d96fe6f31c746a7c"
  end

  depends_on "libidn2"
  depends_on "openssl@3"
  depends_on "zlib-ng-compat"

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu

    system "./configure", "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--with-ssl=openssl",
                          "--with-libssl-prefix=#{Formula["openssl@3"].opt_prefix}",
                          "--disable-pcre",
                          "--disable-pcre2",
                          "--without-libpsl",
                          "--without-metalink",
                          "--build=#{cpu}-unknown-linux-gnu"

    system "make", "install"
  end

  test do
    system bin/"wget", "--version"
  end
end
