class Oh-my-reddit < Formula
  desc "Beautiful Reddit threads, live in your terminal"
  homepage "https://example.org/oh-my-reddit"
  version "0.1.5"
  url "http://127.0.0.1:8080/brew/bottles/oh-my-reddit--0.1.5.loongarch64.bottle.tar.gz"
  sha256 "ac2d9226c00a7762eee54a6f9542e19f686760decda77e62a8879c6f0038c86f"

  def install
    bin.install "oh-my-reddit"
  end

  test do
    system "#{bin}/oh-my-reddit"
  end
end
