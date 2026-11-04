class Historian < Formula
  desc "Command-line utility for managing shell history in a SQLite database"
  homepage "https://github.com/jcsalterego/historian"
  url "https://github.com/jcsalterego/historian/archive/refs/tags/0.0.2.tar.gz"
  sha256 "691b131290ddf06142a747755412115fec996cb9cc2ad8e8f728118788b3fe05"
  license "BSD-2-Clause"


  uses_from_macos "sqlite"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "47e4a398addc142328ea82b8c079a94c8269ca94491838a1142ee06f93d6483a"
  end

  def install
    bin.install "hist"
  end

  test do
    ENV["HISTORIAN_SRC"] = "test_history"
    (testpath/"test_history").write <<~EOS
      brew update
      brew upgrade
    EOS
    system bin/"hist", "import"
  end
end
