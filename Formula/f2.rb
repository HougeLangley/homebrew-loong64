class F2 < Formula
  desc "Command-line batch renaming tool"
  homepage "https://example.org/f2"
  version "2.2.2"
  url "http://127.0.0.1:8080/brew/bottles/f2--2.2.2.loongarch64.bottle.tar.gz"
  sha256 "f85e7e5cd3915ba932f73c9d6553c3f10ef7d9de46e6007b9d02e3f20536ad18"

  def install
    bin.install "f2"
  end

  test do
    system "#{bin}/f2"
  end
end
