# NOTE: The version of pstree used on Linux requires
# the /proc file system, which is not available on macOS.

class Pstree < Formula
  desc "Show ps output as a tree"
  homepage "https://github.com/FredHucht/pstree"
  url "https://github.com/FredHucht/pstree/archive/refs/tags/v2.40.tar.gz"
  sha256 "64d613d8f66685b29f13a80e08cddc08616cf3e315a0692cbbf9de0d8aa376b3"
  license "GPL-3.0-only"

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9ca8caea3dafba8a1830f32b6ffdf29c30f23a46a04d666b6e4d78ad75a80bcd"
  end

  def install
    system "make", "pstree"
    bin.install "pstree"
    man1.install "pstree.1"
  end

  test do
    output = shell_output("#{bin}/pstree #{Process.pid}")
    assert_match(/\b#{Process.pid}\b/, output)
    assert_match "pstree", output
  end
end
