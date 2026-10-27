class Mox < Formula
  desc "Modern full-featured open source secure mail server"
  homepage "https://example.org/mox"
  version "0.0.17"
  url "http://127.0.0.1:8080/brew/bottles/mox--0.0.17.loongarch64.bottle.tar.gz"
  sha256 "4af8c0eead55256da84dc3244110cf157b633a219c41f6b9b31ce1687213f580"

  def install
    bin.install "mox"
  end

  test do
    system "#{bin}/mox"
  end
end
