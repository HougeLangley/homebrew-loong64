class Clop < Formula
  desc "^=^ clop是基于struct的命令行解析库，专注是它的灵魂，像AK47一样，简单，强大，专注，让命令行里面的疑难杂症统统走开[从零实现]"
  homepage "https://example.org/clop"
  version "0.2.12"
  url "http://127.0.0.1:8080/brew/bottles/clop--0.2.12.loongarch64.bottle.tar.gz"
  sha256 "bf34a153b549b1c8323ea024b11fb4aff9796df91f937a842af58c3c0198c382"

  def install
    bin.install "clop"
  end

  test do
    system "#{bin}/clop"
  end
end
