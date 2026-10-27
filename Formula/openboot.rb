class Openboot < Formula
  desc "Set up your Mac dev environment in one command — CLI + Web Dashboard + Team sharing"
  homepage "https://example.org/openboot"
  version "1.0.5"
  url "http://127.0.0.1:8080/brew/bottles/openboot--1.0.5.loongarch64.bottle.tar.gz"
  sha256 "b4c0e52fb2a29d50657d9695baf215bd9e5d910c8108df31085c9500dcbe71e3"

  def install
    bin.install "openboot"
  end

  test do
    system "#{bin}/openboot"
  end
end
