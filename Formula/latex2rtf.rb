class Latex2rtf < Formula
  desc "Translate LaTeX to RTF"
  homepage "https://latex2rtf.sourceforge.net/"
  # TODO: Switch to GitHub repo tarballs when upstream does a new release
  url "https://deb.debian.org/debian/pool/main/l/latex2rtf/latex2rtf_2.3.18a.orig.tar.gz"
  sha256 "338ba2e83360f41ded96a0ceb132db9beaaf15018b36101be2bae8bb239017d9"
  license "GPL-2.0-or-later"

  livecheck do
    skip "New git repository doesn't have 2.x tags yet"
  end


  head do
    url "https://github.com/latex2rtf/latex2rtf.git", branch: "main"

    on_system :linux, macos: :ventura_or_newer do
      depends_on "texinfo" => :build
    end
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7a6ae229414ba4c231d3e45a4071b52461671181057d22fe4cc771a2f9f92074"
  end

  def install
    touch "doc/latex2rtf.pdf" if build.head? # avoid texlive

    inreplace "Makefile", "cp -p doc/latex2rtf.html $(DESTDIR)$(SUPPORTDIR)",
                          "cp -p doc/web/* $(DESTDIR)$(SUPPORTDIR)"
    system "make", "DESTDIR=",
                   "BINDIR=#{bin}",
                   "MANDIR=#{man1}",
                   "INFODIR=#{info}",
                   "SUPPORTDIR=#{pkgshare}",
                   "CFGDIR=#{pkgshare}/cfg",
                   "install"
  end

  test do
    (testpath/"test.tex").write <<~'TEX'
      \documentclass{article}
      \title{LaTeX to RTF}
      \begin{document}
      \maketitle
      \end{document}
    TEX
    system bin/"latex2rtf", "test.tex"
    assert_path_exists testpath/"test.rtf"
    assert_match "LaTeX to RTF", (testpath/"test.rtf").read
  end
end
