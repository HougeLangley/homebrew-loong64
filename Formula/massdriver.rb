class Massdriver < Formula
  desc "Manage applications and infrastructure on Massdriver Cloud"
  homepage "https://example.org/massdriver"
  version "2.5.0"
  url "http://127.0.0.1:8080/brew/bottles/massdriver--2.5.0.loongarch64.bottle.tar.gz"
  sha256 "4a3f374fe45daf55189a934e9646b553d1f7aa8a8b29e1c4678f3d5a4b5eb46c"

  def install
    bin.install "massdriver"
  end

  test do
    system "#{bin}/massdriver"
  end
end
