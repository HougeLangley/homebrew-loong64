class Lorem < Formula
  include Language::Python::Shebang

  desc "Python generator for the console"
  homepage "https://github.com/per9000/lorem"
  url "https://github.com/per9000/lorem/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "3eec439d616a044e61a6733730b1fc009972466f869dae358991f95abd57e8b3"
  license "GPL-3.0-or-later"
  head "https://github.com/per9000/lorem.git", branch: "master"


  uses_from_macos "python"

  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c1169064ab38272fa9b39985c7b1e03cb1774bffe2fe9318a861dc4fc9aa533c"
  end

  def install
    bin.install "lorem"
    rewrite_shebang detected_python_shebang(use_python_from_path: true), bin/"lorem"
  end

  test do
    assert_equal "lorem ipsum", shell_output("#{bin}/lorem -n 2").strip.downcase
  end
end
