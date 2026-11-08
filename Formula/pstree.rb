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
    sha256 cellar: :any, loongarch64_linux: "cd9af409eba67162c3cd5a9f4f9eb57a416eaaafbbda2292f0f9faa32fb1ccb9"
  end

  def install
    system "make", "pstree"
    bin.install "pstree"
    man1.install "pstree.1"
  end

  test do
    lines = shell_output("#{bin}/pstree #{Process.pid}").strip.split("\n")
    assert_match $PROGRAM_NAME, lines[0]
    assert_match (bin/"pstree").to_s, lines[1]
  end
end
