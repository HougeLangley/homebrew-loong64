class Jshon < Formula
  desc "Parse, read, and create JSON from the shell"
  # Original homepage `http://kmkeen.com/jshon/` is refused to connect
  homepage "https://github.com/keenerd/jshon"
  url "https://github.com/keenerd/jshon/archive/refs/tags/20131105.tar.gz"
  sha256 "28420f6f02c6b762732898692cc0b0795cfe1a59fbfb24e67b80f332cf6d4fa2"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "69bfc23aeadb8bbccb135c84f72d2283997e1755315c6db456fee0171430b3e1"
  end

  depends_on "jansson"

  def install
    system "make"
    bin.install "jshon"
    man1.install "jshon.1"
  end

  test do
    (testpath/"test.json").write <<~JSON
      {"a":1,"b":2}
    JSON

    assert_equal "2", pipe_output("#{bin}/jshon -l < test.json").strip
  end
end
