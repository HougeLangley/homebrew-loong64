class Symlinks < Formula
  desc "Symbolic link maintenance utility"
  homepage "https://github.com/brandt/symlinks"
  url "https://github.com/brandt/symlinks/archive/refs/tags/v1.4.3.tar.gz"
  sha256 "27105b2898f28fd53d52cb6fa77da1c1f3b38e6a0fc2a66bf8a25cd546cb30b2"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "53702f2d9f107ff08990fd5c229115396da649fc84108e7805f8e928d58d0a5b"
  end

  def install
    system "make", "install"
    bin.install "symlinks"
    man8.install "symlinks.8"
  end

  test do
    assert_match "->", shell_output("#{bin}/symlinks -v #{__dir__}/../../Aliases")
  end
end
