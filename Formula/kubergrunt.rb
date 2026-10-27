class Kubergrunt < Formula
  desc "Collection of commands to fill in the gaps between Terraform, Helm, and Kubectl"
  homepage "https://example.org/kubergrunt"
  version "0.19.0"
  url "http://127.0.0.1:8080/brew/bottles/kubergrunt--0.19.0.loongarch64.bottle.tar.gz"
  sha256 "f03928a07d6bcd34353ede05ec1e90d378726a849cb6713c934dd2c583ecd46a"

  def install
    bin.install "kubergrunt"
  end

  test do
    system "#{bin}/kubergrunt"
  end
end
