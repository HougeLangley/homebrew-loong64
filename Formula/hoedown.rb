class Hoedown < Formula
  desc "Secure Markdown processing (a revived fork of Sundown)"
  homepage "https://github.com/hoedown/hoedown"
  url "https://github.com/hoedown/hoedown/archive/refs/tags/3.0.7.tar.gz"
  sha256 "01b6021b1ec329b70687c0d240b12edcaf09c4aa28423ddf344d2bd9056ba920"
  license "ISC"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e6840d0b94c5cbc751d4f2077e6aba1f422eee9b51c886b759db83369baee412"
  end

  def install
    system "make", "hoedown"
    bin.install "hoedown"
    prefix.install "test"
  end

  test do
    system "perl", "#{prefix}/test/MarkdownTest_1.0.3/MarkdownTest.pl",
                   "--script=#{bin}/hoedown",
                   "--testdir=#{prefix}/test/MarkdownTest_1.0.3/Tests",
                   "--tidy"
  end
end
