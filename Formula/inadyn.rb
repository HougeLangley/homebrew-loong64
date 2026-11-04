class Inadyn < Formula
  desc "Dynamic DNS client with IPv4, IPv6, and SSL/TLS support"
  homepage "https://troglobit.com/projects/inadyn/"
  url "https://github.com/troglobit/inadyn/releases/download/v2.13.0/inadyn-2.13.0.tar.xz"
  sha256 "d08ca63a35896f2a809ba9b704da16ec6812b94dd410e7b3ea536a16d93860c2"
  license all_of: ["GPL-2.0-or-later", "ISC", "MIT"]


  head do
    url "https://github.com/troglobit/inadyn.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool"  => :build
  end

  deprecate! date: "2025-10-25", because: :repo_archived
  disable! date: "2026-10-25", because: :repo_archived

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d290ab597603c45a805adb470b053af97dd3143d58544f12e17c3f10ef618f46"
  end

  depends_on "pkgconf" => :build

  depends_on "confuse"
  depends_on "openssl@4"

  def install
    mkdir_p buildpath/"inadyn/m4"

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--disable-silent-rules",
                          "--enable-openssl",
                          "--sysconfdir=#{etc}",
                          "--localstatedir=#{var}",
                          *std_configure_args
    system "make", "install"
  end

  test do
    system sbin/"inadyn", "--check-config", "--config=#{doc}/examples/inadyn.conf"
  end
end
