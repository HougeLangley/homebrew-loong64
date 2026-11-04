class Doubledown < Formula
  desc "Sync local changes to a remote directory"
  homepage "https://github.com/devstructure/doubledown"
  url "https://github.com/devstructure/doubledown/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "47ff56b6197c5302a29ae4a373663229d3b396fd54d132adbf9f499172caeb71"
  license "BSD-2-Clause"
  head "https://github.com/devstructure/doubledown.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b96b435d061f7c80a57ca8a94da92dd273b2dbfc7be1ee4f06b2c66e4e110981"
  end

  def install
    bin.install Dir["bin/*"]
    man1.install Dir["man/man1/*.1"]
  end

  test do
    system bin/"doubledown", "--help"
  end
end
