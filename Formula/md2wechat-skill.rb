class Md2wechat-skill < Formula
  desc "面向 AI Agent 的微信公众号创作与发布 CLI：Markdown 排版、AI 配图、预览与草稿创建；支持由浏览器 Agent 保存知乎、CSDN、头条未发布草稿。"
  homepage "https://example.org/md2wechat-skill"
  version "3.8.0"
  url "http://127.0.0.1:8080/brew/bottles/md2wechat-skill--3.8.0.loongarch64.bottle.tar.gz"
  sha256 "6ab3013d8c77f8f38822dffb47fc23d4e7863437b4d7be2d29000f3d4d90b1a9"

  def install
    bin.install "md2wechat-skill"
  end

  test do
    system "#{bin}/md2wechat-skill"
  end
end
