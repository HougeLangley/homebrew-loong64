class Grmon < Formula
  desc "Command line monitoring for goroutines"
  homepage "https://example.org/grmon"
  version "0.1"
  url "http://127.0.0.1:8080/brew/bottles/grmon--0.1.loongarch64.bottle.tar.gz"
  sha256 "683bb9186eee6993051badee010fcaa9f0f63ec5f51a16e560f726c7c543cf87"

  def install
    bin.install "grmon"
  end

  test do
    system "#{bin}/grmon"
  end
end
