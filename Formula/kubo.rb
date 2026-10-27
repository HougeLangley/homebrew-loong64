class Kubo < Formula
  desc "Peer-to-peer hypermedia protocol"
  homepage "https://example.org/kubo"
  version "0.43.1"
  url "http://127.0.0.1:8080/brew/bottles/kubo--0.43.1.loongarch64.bottle.tar.gz"
  sha256 "16a1773a8be375476ec5f879aca642e30ef6471383899b172de7d2db8ce1018d"

  def install
    bin.install "kubo"
  end

  test do
    system "#{bin}/kubo"
  end
end
