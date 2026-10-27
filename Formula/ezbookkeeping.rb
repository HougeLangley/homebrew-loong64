class Ezbookkeeping < Formula
  desc "ezBookkeeping is an open source, powerful, self-hosted personal finance app that is easy t"
  homepage "https://example.org/ezbookkeeping"
  version "2.1.1"
  url "http://127.0.0.1:8080/brew/bottles/ezbookkeeping--2.1.1.loongarch64.bottle.tar.gz"
  sha256 "d68c29f8e3d5606e291c7fc9a4f06c682db1485250cfc5bfd88cc5819d4b81fb"

  def install
    bin.install "ezbookkeeping"
  end

  test do
    system "#{bin}/ezbookkeeping"
  end
end
