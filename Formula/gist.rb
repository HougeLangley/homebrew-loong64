class Gist < Formula
  desc "Command-line utility for uploading Gists"
  homepage "https://defunkt.io/gist/"
  url "https://github.com/defunkt/gist/archive/refs/tags/v6.1.0.tar.gz"
  sha256 "53c72eb07bcdd71b1a8fdd3f81a3cc44a332b92c34a30632e45d6941c10f3096"
  license "MIT"
  head "https://github.com/defunkt/gist.git", branch: "master"


  uses_from_macos "ruby"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c2255422d068270a5e2d074c6753e482887a4b0eaca4f30fef1277ee4c2c141d"
  end

  def install
    system "rake", "install", "prefix=#{prefix}"
  end

  test do
    output = pipe_output(bin/"gist", "homebrew")
    assert_match "GitHub now requires credentials", output
  end
end
