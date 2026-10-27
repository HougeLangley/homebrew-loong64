class Checksec < Formula
  desc "Security feature auditing for ELF binaries and Linux kernels"
  homepage "https://example.org/checksec"
  version "3.2.0"
  url "http://127.0.0.1:8080/brew/bottles/checksec--3.2.0.loongarch64.bottle.tar.gz"
  sha256 "b77804e4bc58b97e21e7d9ce0be18d32cd6425e906f60215c361f69b11d114f0"

  def install
    bin.install "checksec"
  end

  test do
    system "#{bin}/checksec"
  end
end
