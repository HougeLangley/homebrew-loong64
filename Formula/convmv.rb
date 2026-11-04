class Convmv < Formula
  desc "Filename encoding conversion tool"
  homepage "https://www.j3e.de/linux/convmv/"
  url "https://www.j3e.de/linux/convmv/convmv-2.06.tar.gz"
  sha256 "a37192e266742e7fe33ec19a3be49aea7fd4d066887863a6e193fa345bf2e592"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?convmv[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2d82bdf99dc4065b75637f963657bae3e00466c3869767dd0b10f31a830038bb"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"convmv", "--list"
  end
end
