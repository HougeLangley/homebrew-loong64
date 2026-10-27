class Chamber < Formula
  desc "CLI for managing secrets through AWS SSM Parameter Store"
  homepage "https://example.org/chamber"
  version "3.1.5"
  url "http://127.0.0.1:8080/brew/bottles/chamber--3.1.5.loongarch64.bottle.tar.gz"
  sha256 "1f2568eb1b2d7af813d1a3ced967e286f4ac55d2c47440f560f010fabaa558bc"

  def install
    bin.install "chamber"
  end

  test do
    system "#{bin}/chamber"
  end
end
