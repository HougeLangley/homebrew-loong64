class Ghorg < Formula
  desc "Quickly clone or backup massive amounts of org/users repositories into one directory - Sup"
  homepage "https://example.org/ghorg"
  version "1.11.16"
  url "http://127.0.0.1:8080/brew/bottles/ghorg--1.11.16.loongarch64.bottle.tar.gz"
  sha256 "1b44392e664a0e47420323013263e97db04177db0b98a6a2167689ba6c2a963e"

  def install
    bin.install "ghorg"
  end

  test do
    system "#{bin}/ghorg"
  end
end
