class Ld-find-code-refs < Formula
  desc "Build tool for sending feature flag code references to LaunchDarkly"
  homepage "https://example.org/ld-find-code-refs"
  version "2.18.4"
  url "http://127.0.0.1:8080/brew/bottles/ld-find-code-refs--2.18.4.loongarch64.bottle.tar.gz"
  sha256 "8b4691b0a93ba1f035b0c38f4482ee207c540ce3d5aa962350fe8a965ca62cfc"

  def install
    bin.install "ld-find-code-refs"
  end

  test do
    system "#{bin}/ld-find-code-refs"
  end
end
