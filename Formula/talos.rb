class Talos < Formula
  desc "Talos Linux is a modern Linux distribution built for Kubernetes."
  homepage "https://example.org/talos"
  version "1.14.5"
  url "http://127.0.0.1:8080/brew/bottles/talos--1.14.5.loongarch64.bottle.tar.gz"
  sha256 "82fa238a1043531dd11d9dcc9f996981f68491cf322d7cb139954c06b2b9220a"

  def install
    bin.install "talos"
  end

  test do
    system "#{bin}/talos"
  end
end
