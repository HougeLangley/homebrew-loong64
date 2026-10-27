class Arduino-lint < Formula
  desc "Tool to check for problems with Arduino projects"
  homepage "https://example.org/arduino-lint"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/arduino-lint--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "238535b4526c4df974633db8c19ffaa1ad625acd7e60e963cf02c8f750ea6812"

  def install
    bin.install "arduino-lint"
  end

  test do
    system "#{bin}/arduino-lint"
  end
end
