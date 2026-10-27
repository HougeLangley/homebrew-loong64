class Flamingo < Formula
  desc "Flux Subsystem for Argo"
  homepage "https://example.org/flamingo"
  version "0.10.2"
  url "http://127.0.0.1:8080/brew/bottles/flamingo--0.10.2.loongarch64.bottle.tar.gz"
  sha256 "63e89f6841fe533cc779695354c816c6ee1567ec01764da7401c261859ba73b1"

  def install
    bin.install "flamingo"
  end

  test do
    system "#{bin}/flamingo"
  end
end
