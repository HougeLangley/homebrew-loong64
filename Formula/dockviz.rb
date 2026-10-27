class Dockviz < Formula
  desc "Visualizing docker data"
  homepage "https://example.org/dockviz"
  version "0.6.4"
  url "http://127.0.0.1:8080/brew/bottles/dockviz--0.6.4.loongarch64.bottle.tar.gz"
  sha256 "790acf94138e393f6565749c176fe0f88c3aa509c362129ecaa2317210cef46b"

  def install
    bin.install "dockviz"
  end

  test do
    system "#{bin}/dockviz"
  end
end
