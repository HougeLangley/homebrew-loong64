class Ioping < Formula
  desc "Tool to monitor I/O latency in real time"
  homepage "https://github.com/koct9i/ioping"
  url "https://github.com/koct9i/ioping/archive/refs/tags/v1.3.tar.gz"
  sha256 "7aa48e70aaa766bc112dea57ebbe56700626871052380709df3a26f46766e8c8"
  license "GPL-3.0-or-later"
  head "https://github.com/koct9i/ioping.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d4420fb6dfcc0d0678620535c595a770f2d2b9aaa9fa19fcc6538d8b05c4da3c"
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"ioping", "-c", "1", testpath
  end
end
