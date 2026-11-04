class Openvi < Formula
  desc "Portable OpenBSD vi for UNIX systems"
  homepage "https://github.com/johnsonjh/OpenVi"
  url "https://github.com/johnsonjh/OpenVi/archive/refs/tags/8.0.34.tar.gz"
  sha256 "27cab6f631f1d8aefc33c944a3f226ebb8d5ad4325f50b6f52d60be7b823ded8"
  license "BSD-3-Clause"
  head "https://github.com/johnsonjh/OpenVi.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "794fc43a25b14ab7c1c32b17786db81b50327397ab1a805a1b68d3c5461f2fe9"
  end

  depends_on "pkgconf" => :build
  depends_on "ncurses" # https://github.com/johnsonjh/OpenVi/issues/32

  def install
    system "make", "install", "CURSESLIB=-lncurses", "CHOWN=true", "LTO=1", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test").write("This is toto!\n")
    pipe_output("#{bin}/ovi -e test", "%s/toto/tutu/g\nwq\n")
    assert_equal "This is tutu!\n", File.read("test")
  end
end
