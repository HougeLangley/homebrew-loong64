class Tf-summarize < Formula
  desc "CLI to print the summary of the terraform plan"
  homepage "https://example.org/tf-summarize"
  version "0.3.20"
  url "http://127.0.0.1:8080/brew/bottles/tf-summarize--0.3.20.loongarch64.bottle.tar.gz"
  sha256 "da55b6749194d1f204c74b06f1653885c2e8f02569ee7ee32ef9530b29d33f8b"

  def install
    bin.install "tf-summarize"
  end

  test do
    system "#{bin}/tf-summarize"
  end
end
