class Hcledit < Formula
  desc "Command-line editor for HCL"
  homepage "https://example.org/hcledit"
  version "0.2.19"
  url "http://127.0.0.1:8080/brew/bottles/hcledit--0.2.19.loongarch64.bottle.tar.gz"
  sha256 "2e0de2368232285e917ce7a41586922fd69257d9472d3e7381dd43662709cf7e"

  def install
    bin.install "hcledit"
  end

  test do
    system "#{bin}/hcledit"
  end
end
