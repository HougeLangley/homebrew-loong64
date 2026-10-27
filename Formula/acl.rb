class Acl < Formula
  desc "Commands for manipulating POSIX access control lists"
  homepage "https://example.org/acl"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/acl--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "d9d41108028ee12681bd6ddb36cc9a54715a5a96b165103fc315defc9f5cb0ac"

  def install
    bin.install "acl"
  end

  test do
    system "#{bin}/acl"
  end
end
