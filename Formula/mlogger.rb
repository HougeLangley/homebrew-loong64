class Mlogger < Formula
  desc "Log to syslog from the command-line"
  homepage "https://github.com/nbrownus/mlogger"
  url "https://github.com/nbrownus/mlogger/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "141bb9af13a8f0e865c8509ac810c10be4e21f14db5256ef5c7a6731b490bf32"
  license "BSD-4-Clause-UC"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "235c3d389fc7aa02ae2b753ca80a3d5387c6c8c44ffd872606a3a508e98a215c"
  end

  def install
    system "make"
    bin.install "mlogger"
  end

  test do
    system bin/"mlogger", "-i", "-d", "test"
  end
end
