class Goss < Formula
  desc "Quick and Easy server testing/validation"
  homepage "https://example.org/goss"
  version "0.4.10"
  url "http://127.0.0.1:8080/brew/bottles/goss--0.4.10.loongarch64.bottle.tar.gz"
  sha256 "4079b5442de498ed3c2b6a6366dec99bf5ce8d5e4a7ce7f4079650e99496e7c9"

  def install
    bin.install "goss"
  end

  test do
    system "#{bin}/goss"
  end
end
