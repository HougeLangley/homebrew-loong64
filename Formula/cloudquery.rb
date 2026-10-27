class Cloudquery < Formula
  desc "Data pipelines for cloud config and security data. Build cloud asset inventory, CSPM, FinO"
  homepage "https://example.org/cloudquery"
  version "cli-v6.49.2"
  url "http://127.0.0.1:8080/brew/bottles/cloudquery--cli-v6.49.2.loongarch64.bottle.tar.gz"
  sha256 "789a4dc9be1b5c48284fec416eefb5683d287e9fe5d40a9f88634078a5e963e8"

  def install
    bin.install "cloudquery"
  end

  test do
    system "#{bin}/cloudquery"
  end
end
