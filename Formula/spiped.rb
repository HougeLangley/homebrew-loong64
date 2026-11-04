class Spiped < Formula
  desc "Secure pipe daemon"
  homepage "https://www.tarsnap.com/spiped.html"
  url "https://www.tarsnap.com/spiped/spiped-1.6.4.tgz"
  sha256 "424fb4d3769d912b04de43d21cc32748cdfd3121c4f1d26d549992a54678e06a"
  license "BSD-2-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?spiped[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "eda6585340dfe5306286d9a3db66c6151ccfe721104d53473df9d8ef64f032bb"
  end

  depends_on "openssl@4"

  def install
    system "make", "BINDIR_DEFAULT=#{bin}", "MAN1DIR=#{man1}", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spipe -v 2>&1")
  end
end
