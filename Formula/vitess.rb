class Vitess < Formula
  desc "Vitess is a database clustering system for horizontal scaling of MySQL."
  homepage "https://example.org/vitess"
  version "24.0.5"
  url "http://127.0.0.1:8080/brew/bottles/vitess--24.0.5.loongarch64.bottle.tar.gz"
  sha256 "b511cf8ffc9a77fd7341799a7592eea7763565f7d1844f2516354380df6d0c39"

  def install
    bin.install "vitess"
  end

  test do
    system "#{bin}/vitess"
  end
end
