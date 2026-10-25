class Eza < Formula
  desc "Modern replacement for ls"
  homepage "https://example.org/eza"
  version "0.23.5"
  url "http://127.0.0.1:8080/brew/bottles/eza--0.23.5.loongarch64.bottle.tar.gz"
  sha256 "51e16f7772b6f9c950e96698b05be0f6d3db54c7c365c60299634364257bee7c"

  def install
    bin.install "eza"
  end

  test do
    system "#{bin}/eza"
  end
end
