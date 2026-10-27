class Git-flow-next < Formula
  desc "Modern implementation of the Git-flow branching model"
  homepage "https://example.org/git-flow-next"
  version "2.1.0"
  url "http://127.0.0.1:8080/brew/bottles/git-flow-next--2.1.0.loongarch64.bottle.tar.gz"
  sha256 "c421203b3f0b400fb84c177fc8fac26ca102ac8ba5ae7360c48ecc2df9e546c1"

  def install
    bin.install "git-flow-next"
  end

  test do
    system "#{bin}/git-flow-next"
  end
end
