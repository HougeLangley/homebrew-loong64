class Openfga < Formula
  desc "A high-performance and flexible authorization/permission engine built for developers and i"
  homepage "https://example.org/openfga"
  version "1.22.0"
  url "http://127.0.0.1:8080/brew/bottles/openfga--1.22.0.loongarch64.bottle.tar.gz"
  sha256 "8c7b85a0bb4284d4da521462793f768a02c5da525ede87e027b84c9d07ee1c89"

  def install
    bin.install "openfga"
  end

  test do
    system "#{bin}/openfga"
  end
end
