class Pdftohtml < Formula
  desc "Utility which converts PDF files into HTML and XML formats"
  homepage "https://pdftohtml.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/pdftohtml/Experimental%20Versions/pdftohtml%200.40/pdftohtml-0.40a.tar.gz"
  sha256 "277ec1c75231b0073a458b1bfa2f98b7a115f5565e53494822ec7f0bcd8d4655"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    regex(%r{url=.*?/pdftohtml[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t}i)
  end


  conflicts_with "pdf2image", "poppler", "xpdf",
    because: "poppler, pdftohtml, pdf2image, and xpdf install conflicting executables"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b57f329106cefe0d2760505b997a045611ad118b8fd35087320eeeddc9940651"
  end

  def install
    system "make"
    bin.install "src/pdftohtml"
  end

  test do
    assert_match "Homebrew test", shell_output("#{bin}/pdftohtml -stdout #{test_fixtures("test.pdf")}")
  end
end
