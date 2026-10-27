class Dasel < Formula
  desc "Unified querying, transformation, and modification of JSON, TOML, YAML, XML, INI, HCL, KDL"
  homepage "https://example.org/dasel"
  version "3.11.2"
  url "http://127.0.0.1:8080/brew/bottles/dasel--3.11.2.loongarch64.bottle.tar.gz"
  sha256 "08db4dc60d521bd0283fae47ad445cd50827ce091aa7aea87f42d0f1c3511cf8"

  def install
    bin.install "dasel"
  end

  test do
    system "#{bin}/dasel"
  end
end
