class Sparse < Formula
  desc "Static C code analysis tool"
  homepage "https://sparse.wiki.kernel.org/"
  url "https://mirrors.edge.kernel.org/pub/software/devel/sparse/dist/sparse-0.6.4.tar.xz"
  sha256 "6ab28b4991bc6aedbd73550291360aa6ab3df41f59206a9bde9690208a6e387c"
  license "MIT"
  head "https://git.kernel.org/pub/scm/devel/sparse/sparse.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e21a95b0a990216815e07e1f5fe4a847b6c5fbc9c38c7f68cf6a0c5d1b270135"
  end

  livecheck do
    url "https://mirrors.edge.kernel.org/pub/software/devel/sparse/dist/"
    regex(/href=.*?sparse[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  def install
    # BSD "install" does not understand the GNU -D flag.
    # Create the parent directories ourselves.
    inreplace "Makefile", "install -D", "install"
    bin.mkpath
    man1.mkpath

    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.C").write("int main(int a) {return a;}\n")
    system bin/"sparse", testpath/"test.C"
  end
end
