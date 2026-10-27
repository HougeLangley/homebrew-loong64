class Gama < Formula
  desc "Manage your GitHub Actions from Terminal with great UI 🧪"
  homepage "https://example.org/gama"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/gama--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "a2975207ef1e4871b41d80e3b12eda63692f6a8715bfa17deb50136cf676fa1f"

  def install
    bin.install "gama"
  end

  test do
    system "#{bin}/gama"
  end
end
