class Dagger < Formula
  desc "Automation engine to build, test and ship any codebase. Runs locally, in CI, or directly i"
  homepage "https://example.org/dagger"
  version "0.21.11"
  url "http://127.0.0.1:8080/brew/bottles/dagger--0.21.11.loongarch64.bottle.tar.gz"
  sha256 "ce6d679390400c60c6a8c3f5d731f13a611e0c64b0073d8cfece31ee23bb55ab"

  def install
    bin.install "dagger"
  end

  test do
    system "#{bin}/dagger"
  end
end
