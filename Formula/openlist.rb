class Openlist < Formula
  desc "New AList fork addressing anti-trust issues"
  homepage "https://example.org/openlist"
  version "4.2.9"
  url "http://127.0.0.1:8080/brew/bottles/openlist--4.2.9.loongarch64.bottle.tar.gz"
  sha256 "a3d138329e3ebf4e61adf3a25cb967b44305d68324045528046b05b07a7e41ad"

  def install
    bin.install "openlist"
  end

  test do
    system "#{bin}/openlist"
  end
end
