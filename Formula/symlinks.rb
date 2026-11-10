class Symlinks < Formula
  desc "Symbolic link maintenance utility"
  homepage "https://github.com/brandt/symlinks"
  url "https://github.com/brandt/symlinks/archive/refs/tags/v1.4.3.tar.gz"
  sha256 "27105b2898f28fd53d52cb6fa77da1c1f3b38e6a0fc2a66bf8a25cd546cb30b2"
  license "MIT"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "428ceed8de2c623a4f0d689955d71fbb5e62048aaf7cd6c5f490bd3fe66fd12b"
  end

  def install
    system "make", "install"
    bin.install "symlinks"
    man8.install "symlinks.8"
  end

  test do
    (testpath/"real").write("ok\n")
    File.symlink("real", testpath/"link")
    output = shell_output("#{bin}/symlinks -v #{testpath}")
    assert_match "->", output
    assert_match "link", output
    assert_equal "ok\n", (testpath/"link").read
  end
end
