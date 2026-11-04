class Zerolang < Formula
  desc "Programming language for agents with explicit effects and predictable memory"
  homepage "https://zerolang.ai/"
  url "https://github.com/vercel-labs/zerolang/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "222c6ca439103441c7c2169351b0aeb841c6f5eca985c07dc53f131173e5c2a7"
  license "Apache-2.0"
  head "https://github.com/vercel-labs/zerolang.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b15d54cb0f765e19724d67a67e8fc5b590a11d3128c13c08bb53a244ddf2f62b"
  end

  def install
    system "make", "-C", "native/zero-c", "OUT=#{bin}/zero"
    rm bin/"zero.build"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zero --version")

    (testpath/"src/main.0").write <<~ZERO
      pub fn main(world: World) -> Void raises {
        check world.out.write("hello")
      }
    ZERO
    system bin/"zero", "init"
    system bin/"zero", "import"
    system bin/"zero", "check"
    assert_match "hello", shell_output("#{bin}/zero run")
  end
end
