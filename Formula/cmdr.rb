class Cmdr < Formula
  desc "POSIX-compliant command-line UI (CLI) parser and Hierarchical-configuration operations"
  homepage "https://example.org/cmdr"
  version "2.2.9"
  url "http://127.0.0.1:8080/brew/bottles/cmdr--2.2.9.loongarch64.bottle.tar.gz"
  sha256 "4c2a0366052db95bbeb61ffc3eec891df9184bab121ac7effa68897037f2a160"

  def install
    bin.install "cmdr"
  end

  test do
    system "#{bin}/cmdr"
  end
end
