class Pict < Formula
  desc "Pairwise Independent Combinatorial Tool"
  homepage "https://github.com/Microsoft/pict/"
  url "https://github.com/Microsoft/pict/archive/refs/tags/v3.7.4.tar.gz"
  sha256 "42af3ac7948d5dfed66525c4b6a58464dfd8f78a370b1fc03a8d35be2179928f"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f640043ddc8676f512418137b81dbcf5056aa8efd77e4050f89e3b769c5c430e"
  end

  resource "testfile", :test do
    url "https://gist.githubusercontent.com/glsorre/9f67891c69c21cbf477c6cedff8ee910/raw/84ec65cf37e0a8df5428c6c607dbf397c2297e06/pict.txt"
    sha256 "ac5e3561f9c481d2dca9d88df75b58a80331b757a9d2632baaf3ec5c2e49ccec"
  end


  def install
    system "make"
    bin.install "pict"
  end

  test do
    resource("testfile").stage testpath
    output = shell_output("#{bin}/pict pict.txt")
    assert_equal output.split("\n")[0], "LANGUAGES\tCURRIENCIES"
    assert_match "en_US\tGBP", output
    assert_match "en_US\tUSD", output
    assert_match "en_UK\tGBP", output
    assert_match "en_UK\tUSD", output
  end
end
