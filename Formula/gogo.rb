class Gogo < Formula
  desc "面向红队的, 高性能高度自由可拓展的自动化扫描引擎 / A highly controllable and extensionable automated scanning eng"
  homepage "https://example.org/gogo"
  version "2.15.0"
  url "http://127.0.0.1:8080/brew/bottles/gogo--2.15.0.loongarch64.bottle.tar.gz"
  sha256 "64e440fd1f1d37d4e71108db7fd69a944214b6eaf0556aa9ec3e58bfe37a44f8"

  def install
    bin.install "gogo"
  end

  test do
    system "#{bin}/gogo"
  end
end
