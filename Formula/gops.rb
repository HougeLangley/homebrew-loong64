class Gops < Formula
  desc "Tool to list and diagnose Go processes currently running on your system"
  homepage "https://example.org/gops"
  version "0.3.29"
  url "http://127.0.0.1:8080/brew/bottles/gops--0.3.29.loongarch64.bottle.tar.gz"
  sha256 "25c1ef1a487a2752edfd03a71fdda498a87cb06732975814c9823dea372c9ad4"

  def install
    bin.install "gops"
  end

  test do
    system "#{bin}/gops"
  end
end
