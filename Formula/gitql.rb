class Gitql < Formula
  desc "💊 A git query language"
  homepage "https://example.org/gitql"
  version "2.3.1"
  url "http://127.0.0.1:8080/brew/bottles/gitql--2.3.1.loongarch64.bottle.tar.gz"
  sha256 "efaeeec20b25e9f2b335f180a0bb15121ff67bf946ef45f9469d92c322919aeb"

  def install
    bin.install "gitql"
  end

  test do
    system "#{bin}/gitql"
  end
end
