class Odt2txt < Formula
  desc "Convert OpenDocument files to plain text"
  homepage "https://github.com/dstosberg/odt2txt/"
  url "https://github.com/dstosberg/odt2txt/archive/refs/tags/v0.5.tar.gz"
  sha256 "23a889109ca9087a719c638758f14cc3b867a5dcf30a6c90bf6a0985073556dd"
  license "GPL-2.0-only"


  bottle do
    rebuild 4
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5280047f3b00b50d0a73f176d9fc66a89565e1d184df5988ac493bad9c150da7"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  resource "homebrew-sample", :test do
    url "https://github.com/Turbo87/odt2txt/raw/samples/samples/sample-1.odt"
    sha256 "78a5b17613376e50a66501ec92260d03d9d8106a9d98128f1efb5c07c8bfa0b2"
  end


  def install
    system "make", "install", "DESTDIR=#{prefix}"
  end

  test do
    testpath.install resource("homebrew-sample")
    system bin/"odt2txt", "sample-1.odt"
  end
end
