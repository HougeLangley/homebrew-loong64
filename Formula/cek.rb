class Cek < Formula
  desc "Explore the (overlay) filesystem and layers of OCI container images"
  homepage "https://example.org/cek"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/cek--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "c73a59bd4ce600a347fc863da1fc222613d92fc4007c7be58f697a4d188db974"

  def install
    bin.install "cek"
  end

  test do
    system "#{bin}/cek"
  end
end
