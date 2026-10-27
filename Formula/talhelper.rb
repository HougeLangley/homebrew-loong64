class Talhelper < Formula
  desc "Configuration helper for talos clusters"
  homepage "https://example.org/talhelper"
  version "3.1.17"
  url "http://127.0.0.1:8080/brew/bottles/talhelper--3.1.17.loongarch64.bottle.tar.gz"
  sha256 "22e0312cf2b7a15a0ae07f967e49e3066a33ad35d1c8ee693ec51a7e323f6075"

  def install
    bin.install "talhelper"
  end

  test do
    system "#{bin}/talhelper"
  end
end
