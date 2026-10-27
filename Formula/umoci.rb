class Umoci < Formula
  desc "Reference OCI implementation for creating, modifying and inspecting images"
  homepage "https://example.org/umoci"
  version "0.6.0"
  url "http://127.0.0.1:8080/brew/bottles/umoci--0.6.0.loongarch64.bottle.tar.gz"
  sha256 "dbaacde1fbaea588ba8ad527b62f690725a777eccbbf036a443417ee849f1498"

  def install
    bin.install "umoci"
  end

  test do
    system "#{bin}/umoci"
  end
end
