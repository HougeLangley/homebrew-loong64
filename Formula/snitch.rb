class Snitch < Formula
  desc "Prettier way to inspect network connections"
  homepage "https://example.org/snitch"
  version "0.2.2"
  url "http://127.0.0.1:8080/brew/bottles/snitch--0.2.2.loongarch64.bottle.tar.gz"
  sha256 "2dfeca2f4bef4932bb6c66b999de4d977595ac5583235c253e40d660fa9db942"

  def install
    bin.install "snitch"
  end

  test do
    system "#{bin}/snitch"
  end
end
