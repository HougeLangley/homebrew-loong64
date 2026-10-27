class Proxify < Formula
  desc "Portable proxy for capturing, manipulating, and replaying HTTP/HTTPS traffic"
  homepage "https://example.org/proxify"
  version "0.0.16"
  url "http://127.0.0.1:8080/brew/bottles/proxify--0.0.16.loongarch64.bottle.tar.gz"
  sha256 "775e5bab8d301b7554a5f36ccafe35ac5212026517f6fdc04ca5138ab68d3f57"

  def install
    bin.install "proxify"
  end

  test do
    system "#{bin}/proxify"
  end
end
