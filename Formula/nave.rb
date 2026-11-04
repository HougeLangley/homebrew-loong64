class Nave < Formula
  desc "Virtual environments for Node.js"
  homepage "https://github.com/isaacs/nave"
  url "https://github.com/isaacs/nave/archive/refs/tags/v3.5.6.tar.gz"
  sha256 "d5360cbfe3afda8622fa838183eec53503f8e3f4e08c224b5b1458159f30a99e"
  license "BlueOak-1.0.0"
  head "https://github.com/isaacs/nave.git", branch: "main"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8c452613fd81ff64bb8247e2e4eb9c4688664fa0e3bc60505529a478a489e5b0"
  end

  def install
    bin.install "nave.sh" => "nave"
  end

  test do
    assert_match "0.10.30", shell_output("#{bin}/nave ls-remote")
  end
end
