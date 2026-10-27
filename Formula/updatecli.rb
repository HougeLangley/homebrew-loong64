class Updatecli < Formula
  desc "A Declarative Update Policy Engine"
  homepage "https://example.org/updatecli"
  version "0.123.0"
  url "http://127.0.0.1:8080/brew/bottles/updatecli--0.123.0.loongarch64.bottle.tar.gz"
  sha256 "66ed223831811501d4d08d3428bfe62ac6ef855ad34efbfa273cc9fc864f9129"

  def install
    bin.install "updatecli"
  end

  test do
    system "#{bin}/updatecli"
  end
end
