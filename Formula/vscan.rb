class Vscan < Formula
  desc "开源、轻量、快速、跨平台 的网站漏洞扫描工具，帮助您快速检测网站安全隐患。功能 端口扫描(port scan) 指纹识别(fingerprint) 漏洞检测(nday check)"
  homepage "https://example.org/vscan"
  version "2.1.0"
  url "http://127.0.0.1:8080/brew/bottles/vscan--2.1.0.loongarch64.bottle.tar.gz"
  sha256 "2be0fc06f855831f19c91528aeebeba7f1f74d4691ce7e56b828d1a9422545b5"

  def install
    bin.install "vscan"
  end

  test do
    system "#{bin}/vscan"
  end
end
