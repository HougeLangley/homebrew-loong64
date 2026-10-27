class Logcli < Formula
  desc "Run LogQL queries against a Loki server"
  homepage "https://example.org/logcli"
  version "3.7.9"
  url "http://127.0.0.1:8080/brew/bottles/logcli--3.7.9.loongarch64.bottle.tar.gz"
  sha256 "0ba4a2a894c90555275bb0daf81645125aa3f57d8e7110ea78178d72ee0e636c"

  def install
    bin.install "logcli"
  end

  test do
    system "#{bin}/logcli"
  end
end
