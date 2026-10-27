class Calico < Formula
  desc "Cloud native networking and network security"
  homepage "https://example.org/calico"
  version "3.33.0"
  url "http://127.0.0.1:8080/brew/bottles/calico--3.33.0.loongarch64.bottle.tar.gz"
  sha256 "e9decfb994e3f0b7db43eb396c2548621477646792473c0671a5d51e94b367c4"

  def install
    bin.install "calico"
  end

  test do
    system "#{bin}/calico"
  end
end
