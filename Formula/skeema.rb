class Skeema < Formula
  desc "Declarative pure-SQL schema management for MySQL and MariaDB"
  homepage "https://example.org/skeema"
  version "1.14.1"
  url "http://127.0.0.1:8080/brew/bottles/skeema--1.14.1.loongarch64.bottle.tar.gz"
  sha256 "1f7fab5f7867c51a13836990963129ad99302aba9a6cb16eb6c90d94a58bd058"

  def install
    bin.install "skeema"
  end

  test do
    system "#{bin}/skeema"
  end
end
