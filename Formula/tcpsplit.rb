class Tcpsplit < Formula
  desc "Break a packet trace into some number of sub-traces"
  homepage "https://www.icir.org/mallman/software/tcpsplit/"
  url "https://www.icir.org/mallman/software/tcpsplit/tcpsplit-0.3.tar.gz"
  sha256 "9ba0a12d294fa4ccc8cad8d9662126f01b436ced48642c3fb2520121943f5cf5"
  # The license is similar to X11 but with a different phrasing to the no advertising clause
  license :cannot_represent

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ae89c5b55be4d14a67bc266feabe069ab6272c8462a3d97326ae7b52d39a9d48"
  end

  livecheck do
    url :homepage
    regex(/href=.*?tcpsplit[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  uses_from_macos "libpcap"


  def install
    system "make"
    bin.install "tcpsplit"
  end

  test do
    system bin/"tcpsplit", "--version"
  end
end
