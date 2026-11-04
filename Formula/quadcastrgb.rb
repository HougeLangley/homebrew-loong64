class Quadcastrgb < Formula
  desc "Set RGB lights on HyperX QuadCast S and Duocast microphones"
  homepage "https://ors1mer.xyz/quadcastrgb.html"
  url "https://ors1mer.xyz/downloads/quadcastrgb-1.0.5.tgz"
  sha256 "cdbe8d638ac772579acca203bb2663d7c3a47006190a78ee2971b06c63c69648"
  license "GPL-2.0-only"
  head "https://github.com/Ors1mer/QuadcastRGB.git", branch: "main"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2a28dd112c26b7849a56cae6b7fa8d6c1c7913e0a4385ecb253a2ccec8ce5802"
  end

  livecheck do
    url :homepage
    regex(/quadcastrgb[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "libusb"

  def install
    os = OS.mac? ? "macos" : OS.kernel_name.downcase
    system "make", "OS=#{os}", "quadcastrgb"
    bin.install "quadcastrgb"
    man1.install "man/quadcastrgb.1.gz"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/quadcastrgb --version")
    assert_match "No mode specified (solid|blink|cycle|lightning|wave)",
                 shell_output("#{bin}/quadcastrgb 2>&1", 1)
    assert_match "Unknown option: bad_mode",
                 shell_output("#{bin}/quadcastrgb bad_mode 2>&1", 1)
  end
end
