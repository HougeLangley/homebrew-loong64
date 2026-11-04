class Opendetex < Formula
  desc "Tool to strip TeX or LaTeX commands from documents"
  homepage "https://github.com/pkubowicz/opendetex"
  url "https://github.com/pkubowicz/opendetex/releases/download/v2.8.12/opendetex-2.8.12.tar.bz2"
  sha256 "d1fcffe7290c6fff2db77e9074b896979b8ce72b3c2fc47de3341bb6652da02a"
  license "NCSA"


  uses_from_macos "flex" => :build

  conflicts_with "texlive", because: "both install `detex` binaries"

  deny_network_access!

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e057ddc567b85a938cd21f7794f3a68c2494e6e8d5f361300fe86134e94e6aee"
  end

  def install
    system "make"
    bin.install "detex"
    bin.install "delatex"
    man1.install "detex.1"
  end

  test do
    (testpath/"test.tex").write <<~'TEX'
      \documentclass{article}
      \begin{document}
      Simple \emph{text}.
      \end{document}
    TEX

    output = shell_output("#{bin}/detex test.tex")
    assert_equal "Simple text.\n", output
  end
end
