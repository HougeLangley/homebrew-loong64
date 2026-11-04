class Qstat < Formula
  desc "Query Quake servers from the command-line"
  homepage "https://github.com/rocketsciencegg/qstat"
  url "https://github.com/rocketsciencegg/qstat/archive/refs/tags/v2.18.tar.gz"
  sha256 "a74564bd9c31db3dc1fcc0a68ffaf694630b9e67f0d31ff76b2a3c3196ee4f1f"
  license "Artistic-2.0"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3b21752c9f9835d679f82d02f4bb993f8a2f6b1970ab63a98772876a73097913"
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoupdate" unless OS.mac?
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"qstat", "--help"
  end
end
