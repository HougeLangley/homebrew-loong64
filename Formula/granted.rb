class Granted < Formula
  desc "Easiest way to access your cloud"
  homepage "https://example.org/granted"
  version "0.40.0"
  url "http://127.0.0.1:8080/brew/bottles/granted--0.40.0.loongarch64.bottle.tar.gz"
  sha256 "986335212a1a3f2a689add249aafbeec665b85e74f144752588d0815fc0d20f1"

  def install
    bin.install "granted"
  end

  test do
    system "#{bin}/granted"
  end
end
