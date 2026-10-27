class Skeema < Formula
  desc "Declarative pure-SQL schema management for MySQL and MariaDB"
  homepage "https://example.org/skeema"
  version "1.14.1"
  url "http://127.0.0.1:8080/brew/bottles/skeema--1.14.1.loongarch64.bottle.tar.gz"
  sha256 "6b04f03f1670ad4310dba741e1841adb1959515b359d331ac9232da006bfb1f8"

  def install
    bin.install "skeema"
  end

  test do
    system "#{bin}/skeema"
  end
end
