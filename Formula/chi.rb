class Chi < Formula
  desc "lightweight, idiomatic and composable router for building Go HTTP services"
  homepage "https://example.org/chi"
  version "5.5.0"
  url "http://127.0.0.1:8080/brew/bottles/chi--5.5.0.loongarch64.bottle.tar.gz"
  sha256 "689e0fd266c6ac9ebc3683b166fe56eab57ff493483d76fe98ed8158ab833215"

  def install
    bin.install "chi"
  end

  test do
    system "#{bin}/chi"
  end
end
