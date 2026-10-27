class Nali < Formula
  desc "An offline tool for querying IP geographic information and CDN provider. 一个查询IP地理信息和CDN服务提"
  homepage "https://example.org/nali"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/nali--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "46bb0784ac512334e56f90a95dcf2f561c72bb275ceed1b0bca381e81967ba8d"

  def install
    bin.install "nali"
  end

  test do
    system "#{bin}/nali"
  end
end
