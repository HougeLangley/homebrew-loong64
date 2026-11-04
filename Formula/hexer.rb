class Hexer < Formula
  desc "Hex editor for the terminal with vi-like interface"
  homepage "https://devel.ringlet.net/editors/hexer/"
  url "https://devel.ringlet.net/files/editors/hexer/hexer-1.0.7.tar.gz"
  sha256 "4e4ee48f7c9b0f62ecf5e5012d280bcd6f2bbd35e77facb769ac912278f4ed08"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?hexer[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  uses_from_macos "ncurses"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "352f2e240bd8d89c25788d9a7d79eb3262740c0de9f9704433fe0553de91587e"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}", "MANDIR=#{man1}"
  end

  test do
    ENV["TERM"] = "xterm"
    assert_match "00000000:  62 72 65 77", pipe_output("#{bin}/hexer test", "i62726577\e:wq\n")
    assert_equal "brew", (testpath/"test").read
  end
end
