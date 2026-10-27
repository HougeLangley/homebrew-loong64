class Feishu2md < Formula
  desc "Convert feishu/larksuite documents to markdown"
  homepage "https://example.org/feishu2md"
  version "2.4.5"
  url "http://127.0.0.1:8080/brew/bottles/feishu2md--2.4.5.loongarch64.bottle.tar.gz"
  sha256 "dc091da1d624bbd635c9ecdf002b11f466d6250b02dd7f13e7350bb699ea075e"

  def install
    bin.install "feishu2md"
  end

  test do
    system "#{bin}/feishu2md"
  end
end
