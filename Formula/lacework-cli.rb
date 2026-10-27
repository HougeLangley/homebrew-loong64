class Lacework-cli < Formula
  desc "CLI for managing Lacework"
  homepage "https://example.org/lacework-cli"
  version "2.21.0"
  url "http://127.0.0.1:8080/brew/bottles/lacework-cli--2.21.0.loongarch64.bottle.tar.gz"
  sha256 "8a49eedec59ce524444bdddaa4c426f4648920df4cef0a0d0c862e13482b8414"

  def install
    bin.install "lacework-cli"
  end

  test do
    system "#{bin}/lacework-cli"
  end
end
