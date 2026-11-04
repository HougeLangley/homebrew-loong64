class Bsdconv < Formula
  desc "Charset/encoding converter library"
  homepage "https://github.com/buganini/bsdconv"
  url "https://github.com/buganini/bsdconv/archive/refs/tags/11.7.tar.gz"
  sha256 "c7ce9b7fd5a80f5da36dfbf2b49ca86f67088b006d26f708fcc1112b7c1feafc"
  license "BSD-2-Clause"
  head "https://github.com/buganini/bsdconv.git", branch: "master"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a9e300ef78dfc1f413080e31a33e0b12e55332ed1c64173c64ab6fc07b0f6338"
  end



  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    output = pipe_output("#{bin}/bsdconv BIG5:UTF-8", "\263\134\273\134", 0)
    output.force_encoding("UTF-8") if output.respond_to?(:force_encoding)
    assert_equal "許蓋", output
  end
end
