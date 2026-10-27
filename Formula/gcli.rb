class Gcli < Formula
  desc "🖥 Go CLI application, tool library, running CLI commands, support console color, user inte"
  homepage "https://example.org/gcli"
  version "3.8.5"
  url "http://127.0.0.1:8080/brew/bottles/gcli--3.8.5.loongarch64.bottle.tar.gz"
  sha256 "6d20e882f820524fe6e748d2914a09470c4a8ce00ecfe870ae0766e16c5213ee"

  def install
    bin.install "gcli"
  end

  test do
    system "#{bin}/gcli"
  end
end
