class Nerdfetch < Formula
  desc "POSIX *nix fetch script using Nerdfonts"
  homepage "https://github.com/ThatOneCalculator/NerdFetch"
  url "https://github.com/ThatOneCalculator/NerdFetch/archive/refs/tags/v8.5.5.tar.gz"
  sha256 "944b08b957a82386fa3f394ef733e31f7208acee0681c6000d5cd042c16813d6"
  license "MIT"
  head "https://github.com/ThatOneCalculator/NerdFetch.git", branch: "main"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "accb678c3435b05ca7c482ceb977e2396e97b582f5d957cdda6a21358d7c97eb"
  end

  def install
    bin.install "nerdfetch"
  end

  test do
    user = ENV["USER"]
    assert_match user.to_s, shell_output(bin/"nerdfetch")
  end
end
