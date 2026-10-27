class Kosli-cli < Formula
  desc "CLI for managing Kosli"
  homepage "https://example.org/kosli-cli"
  version "2.49.0"
  url "http://127.0.0.1:8080/brew/bottles/kosli-cli--2.49.0.loongarch64.bottle.tar.gz"
  sha256 "b69c6a76097e39b857024ef2da6e4abccc6f09a4c9a65cb1463eafddca172a2f"

  def install
    bin.install "kosli-cli"
  end

  test do
    system "#{bin}/kosli-cli"
  end
end
