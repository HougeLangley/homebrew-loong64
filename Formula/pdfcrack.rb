class Pdfcrack < Formula
  desc "PDF files password cracker"
  homepage "https://pdfcrack.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/pdfcrack/pdfcrack/pdfcrack-0.21/pdfcrack-0.21.tar.gz"
  sha256 "26f00d4afcb70b5839047bc6f62e4253073ac437bdb526f01e8c04b220e97762"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7c6c8c45ab5c815450d4e7d7d5e3e99f3743b7d018f29aaa3ceac9b1923b0851"
  end

  def install
    system "make", "all"
    bin.install "pdfcrack"
  end

  test do
    system bin/"pdfcrack", "--version"
  end
end
