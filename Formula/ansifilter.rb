class Ansifilter < Formula
  desc "Strip or convert ANSI codes into HTML, (La)Tex, RTF, or BBCode"
  homepage "http://andre-simon.de/doku/ansifilter/en/ansifilter.php"
  url "https://gitlab.com/saalen/ansifilter/-/archive/2.24/ansifilter-2.24.tar.bz2"
  sha256 "e1f2ae665e49631c30f483e9048d4f6c7fc6f4854d945fbe3c68995c6bf5ec65"
  license "GPL-3.0-or-later"

  livecheck do
    url "http://andre-simon.de/zip/download.php"
    regex(/href=.*?ansifilter[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "546e9fcd17b72a91aa9523b500bd4c5029175ceb21891326d06330a1706202fa"
  end

  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    path = testpath/"ansi.txt"
    path.write "f\x1b[31moo"

    assert_equal "foo", shell_output("#{bin}/ansifilter #{path}").strip
  end
end
