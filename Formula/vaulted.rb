class Vaulted < Formula
  desc "Allows the secure storage and execution of environments"
  homepage "https://example.org/vaulted"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/vaulted--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "16a3786f62096a64110418a3fdf502cf6fe7f07a9e68c6997384fccf48c63e14"

  def install
    bin.install "vaulted"
  end

  test do
    system "#{bin}/vaulted"
  end
end
