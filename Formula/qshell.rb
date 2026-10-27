class Qshell < Formula
  desc "Shell Tools for Qiniu Cloud"
  homepage "https://example.org/qshell"
  version "2.19.13"
  url "http://127.0.0.1:8080/brew/bottles/qshell--2.19.13.loongarch64.bottle.tar.gz"
  sha256 "abfae41a83cb7382682734b65af070aa307195e3eca57f5456c92269d9c9d43d"

  def install
    bin.install "qshell"
  end

  test do
    system "#{bin}/qshell"
  end
end
