class Showkey < Formula
  desc "Simple keystroke visualizer"
  homepage "http://www.catb.org/~esr/showkey/"
  url "https://gitlab.com/esr/showkey/-/archive/1.10/showkey-1.10.tar.bz2"
  sha256 "f4b4ff9c9655401483c60c1be6f19326560e62e854092477be037a3bb2b7fbde"
  license "MIT"
  head "https://gitlab.com/esr/showkey.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f7c848429fa182ea0fc1f3c1e210c3cf03ffaabc1622b60339f21397ae231127"
  end

  # The homepage links to the `stable` tarball but it can take longer than the
  # ten second livecheck timeout, so we check the Git tags as a workaround.
  livecheck do
    url :head
    regex(/^v?(\d+(?:[.-]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("-", ".") }
    end
  end



  depends_on "asciidoctor" => :build

  def install
    system "make", "showkey", "showkey.1"
    bin.install "showkey"
    man1.install "showkey.1"
  end

  test do
    require "expect"

    args = if OS.linux?
      ["script", "-q", "/dev/null", "-c", bin/"showkey"]
    else
      ["script", "-q", "/dev/null", bin/"showkey"]
    end

    output = Utils.safe_popen_write(*args) do |pipe|
      pipe.expect(/interrupt .*? or quit .*? character\.\r?\n$/)
      pipe.write "Hello Homebrew!"
      sleep 1
      pipe.write "\cC\cD"
    end

    assert_match "Hello<SP>Homebrew!", output
  end
end
