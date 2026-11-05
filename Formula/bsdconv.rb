class Bsdconv < Formula
  desc "Charset/encoding converter library"
  homepage "https://github.com/buganini/bsdconv"
  url "https://github.com/buganini/bsdconv/archive/refs/tags/11.7.tar.gz"
  sha256 "c7ce9b7fd5a80f5da36dfbf2b49ca86f67088b006d26f708fcc1112b7c1feafc"
  license "BSD-2-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0c1feb8f154a7e38d19ab0d146c6b2c99e9eddd2ccaa239970b4398e0bae6119"
  end

  head "https://github.com/buganini/bsdconv.git", branch: "master"



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
