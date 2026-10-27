class Ipsw < Formula
  desc "Research tool for iOS & macOS devices"
  homepage "https://example.org/ipsw"
  version "3.1.739"
  url "http://127.0.0.1:8080/brew/bottles/ipsw--3.1.739.loongarch64.bottle.tar.gz"
  sha256 "f555cba7f667d9d265341dc157bf69ae957f82958f433af77f9eb829366a7483"

  def install
    bin.install "ipsw"
  end

  test do
    system "#{bin}/ipsw"
  end
end
