class Jfrog-cli < Formula
  desc "Command-line interface for JFrog products"
  homepage "https://example.org/jfrog-cli"
  version "2.128.0"
  url "http://127.0.0.1:8080/brew/bottles/jfrog-cli--2.128.0.loongarch64.bottle.tar.gz"
  sha256 "ebee83949fa919c545c8f45873cb30c419d34394b9e96fdabff19b032abe9883"

  def install
    bin.install "jfrog-cli"
  end

  test do
    system "#{bin}/jfrog-cli"
  end
end
