class Premake < Formula
  desc "Write once, build anywhere Lua-based build system"
  homepage "https://premake.github.io/"
  url "https://github.com/premake/premake-core/archive/refs/tags/v5.0.0.tar.gz"
  sha256 "ed52d17463112d6b93bc6e34bb6e15c6332e1f313ad5259fdde60e270aa30aec"
  license "BSD-3-Clause"
  version_scheme 1
  head "https://github.com/premake/premake-core.git", branch: "master"


  on_linux do
    depends_on "util-linux" # for uuid
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b47224be21187d89bb796d23db1a40ce20a474f682fdfab441c78d1e21894cef"
  end

  def install
    platform = OS.mac? ? "osx" : "linux"
    system "make", "-f", "Bootstrap.mak", platform
    system "./bin/release/premake5", "gmake"
    system "./bin/release/premake5", "embed"
    system "make"
    bin.install "bin/release/premake5"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/premake5 --version")
  end
end
