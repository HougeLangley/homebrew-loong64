class Portop < Formula
  desc "htop for your ports. Inspect processes, Docker & systemd, detect port drift, audit Compose"
  homepage "https://example.org/portop"
  version "0.3.1"
  url "http://127.0.0.1:8080/brew/bottles/portop--0.3.1.loongarch64.bottle.tar.gz"
  sha256 "fdeb51556934814009d72e135731bd9166f4303b47ca4e20e796a9ed26b92329"

  def install
    bin.install "portop"
  end

  test do
    system "#{bin}/portop"
  end
end
