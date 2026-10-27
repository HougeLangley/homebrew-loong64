class Beelzebub < Formula
  desc "A secure low code deception runtime framework, leveraging AI for System Virtualization."
  homepage "https://example.org/beelzebub"
  version "3.9.2"
  url "http://127.0.0.1:8080/brew/bottles/beelzebub--3.9.2.loongarch64.bottle.tar.gz"
  sha256 "80b4751cbe34326c621961c45c63b67dc63df208baf30f3228b26d8318cfbea5"

  def install
    bin.install "beelzebub"
  end

  test do
    system "#{bin}/beelzebub"
  end
end
