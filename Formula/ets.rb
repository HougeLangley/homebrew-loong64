class Ets < Formula
  desc "Command output timestamper"
  homepage "https://example.org/ets"
  version "0.2.2"
  url "http://127.0.0.1:8080/brew/bottles/ets--0.2.2.loongarch64.bottle.tar.gz"
  sha256 "1a5700ce09a940e2864045b84842d77c0a39c5c1f33e123efa5c44771d0e3aed"

  def install
    bin.install "ets"
  end

  test do
    system "#{bin}/ets"
  end
end
