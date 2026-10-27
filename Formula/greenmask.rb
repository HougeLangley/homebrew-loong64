class Greenmask < Formula
  desc "Database anonymization and test data management"
  homepage "https://example.org/greenmask"
  version "0.2.26"
  url "http://127.0.0.1:8080/brew/bottles/greenmask--0.2.26.loongarch64.bottle.tar.gz"
  sha256 "2529faf2295380ec9e2fc399f4a8149812a35a4d095efb83179c9bc9f6d18d7a"

  def install
    bin.install "greenmask"
  end

  test do
    system "#{bin}/greenmask"
  end
end
