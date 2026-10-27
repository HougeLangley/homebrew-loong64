class Tfprovidercheck < Formula
  desc "CLI to prevent malicious Terraform Providers from being executed"
  homepage "https://example.org/tfprovidercheck"
  version "1.0.8"
  url "http://127.0.0.1:8080/brew/bottles/tfprovidercheck--1.0.8.loongarch64.bottle.tar.gz"
  sha256 "2eadb619c0146d88c1baffd600ad8d5fc8327df0d8bb486a13d162fcaf607f21"

  def install
    bin.install "tfprovidercheck"
  end

  test do
    system "#{bin}/tfprovidercheck"
  end
end
