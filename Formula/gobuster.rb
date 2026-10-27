class Gobuster < Formula
  desc "Directory/file & DNS busting tool written in Go"
  homepage "https://example.org/gobuster"
  version "3.8.2"
  url "http://127.0.0.1:8080/brew/bottles/gobuster--3.8.2.loongarch64.bottle.tar.gz"
  sha256 "4f2b83e393a4b050d773694b4745b8d9956823bff3eaf297b5e8440a680fb819"

  def install
    bin.install "gobuster"
  end

  test do
    system "#{bin}/gobuster"
  end
end
