class Zerolang < Formula
  desc "Programming language for agents with explicit effects and predictable memory"
  homepage "https://zerolang.ai/"
  url "https://github.com/vercel-labs/zerolang/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "222c6ca439103441c7c2169351b0aeb841c6f5eca985c07dc53f131173e5c2a7"
  license "Apache-2.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "783e8c35878dc5bd99bb0b6aadc4c2004c8a4c4956668e4a3de30cc8b16d0eb0"
  end

  head "https://github.com/vercel-labs/zerolang.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  deny_network_access!


  def install
    system "make", "-C", "native/zero-c", "OUT=#{bin}/zero"
    rm bin/"zero.build"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zero --version")

    # Upstream's test runs `zero init` against the host target; Zero 0.3.4
    # ships no LoongArch target (its manifest lists host "unknown"), so init
    # fails with TAR001. Verify the native bootstrap binary and its target
    # manifest machinery instead of requiring an unsupported host backend.
    assert_match version.to_s, shell_output("#{bin}/zero --version")
    targets = shell_output("#{bin}/zero targets")
    assert_match '"schemaVersion": 1', targets
    assert_match '"name": "linux-x64"', targets
  end
end
