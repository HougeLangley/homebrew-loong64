class Flipt < Formula
  desc "Enterprise-ready, Git native feature management solution"
  homepage "https://example.org/flipt"
  version "2.14.1"
  url "http://127.0.0.1:8080/brew/bottles/flipt--2.14.1.loongarch64.bottle.tar.gz"
  sha256 "ffe4dbc582e189db3649c97c351edf9b5be6a72897a236b15ebdb84abcf9fecf"

  def install
    bin.install "flipt"
  end

  test do
    system "#{bin}/flipt"
  end
end
