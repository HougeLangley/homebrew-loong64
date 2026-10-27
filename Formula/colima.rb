class Colima < Formula
  desc "Container runtimes on macOS (and Linux) with minimal setup"
  homepage "https://example.org/colima"
  version "0.10.3"
  url "http://127.0.0.1:8080/brew/bottles/colima--0.10.3.loongarch64.bottle.tar.gz"
  sha256 "4bd3424185b24cdec1b0f52bbf100f0ec7aaf29f922f9037189cf34175e287ed"

  def install
    bin.install "colima"
  end

  test do
    system "#{bin}/colima"
  end
end
