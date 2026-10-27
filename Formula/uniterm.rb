class Uniterm < Formula
  desc "All-in-one terminal covering 30+ protocols — SSH, RDP, SFTP, databases, Kubernetes and mor"
  homepage "https://example.org/uniterm"
  version "1.11.2"
  url "http://127.0.0.1:8080/brew/bottles/uniterm--1.11.2.loongarch64.bottle.tar.gz"
  sha256 "dfe6f70f53edeeb328c5c6a079b2e9b65f14623e0e99cd87fd58d35310f6ff5e"

  def install
    bin.install "uniterm"
  end

  test do
    system "#{bin}/uniterm"
  end
end
