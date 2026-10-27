class Loki < Formula
  desc "Horizontally-scalable, highly-available log aggregation system"
  homepage "https://example.org/loki"
  version "3.7.9"
  url "http://127.0.0.1:8080/brew/bottles/loki--3.7.9.loongarch64.bottle.tar.gz"
  sha256 "7adf656c04eb8ed0388ae4724df188dff1a83790f4b5f165eed313fe8db4768c"

  def install
    bin.install "loki"
  end

  test do
    system "#{bin}/loki"
  end
end
