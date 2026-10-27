class Hz < Formula
  desc "Golang HTTP framework for microservices"
  homepage "https://example.org/hz"
  version "0.10.6"
  url "http://127.0.0.1:8080/brew/bottles/hz--0.10.6.loongarch64.bottle.tar.gz"
  sha256 "30a378f6f460d580bb1106a1ed0e95b8f8fb92409778da9e26d6de5351e509b2"

  def install
    bin.install "hz"
  end

  test do
    system "#{bin}/hz"
  end
end
