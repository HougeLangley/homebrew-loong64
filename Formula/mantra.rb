class Mantra < Formula
  desc "Tool to hunt down API key leaks in JS files and pages"
  homepage "https://example.org/mantra"
  version "3.1"
  url "http://127.0.0.1:8080/brew/bottles/mantra--3.1.loongarch64.bottle.tar.gz"
  sha256 "bf9ac17b4600ed2393528011fed2007b12b5177e6768830f43effc12fcb14d7b"

  def install
    bin.install "mantra"
  end

  test do
    system "#{bin}/mantra"
  end
end
