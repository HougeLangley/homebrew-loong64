class Hostctl < Formula
  desc "Your dev tool to manage /etc/hosts like a pro!"
  homepage "https://example.org/hostctl"
  version "1.1.4"
  url "http://127.0.0.1:8080/brew/bottles/hostctl--1.1.4.loongarch64.bottle.tar.gz"
  sha256 "636a062f8a99f90c8a5f65fcad46e2022736a2aeff503fcc36ad9fbbae3e014b"

  def install
    bin.install "hostctl"
  end

  test do
    system "#{bin}/hostctl"
  end
end
