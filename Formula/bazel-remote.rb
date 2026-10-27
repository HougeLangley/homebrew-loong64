class Bazel-remote < Formula
  desc "Remote cache for Bazel"
  homepage "https://example.org/bazel-remote"
  version "2.6.4"
  url "http://127.0.0.1:8080/brew/bottles/bazel-remote--2.6.4.loongarch64.bottle.tar.gz"
  sha256 "dfe1a6274d8dd5159e24f979e4ced11bdbd8811ce44b2e99d655b4c8b973066d"

  def install
    bin.install "bazel-remote"
  end

  test do
    system "#{bin}/bazel-remote"
  end
end
