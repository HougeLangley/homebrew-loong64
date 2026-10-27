class Tracee < Formula
  desc "Linux Runtime Security and Forensics using eBPF"
  homepage "https://example.org/tracee"
  version "0.24.1"
  url "http://127.0.0.1:8080/brew/bottles/tracee--0.24.1.loongarch64.bottle.tar.gz"
  sha256 "f7d88e765e4202e91ef68b18bf04abe756d18c2beac5d338f4d948f2acb7b34d"

  def install
    bin.install "tracee"
  end

  test do
    system "#{bin}/tracee"
  end
end
