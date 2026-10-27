class Fork-cleaner < Formula
  desc "Cleans up old and inactive forks on your GitHub account"
  homepage "https://example.org/fork-cleaner"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/fork-cleaner--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "091a928424517f5908315870a2f09462b41e782db0e8cc25ef2ce2a25ceeb006"

  def install
    bin.install "fork-cleaner"
  end

  test do
    system "#{bin}/fork-cleaner"
  end
end
