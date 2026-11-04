class Distribution < Formula
  include Language::Python::Shebang

  desc "Create ASCII graphical histograms in the terminal"
  homepage "https://github.com/time-less-ness/distribution"
  url "https://github.com/time-less-ness/distribution/archive/refs/tags/1.3.tar.gz"
  sha256 "d7f2c9beeee15986d24d8068eb132c0a63c0bd9ace932e724cb38c1e6e54f95d"
  license "GPL-2.0-only"
  head "https://github.com/time-less-ness/distribution.git", branch: "master"


  uses_from_macos "python"

  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c2189f930d2c7f0238ed6651a446d568d5a0765e6b5e5b6fef10226819ef7904"
  end

  def install
    rewrite_shebang detected_python_shebang(use_python_from_path: true), "distribution.py"
    bin.install "distribution.py" => "distribution"
    doc.install "distributionrc", "screenshot.png"
  end

  test do
    assert_match "a|2 (66.67%)", pipe_output("#{bin}/distribution 2>/dev/null", "a\nb\na\n", 0)
  end
end
