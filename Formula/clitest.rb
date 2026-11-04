class Clitest < Formula
  desc "Command-Line Tester"
  homepage "https://github.com/aureliojargas/clitest"
  url "https://github.com/aureliojargas/clitest/archive/refs/tags/0.5.0.tar.gz"
  sha256 "4005de0bc27e4676e418ab1e1e64861272aa74af1212c73a1173760fc449b049"
  license "MIT"
  head "https://github.com/aureliojargas/clitest.git", branch: "main"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "526cc2bad823f02f02654af25c29eb33daf25173ce42b2ddca6432e40febe9c3"
  end

  def install
    bin.install "clitest"
  end

  test do
    (testpath/"test.txt").write <<~EOS
      $ echo "Hello World"   #=> Hello World
      $ cd /tmp
      $ pwd                  #=> /tmp
      $ cd "$OLDPWD"
      $
    EOS
    assert_match "OK: 4 of 4 tests passed",
      shell_output("#{bin}/clitest #{testpath}/test.txt")
  end
end
