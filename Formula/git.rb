class Git < Formula
  desc "Distributed revision control system"
  homepage "https://git-scm.com"
  url "https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.53.0.tar.xz"
  sha256 "5818bd7d80b061bbbdfec8a433d609dc8818a05991f731ffc4a561e2ca18c653"
  license "GPL-2.0-only"

  depends_on "gettext"
  depends_on "pcre2"
  depends_on "curl"
  depends_on "openssl@3"
  depends_on "zlib-ng-compat"

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu

    ENV["CFLAGS"] = "-O2 -Wno-error"
    ENV["LDFLAGS"] = "-L#{Formula["curl"].opt_lib}"

    args = %W[
      prefix=#{prefix}
      sysconfdir=#{etc}
      CC=#{ENV.cc}
      CFLAGS=#{ENV.cflags}
      LDFLAGS=#{ENV.ldflags}
      NO_TCLTK=1
      NO_OPENSSL=1
      APPLE_COMMON_CRYPTO=0
      NO_BROTLI=1
      INSTALL_SYMLINKS=1
      BUILD_CPU=#{cpu}
    ]

    system "make", "all", *args
    system "make", "install", *args
  end

  test do
    system bin/"git", "--version"
  end
end
