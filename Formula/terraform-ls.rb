class Terraform-ls < Formula
  desc "Terraform Language Server"
  homepage "https://example.org/terraform-ls"
  version "0.39.0"
  url "http://127.0.0.1:8080/brew/bottles/terraform-ls--0.39.0.loongarch64.bottle.tar.gz"
  sha256 "7041e6285cc32fc1ce46361a24d3542d99992539227aa80b9345a4e419fdcbd3"

  def install
    bin.install "terraform-ls"
  end

  test do
    system "#{bin}/terraform-ls"
  end
end
