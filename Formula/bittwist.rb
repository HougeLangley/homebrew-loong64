class Bittwist < Formula
  desc "Libcap-based Ethernet packet generator"
  homepage "https://bittwist.sourceforge.io"
  url "https://downloads.sourceforge.net/project/bittwist/macOS/Bit-Twist%204.7/bittwist-macos-4.7.tar.gz"
  sha256 "2ff00070d57221672af5198268088ffee8ed6b5ade33d6f26be5b3b4125b48f1"
  license "GPL-2.0-or-later"


  uses_from_macos "libpcap"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0000000000000000000000000000000000000000000000000000000000000000"
  end

  def install
    # --- 追加缺失库 ---
    ENV.append "LIBS", "-lnl -lnl-genl-3"
    ENV.append "LDFLAGS", "-lnl -lnl-genl-3"
    system "make", "LIBS=-lnl -lnl-genl-3"
    system "make", "LIBS=-lnl -lnl-genl-3", "install", "prefix=#{prefix}"
  end

  test do
    system bin/"bittwist", "-help"
    system bin/"bittwiste", "-help"
  end
end
