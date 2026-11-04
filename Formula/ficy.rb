class Ficy < Formula
  desc "Icecast/Shoutcast stream grabber suite"
  homepage "https://www.thregr.org/wavexx/software/fIcy/"
  url "https://www.thregr.org/wavexx/software/fIcy/releases/fIcy-1.0.21.tar.gz"
  sha256 "8564b16d3a52fa6dc286b02bfcc19e4acdc148c30f1750ca144e2ea47c84fd81"
  license "LGPL-2.1-only"
  head "https://gitlab.com/wavexx/fIcy.git", branch: "master"

  livecheck do
    url :homepage
    regex(%r{href=.*?releases/fIcy[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d9e0a3de07dd8588f033d6fb98fd24d631df18c128ec85eed1cb1ead09d1616e"
  end

  def install
    system "make"
    bin.install "fIcy", "fPls", "fResync"
  end

  test do
    cp test_fixtures("test.mp3"), testpath
    system bin/"fResync", "-n", "1", "test.mp3"
  end
end
