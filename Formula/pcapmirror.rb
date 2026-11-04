class Pcapmirror < Formula
  desc "Tool for capturing network traffic on remote host using TZSP or ERSPAN"
  homepage "https://git.freestone.net/cramer/pcapmirror"
  url "https://git.freestone.net/cramer/pcapmirror/-/archive/0.7.1/pcapmirror-0.7.1.tar.gz"
  sha256 "b01b56d8515dbcdfb93e48bae171770747ba4772997e388adfc43397ff553232"
  license "BSD-3-Clause"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5dbf23fd210058e4399469e3b4f3cbbef863de2517d821f3d612a66f3eceed70"
  end

  depends_on "make" => :build
  uses_from_macos "libpcap"

  on_linux do
    depends_on "libpcap"
  end

  def install
    bin.mkpath
    man8.mkpath
    system "make", "install", "BINDIR=#{bin}", "MANDIR=#{man}"
  end

  test do
    assert_match "Available network interfaces:", shell_output("#{bin}/pcapmirror -l")
  end
end
