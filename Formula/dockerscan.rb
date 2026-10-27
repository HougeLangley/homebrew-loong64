class Dockerscan < Formula
  desc "The Most Comprehensive Docker Security Scanner"
  homepage "https://example.org/dockerscan"
  version "2.1.0"
  url "http://127.0.0.1:8080/brew/bottles/dockerscan--2.1.0.loongarch64.bottle.tar.gz"
  sha256 "3abe2b9f64751178a0b80afd39d864937fc77d972b326a5be716d54d93521948"

  def install
    bin.install "dockerscan"
  end

  test do
    system "#{bin}/dockerscan"
  end
end
