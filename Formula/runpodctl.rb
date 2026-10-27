class Runpodctl < Formula
  desc "interact with Runpod via the cli"
  homepage "https://example.org/runpodctl"
  version "3.0.1"
  url "http://127.0.0.1:8080/brew/bottles/runpodctl--3.0.1.loongarch64.bottle.tar.gz"
  sha256 "98b96df87a0f64c92984f88fe30ead82f70a44dcd2b5df91c04d0715418f1f67"

  def install
    bin.install "runpodctl"
  end

  test do
    system "#{bin}/runpodctl"
  end
end
