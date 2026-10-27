class Buildkitd < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit (Daemon)"
  homepage "https://example.org/buildkitd"
  version "0.34.1"
  url "http://127.0.0.1:8080/brew/bottles/buildkitd--0.34.1.loongarch64.bottle.tar.gz"
  sha256 "394f62a5e2f50132015a79ff5b3a87cc8d3b413ccbe702c97a4d0424aad91812"

  def install
    bin.install "buildkitd"
  end

  test do
    system "#{bin}/buildkitd"
  end
end
