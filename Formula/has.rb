class Has < Formula
  desc "Checks presence of various command-line tools and their versions on the path"
  homepage "https://github.com/kdabir/has"
  url "https://github.com/kdabir/has/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "99b4b82d8b935521bd1b44bf7a6af3421f4c850a28b8edfee39e6ee75af4d78f"
  license "MIT"
  head "https://github.com/kdabir/has.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "eb2ef7b70bcbb0ae4b662e84c20e080330c103980d3399769f038003d9beb79c"
  end

  def install
    bin.install "has"
  end

  test do
    assert_match "git", shell_output("#{bin}/has git")
    assert_match version.to_s, shell_output("#{bin}/has --version")
  end
end
