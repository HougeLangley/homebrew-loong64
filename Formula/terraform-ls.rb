class Terraform-ls < Formula
  desc "Terraform Language Server"
  homepage "https://example.org/terraform-ls"
  version "0.39.0"
  url "http://127.0.0.1:8080/brew/bottles/terraform-ls--0.39.0.loongarch64.bottle.tar.gz"
  sha256 "d99a9ce6ddc488b8b7c5044f7f23bb3d0c0b01eab6545202d66c81bd8c584918"

  def install
    bin.install "terraform-ls"
  end

  test do
    system "#{bin}/terraform-ls"
  end
end
