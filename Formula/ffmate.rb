class Ffmate < Formula
  desc "FFmpeg automation layer"
  homepage "https://example.org/ffmate"
  version "2.0.18"
  url "http://127.0.0.1:8080/brew/bottles/ffmate--2.0.18.loongarch64.bottle.tar.gz"
  sha256 "b8f5b587ca727ae9798615b03b23317a4351df56bbddbfd8f25732451ca5319b"

  def install
    bin.install "ffmate"
  end

  test do
    system "#{bin}/ffmate"
  end
end
