class Yq < Formula
  desc "Portable command-line YAML processor"
  homepage "https://example.org/yq"
  version "4.54.1"
  url "http://127.0.0.1:8080/brew/bottles/yq--4.54.1.loongarch64.bottle.tar.gz"
  sha256 "9f8becb5a18cd511bfbe91ebe849862c52a024435fe5a9503e6d902e2477d26e"

  def install
    bin.install "yq"
  end

  test do
    system "#{bin}/yq"
  end
end
