class Melange < Formula
  desc "Build APKs from source code"
  homepage "https://example.org/melange"
  version "0.63.2"
  url "http://127.0.0.1:8080/brew/bottles/melange--0.63.2.loongarch64.bottle.tar.gz"
  sha256 "a6f1327656af9fefb37cea166c45d9cc7df385382a1e213d4e152d354d37dae4"

  def install
    bin.install "melange"
  end

  test do
    system "#{bin}/melange"
  end
end
