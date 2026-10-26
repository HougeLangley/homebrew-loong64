class Jqp < Formula
  desc "TUI for jq"
  homepage "https://example.org/jqp"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/jqp--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "30f91d45cbc0e4ffba147ab6b1e3a6d24c47ed8e86ee2dad3043cf74bdbaa32a"

  def install
    bin.install "jqp"
  end

  test do
    system "#{bin}/jqp"
  end
end
