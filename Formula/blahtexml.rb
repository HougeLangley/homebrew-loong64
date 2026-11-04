class Blahtexml < Formula
  desc "Converts equations into Math ML"
  homepage "https://github.com/gvanas/blahtexml"
  url "https://github.com/gvanas/blahtexml/archive/refs/tags/v1.0.tar.gz"
  sha256 "ef746642b1371f591b222ce3461c08656734c32ad3637fd0574d91e83995849e"
  license "BSD-3-Clause"
  revision 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5aeb52b465ef7d883db127fe1396f7be5251c3c9311647c2ea8d667e4c07e6f0"
  end

  depends_on "xerces-c"

  def install
    if OS.mac?
      system "make", "blahtex-mac"
      system "make", "blahtexml-mac"
    else
      system "make", "blahtex-linux"
      system "make", "blahtexml-linux"
    end
    bin.install "blahtex"
    bin.install "blahtexml"
  end

  test do
    input = '\sqrt{x^2+\alpha}'
    output = pipe_output("#{bin}/blahtex --mathml", input, 0)
    assert_match "<msqrt><msup><mi>x</mi><mn>2</mn></msup><mo ", output
  end
end
