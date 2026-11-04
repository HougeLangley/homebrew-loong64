class ProofGeneral < Formula
  desc "Emacs-based generic interface for theorem provers"
  homepage "https://proofgeneral.github.io"
  url "https://github.com/ProofGeneral/PG/archive/refs/tags/v4.5.tar.gz"
  sha256 "b408ab943cfbfe4fcb0d3322f079f41e2a2d29b50cf0cc704fbb4d5e6c26e3a2"
  license "GPL-3.0-or-later"
  head "https://github.com/ProofGeneral/PG.git", branch: "master"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2daf64a5aea5aaf1b951543b3b40a4a746762f3b44cfe4434eeb8f6e8af2be0e"
  end

  depends_on "texi2html" => :build
  depends_on "texinfo" => :build
  depends_on "emacs"

  def install
    ENV.deparallelize # Otherwise lisp compilation can result in 0-byte files

    args = %W[
      PREFIX=#{prefix}
      DEST_PREFIX=#{prefix}
      ELISPP=share/emacs/site-lisp/proof-general
      ELISP_START=#{elisp}/site-start.d
      EMACS=#{which "emacs"}
    ]

    system "make", "install", *args

    cd "doc" do
      system "make", "info", "html"
    end
    man1.install "doc/proofgeneral.1"
    info.install "doc/ProofGeneral.info", "doc/PG-adapting.info"
    doc.install "doc/ProofGeneral_html", "doc/PG-adapting_html"
  end

  def caveats
    <<~EOS
      HTML documentation is available in: #{HOMEBREW_PREFIX}/share/doc/proof-general
    EOS
  end

  test do
    system bin/"coqtags", "--help"
  end
end
