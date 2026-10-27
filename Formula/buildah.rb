class Buildah < Formula
  desc "A tool that facilitates building OCI images."
  homepage "https://example.org/buildah"
  version "1.46.0"
  url "http://127.0.0.1:8080/brew/bottles/buildah--1.46.0.loongarch64.bottle.tar.gz"
  sha256 "e839106473e4f521de665006f1e38c7e5cb78941a795d7b39afd947c9ea052c1"

  def install
    bin.install "buildah"
  end

  test do
    system "#{bin}/buildah"
  end
end
