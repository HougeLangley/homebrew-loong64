class Kommit < Formula
  desc "More detailed commit messages without committing!"
  homepage "https://github.com/vigo/kommit"
  url "https://github.com/vigo/kommit/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "c51e87c9719574feb9841fdcbd6d1a43b73a45afeca25e1312d2699fdf730161"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "74cab889655164f0f77146053d249d513eac96afb4d64fd1d0b2cd197a7d190b"
  end

  def install
    bin.install "bin/git-kommit"
  end

  test do
    system "git", "init"
    system bin/"git-kommit", "-m", "Hello"
    assert_match "Hello", shell_output("#{bin}/git-kommit -s /dev/null 2>&1")
  end
end
