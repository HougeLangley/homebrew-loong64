class Stone < Formula
  desc "TCP/IP packet repeater in the application layer"
  homepage "https://www.gcd.org/sengoku/stone/"
  url "https://www.gcd.org/sengoku/stone/stone-2.4.tar.gz"
  sha256 "d5dc1af6ec5da503f2a40b3df3fe19a8fbf9d3ce696b8f46f4d53d2ac8d8eb6f"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?stone[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6f0f5325ca6d7083e6bb3ba8e1d93d8654fb38a5e9d3e5297025352f595ed487"
  end

  def install
    os = OS.mac? ? "macosx" : OS.kernel_name.downcase
    system "make", os
    bin.install "stone"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stone -h 2>&1", 1)
  end
end
