class Xdotool < Formula
  desc "Fake keyboard/mouse input and window management for X"
  homepage "https://www.semicomplete.com/projects/xdotool/"
  url "https://github.com/jordansissel/xdotool/archive/refs/tags/v4.20260303.1.tar.gz"
  sha256 "c1f971a384da588eb99ca0755fc4300316d49c1e612537e3f1de52215e104fa3"
  license "BSD-3-Clause"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d2bb7b186ced6333cbef857f93d351b348f3fa23e18935904adf82f7ff249f1e"
  end

  head "https://github.com/jordansissel/xdotool.git", branch: "main"



  depends_on "pkgconf" => :build
  depends_on "libx11"
  depends_on "libxi"
  depends_on "libxinerama"
  depends_on "libxkbcommon"
  depends_on "libxtst"

  def install
    system "make", "PREFIX=#{prefix}", "INSTALLMAN=#{man}", "install"
  end

  def caveats
    <<~EOS
      You will probably want to enable XTEST in your X11 server now by running:
        defaults write org.x.X11 enable_test_extensions -boolean true

      For the source of this useful hint:
        https://stackoverflow.com/questions/1264210/does-mac-x11-have-the-xtest-extension
    EOS
  end

  test do
    system bin/"xdotool", "--version"
  end
end
