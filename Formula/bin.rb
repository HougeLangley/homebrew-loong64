class Bin < Formula
  desc "Effortless binary manager"
  homepage "https://example.org/bin"
  version "0.29.4"
  url "http://127.0.0.1:8080/brew/bottles/bin--0.29.4.loongarch64.bottle.tar.gz"
  sha256 "6641604ddf1ee9fb9e7741fc883c77248c5fbe4dc68d45420488d39cd08eb706"

  def install
    bin.install "bin"
  end

  test do
    system "#{bin}/bin"
  end
end
