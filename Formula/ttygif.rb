class Ttygif < Formula
  desc "Converts a ttyrec file into gif files"
  homepage "https://github.com/icholy/ttygif"
  url "https://github.com/icholy/ttygif/archive/refs/tags/1.6.0.tar.gz"
  sha256 "050b9e86f98fb790a2925cea6148f82f95808d707735b2650f3856cb6f53e0ae"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1f5687b5d945f52c8bb656d4c88075752a5414934a9f1f821d37c78eb415ddf2"
  end

  depends_on "imagemagick"
  depends_on "ovh-ttyrec"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    # Work around "Error: WINDOWID environment variable was empty."
    # Lighter weight alternative to adding a mock display.
    ENV["WINDOWID"] = "0" if OS.linux? && ENV["HOMEBREW_GITHUB_ACTIONS"]

    ENV["TERM_PROGRAM"] = "Something"
    system bin/"ttygif", "--version"
  end
end
