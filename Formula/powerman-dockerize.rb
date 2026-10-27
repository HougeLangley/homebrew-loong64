class Powerman-dockerize < Formula
  desc "Utility to simplify running applications in docker containers"
  homepage "https://example.org/powerman-dockerize"
  version "0.25.4"
  url "http://127.0.0.1:8080/brew/bottles/powerman-dockerize--0.25.4.loongarch64.bottle.tar.gz"
  sha256 "5083d7b357124ee6487d711e7e1458a2cf4943cfdad9503d26882104634cbb31"

  def install
    bin.install "powerman-dockerize"
  end

  test do
    system "#{bin}/powerman-dockerize"
  end
end
