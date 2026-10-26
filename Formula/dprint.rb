class Dprint < Formula
  desc "Pluggable code formatter"
  homepage "https://example.org/dprint"
  version "0.64.3"
  url "http://127.0.0.1:8080/brew/bottles/dprint--0.64.3.loongarch64.bottle.tar.gz"
  sha256 "f7d8633f03e82d1b0ff0290a7cf232cec12a596b19bebc4dd5f5409628297a6b"

  def install
    bin.install "dprint"
  end

  test do
    system "#{bin}/dprint"
  end
end
