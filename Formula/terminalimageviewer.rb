class Terminalimageviewer < Formula
  desc "Display images in a terminal using block graphic characters"
  homepage "https://github.com/stefanhaustein/TerminalImageViewer"
  url "https://github.com/stefanhaustein/TerminalImageViewer/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "08d0c30e3ffa47b69d1bce07bea56f04b7deb4a8a79307ce435a4f0852fbcd5f"
  license "Apache-2.0"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "41f6a72223ac2fcea45d3b3640fa84bfe4b78a8d2b735bda17729ad3f0e24ef0"
  end

  head "https://github.com/stefanhaustein/TerminalImageViewer.git", branch: "master"



  depends_on "imagemagick"

  def install
    cd "src" do
      system "make"
      bin.install "tiv"
    end
  end

  test do
    system bin/"tiv", test_fixtures("test.png")
  end
end
