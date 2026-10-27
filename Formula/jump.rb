class Jump < Formula
  desc "Helps you navigate your file system faster by learning your habits"
  homepage "https://example.org/jump"
  version "0.69.0"
  url "http://127.0.0.1:8080/brew/bottles/jump--0.69.0.loongarch64.bottle.tar.gz"
  sha256 "2c86b6594383904a70c867b2cdb84bd3cd60eb6428675709caf4ede2b5067054"

  def install
    bin.install "jump"
  end

  test do
    system "#{bin}/jump"
  end
end
