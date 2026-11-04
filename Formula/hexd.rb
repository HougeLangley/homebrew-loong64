class Hexd < Formula
  desc "Colourful, human-friendly hexdump tool"
  homepage "https://github.com/FireyFly/hexd"
  url "https://github.com/FireyFly/hexd/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "de0db7205c8eb0f170263aca27f5d48963855345bc79ba4842edd21a938d0326"
  license "MIT"


  # BSD install does not understand the GNU "-D" flag
  patch do
    url "https://github.com/FireyFly/hexd/commit/ebfa9b5f76b5c71eea4fc003ab031f83615cea9b.patch?full_index=1"
    sha256 "620b0186cf47a7736c3636017d17dccb13e358c7d030821989ae4d6006192a1c"
    type :backport
    resolves "https://github.com/FireyFly/hexd/commit/ebfa9b5f76b5c71eea4fc003ab031f83615cea9b"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e9635dcf60c449f525c0d325345bef6d707335786db5aba26c70d0be4942c0af"
  end

  def install
    bin.mkdir
    man1.mkpath
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match(/0000\s+48/, pipe_output("#{bin}/hexd -p", "H"))
  end
end
