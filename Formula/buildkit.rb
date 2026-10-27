class Buildkit < Formula
  desc "concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://example.org/buildkit"
  version "0.34.1"
  url "http://127.0.0.1:8080/brew/bottles/buildkit--0.34.1.loongarch64.bottle.tar.gz"
  sha256 "0cf900d39dba0fec75933df0c91f6576129b94c8b6fcde94919723e35cdfaa94"

  def install
    bin.install "buildkit"
  end

  test do
    system "#{bin}/buildkit"
  end
end
