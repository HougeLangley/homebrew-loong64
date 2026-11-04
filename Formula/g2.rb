class G2 < Formula
  desc "Friendly git client"
  homepage "https://orefalo.github.io/g2/"
  url "https://github.com/orefalo/g2/archive/refs/tags/v1.1.tar.gz"
  sha256 "bc534a4cb97be200ba4e3cc27510d8739382bb4c574e3cf121f157c6415bdfba"
  license "MIT"
  head "https://github.com/orefalo/g2.git", branch: "master"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a2d834424b49bde7cd8ff392c7e00ebb89f08947e3adfa191d1cc8562ea6f9a8"
  end

  def install
    system "make", "prefix=#{prefix}", "install"
  end

  def caveats
    <<~EOS
      To complete the installation:
        . #{prefix}/g2-install.sh

      NOTE: This will install a new ~/.gitconfig, backing up any existing
      file first. For more information view:
        #{prefix}/README.md
    EOS
  end

  test do
    system opt_prefix/"g2-install.sh"
    assert_path_exists ".gitconfig"
  end
end
