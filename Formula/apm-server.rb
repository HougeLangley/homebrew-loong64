class Apm-server < Formula
  desc "apm-server for loongarch64"
  homepage "https://example.org/apm-server"
  version "9.5.5"
  url "http://127.0.0.1:8080/brew/bottles/apm-server--9.5.5.loongarch64.bottle.tar.gz"
  sha256 "f58256137e26cc1655fc4ca7a5463ff44a75c43c491e4d7799f9be9906c4dfbd"

  def install
    bin.install "apm-server"
  end

  test do
    system "#{bin}/apm-server"
  end
end
