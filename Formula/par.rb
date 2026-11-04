class Par < Formula
  desc "Paragraph reflow for email"
  homepage "http://www.nicemice.net/par/"
  url "https://bitbucket.org/amc-nicemice/par/get/1.53.0.tar.bz2"
  sha256 "6109b1811630e1e0e76fc87bf60ad9140440a145c9b4c9412fb36b4f73726a04"
  # par.doc includes a custom license and alternatively allows usage under MIT license
  license any_of: [:cannot_represent, "MIT"]

  livecheck do
    url :homepage
    regex(/href=.*?Par[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  conflicts_with "rancid", because: "both install `par` binaries"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5e678ced1241acf0716f74a034963c2b10926bdbc8d8783d689d97534cec5ed2"
  end

  def install
    system "make", "-f", "protoMakefile"
    bin.install "par"
    man1.install Utils::Gzip.compress("par.1")
  end

  test do
    expected = "homebrew\nhomebrew\n"
    assert_equal expected, pipe_output("#{bin}/par 10gqr", "homebrew homebrew", 0)
  end
end
