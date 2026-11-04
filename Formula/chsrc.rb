class Chsrc < Formula
  desc "Change Source for every software on every platform from the command-line"
  homepage "https://chsrc.run/"
  url "https://github.com/RubyMetric/chsrc/archive/refs/tags/v0.2.7.tar.gz"
  sha256 "0c1ff6ec9e8860d6c0455bc2f0e228647e578fbbe1874141850ec253a9693f10"
  license "GPL-3.0-or-later"
  head "https://github.com/RubyMetric/chsrc.git", branch: "main"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b418c45524b1f0def3a3afa8306fbe59fb45f7497851d2e7b2b426374f048aa0"
  end

  def install
    system "make"
    bin.install "chsrc"
  end

  test do
    assert_match(/mirrorz\s*MirrorZ.*MirrorZ/, shell_output("#{bin}/chsrc list"))
    assert_match version.to_s, shell_output("#{bin}/chsrc --version")
  end
end
