class Terraform-graph-beautifier < Formula
  desc "CLI to beautify  output"
  homepage "https://example.org/terraform-graph-beautifier"
  version "0.3.4"
  url "http://127.0.0.1:8080/brew/bottles/terraform-graph-beautifier--0.3.4.loongarch64.bottle.tar.gz"
  sha256 "aed323ca7956567e33276787f7c920943ff117cd106a78ee10dcfc6eb4de9704"

  def install
    bin.install "terraform-graph-beautifier"
  end

  test do
    system "#{bin}/terraform-graph-beautifier"
  end
end
