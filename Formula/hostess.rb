class Hostess < Formula
  desc "Idempotent command-line utility for managing your /etc/hosts file"
  homepage "https://example.org/hostess"
  version "0.5.2"
  url "http://127.0.0.1:8080/brew/bottles/hostess--0.5.2.loongarch64.bottle.tar.gz"
  sha256 "42b494fe5fb8332d4e21fc6d7104bca64fcafbe9f654c9ad9b76825b312df06a"

  def install
    bin.install "hostess"
  end

  test do
    system "#{bin}/hostess"
  end
end
