class Ktea < Formula
  desc "Kafka TUI client"
  homepage "https://example.org/ktea"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/ktea--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "06aa044b4108d70b7cba570ffc2bb11b897e02932832a1cc66b08852f4861bfa"

  def install
    bin.install "ktea"
  end

  test do
    system "#{bin}/ktea"
  end
end
