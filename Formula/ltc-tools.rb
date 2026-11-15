class LtcTools < Formula
  desc "Tools to deal with linear-timecode (LTC)"
  homepage "https://github.com/x42/ltc-tools"
  url "https://github.com/x42/ltc-tools/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "5b7a2ab7f98bef6c99bafbbc5605a3364e01c9c19fe81411ddea0e1a01cd6287"
  license "GPL-2.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "774b41593ed4166db42430275c1cfb2e26dd8f2a6e4fd33f848dc98bcdba29f0"
  end

  head "https://github.com/x42/ltc-tools.git", branch: "master"



  depends_on "help2man" => :build
  depends_on "pkgconf" => :build
  depends_on "jack"
  depends_on "libltc"
  depends_on "libsndfile"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"ltcgen", "test.wav"
    system bin/"ltcdump", "test.wav"
  end
end
