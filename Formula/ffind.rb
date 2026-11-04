class Ffind < Formula
  include Language::Python::Shebang

  desc "Friendlier find"
  homepage "https://github.com/sjl/friendly-find"
  url "https://github.com/sjl/friendly-find/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "cf30e09365750a197f7e041ec9bbdd40daf1301e566cd0b1a423bf71582aad8d"
  license "GPL-3.0-only"


  uses_from_macos "python"

  conflicts_with "sleuthkit",
    because: "both install a `ffind` executable"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4c82144a05cfa0d909e7e7cf35731ed568920009d5890e938d72bda47d0dc688"
  end

  def install
    rewrite_shebang detected_python_shebang(use_python_from_path: true), "ffind"
    bin.install "ffind"
    man1.install "ffind.1"
  end

  test do
    system bin/"ffind"
  end
end
