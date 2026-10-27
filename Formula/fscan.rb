class Fscan < Formula
  desc "一款内网综合扫描工具，方便一键自动化、全方位漏扫扫描。(An intranet comprehensive scanning tool, enabling one-click au"
  homepage "https://example.org/fscan"
  version "2.2.2"
  url "http://127.0.0.1:8080/brew/bottles/fscan--2.2.2.loongarch64.bottle.tar.gz"
  sha256 "f1aba4299444c08483465f7199ab715a11814d331c04cf3c4e0b2bb8e75ef290"

  def install
    bin.install "fscan"
  end

  test do
    system "#{bin}/fscan"
  end
end
