class N < Formula
  desc "Node version management"
  homepage "https://github.com/tj/n"
  url "https://github.com/tj/n/archive/refs/tags/v11.0.0.tar.gz"
  sha256 "44e0bfd66aadff042817d1da90adaf5dfd16d269aefb4f0c79b5a4da23bd0abd"
  license "MIT"
  head "https://github.com/tj/n.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3cfb9da3b399a3765007d01a16a15046c0894d66a1fde0a461a1ad43c3721bcf"
  end

  def install
    bin.mkdir
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/"n", "ls"
  end
end
