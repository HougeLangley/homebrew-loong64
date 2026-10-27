class Terraform-graph-beautifier < Formula
  desc "CLI to beautify  output"
  homepage "https://example.org/terraform-graph-beautifier"
  version "0.3.4"
  url "http://127.0.0.1:8080/brew/bottles/terraform-graph-beautifier--0.3.4.loongarch64.bottle.tar.gz"
  sha256 "b932c377bbbb39caf1949489801e1a2ec6e965fca2b83be96201c0abf63f4374"

  def install
    bin.install "terraform-graph-beautifier"
  end

  test do
    system "#{bin}/terraform-graph-beautifier"
  end
end
