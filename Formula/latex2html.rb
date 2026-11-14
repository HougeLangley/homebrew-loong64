class Latex2html < Formula
  desc "LaTeX-to-HTML translator"
  homepage "https://www.latex2html.org"
  url "https://github.com/latex2html/latex2html/archive/refs/tags/v2026.tar.gz"
  sha256 "f91c0c9bc8dbcadbba883f912f9d1cd2382b563fd754456488a95c120f24331e"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)*)$/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7593c8029722c338e2bc7f640ff55c247a16c0a722a6ed17714c957903e5d624"
  end

  depends_on "ghostscript"
  depends_on "netpbm"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--without-mktexlsr",
                          "--with-texpath=#{share}/texmf/tex/latex/html"
    system "make", "install"
  end

  test do
    (testpath/"test.tex").write <<~'TEX'
      \documentclass{article}
      \usepackage[utf8]{inputenc}
      \title{Experimental Setup}
      \date{\today}
      \begin{document}
      \maketitle
      \end{document}
    TEX
    system bin/"latex2html", "test.tex"
    assert_match "Experimental Setup", File.read("test/test.html")
  end
end
