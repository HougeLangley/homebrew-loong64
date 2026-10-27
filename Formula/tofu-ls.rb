class Tofu-ls < Formula
  desc "OpenTofu Language Server"
  homepage "https://example.org/tofu-ls"
  version "0.5.3"
  url "http://127.0.0.1:8080/brew/bottles/tofu-ls--0.5.3.loongarch64.bottle.tar.gz"
  sha256 "9af1ad75215f4fb1e9bf2d11dec6d23d8a945b6df4464a68650cc222d853cf45"

  def install
    bin.install "tofu-ls"
  end

  test do
    system "#{bin}/tofu-ls"
  end
end
