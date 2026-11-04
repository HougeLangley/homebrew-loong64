class Ddate < Formula
  desc "Converts boring normal dates to fun Discordian Date"
  homepage "https://github.com/bo0ts/ddate"
  url "https://github.com/bo0ts/ddate/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "d53c3f0af845045f39d6d633d295fd4efbe2a792fd0d04d25d44725d11c678ad"
  license :public_domain


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "cbe21d06dcebfa7e73f2457fccc3fd5a21c33224987a8e00ea7ad6531503c840"
  end

  def install
    system ENV.cc, "ddate.c", "-o", "ddate"
    bin.install "ddate"
    man1.install "ddate.1"
  end

  test do
    output = shell_output("#{bin}/ddate 20 6 2014").strip
    assert_equal "Sweetmorn, Confusion 25, 3180 YOLD", output
  end
end
