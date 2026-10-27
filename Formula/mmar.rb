class Mmar < Formula
  desc "mmar is a zero-dependency, self-hostable, cross-platform HTTP tunnel that exposes your loc"
  homepage "https://example.org/mmar"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/mmar--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "737598e65b9314459873318e662a3187c2bff9a08c2f462ebaea18eb00b57bfd"

  def install
    bin.install "mmar"
  end

  test do
    system "#{bin}/mmar"
  end
end
