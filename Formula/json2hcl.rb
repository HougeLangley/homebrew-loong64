class Json2hcl < Formula
  desc "Convert JSON to HCL, and vice versa"
  homepage "https://example.org/json2hcl"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/json2hcl--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "396fb1b1d3bf83e0cf9b8e14375fffd5fa8dcd4f58002daf06a109b00dd5e2c9"

  def install
    bin.install "json2hcl"
  end

  test do
    system "#{bin}/json2hcl"
  end
end
