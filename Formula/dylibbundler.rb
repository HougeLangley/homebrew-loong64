class Dylibbundler < Formula
  desc "Utility to bundle libraries into executables for macOS"
  homepage "https://github.com/auriamg/macdylibbundler"
  url "https://github.com/auriamg/macdylibbundler/archive/refs/tags/1.0.5.tar.gz"
  sha256 "13384ebe7ca841ec392ac49dc5e50b1470190466623fa0e5cd30f1c634858530"
  license "MIT"
  head "https://github.com/auriamg/macdylibbundler.git", branch: "master"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1870e203f505e362ed08af5abe141b0d5b8cef614d78f0653c7b92a53a31858f"
  end

  def install
    system "make"
    bin.install "dylibbundler"
  end

  test do
    system bin/"dylibbundler", "-h"
  end
end
