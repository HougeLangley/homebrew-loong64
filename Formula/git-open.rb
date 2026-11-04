class GitOpen < Formula
  desc "Open GitHub webpages from a terminal"
  homepage "https://github.com/jeffreyiacono/git-open"
  url "https://github.com/jeffreyiacono/git-open/archive/refs/tags/v1.3.tar.gz"
  sha256 "a1217e9b0a76382a96afd33ecbacad723528ec1116381c22a17cc7458de23701"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "893767b8679665efee076df175a273e28f3ff2cd1659042fb6c428424ebdaa2c"
  end

  def install
    bin.install "git-open.sh" => "git-open"
  end

  test do
    system bin/"git-open", "-v"
  end
end
