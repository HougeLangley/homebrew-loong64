class Mmark < Formula
  desc "Powerful markdown processor in Go geared towards the IETF"
  homepage "https://example.org/mmark"
  version "2.2.48"
  url "http://127.0.0.1:8080/brew/bottles/mmark--2.2.48.loongarch64.bottle.tar.gz"
  sha256 "27d0fbf8850dfba5adbe47b8d88033d9131715681b8ddba0da211823625cd782"

  def install
    bin.install "mmark"
  end

  test do
    system "#{bin}/mmark"
  end
end
