class Hyperfine < Formula
  desc "Command-line benchmarking tool"
  homepage "https://example.org/hyperfine"
  version "2.0.0"
  url "http://127.0.0.1:8080/brew/bottles/hyperfine--2.0.0.loongarch64.bottle.tar.gz"
  sha256 "af23c9b3812b40bb4f8d138991ef13a582f494688872ea993ef475e3ee7a0e72"

  def install
    bin.install "hyperfine"
  end

  test do
    system "#{bin}/hyperfine"
  end
end
