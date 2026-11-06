class Stockfish < Formula
  desc "Strong open-source chess engine"
  homepage "https://stockfishchess.org/"
  url "https://github.com/official-stockfish/Stockfish/archive/refs/tags/sf_19.tar.gz"
  sha256 "519b653d0d1ffb96531d982ccbe5c6a19425e8388e0e3c2f70f34b424ab32d76"
  license "GPL-3.0-only"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f678cd004d52083fe5ff06435133336fa83d832cef828feaaa5fb5e475a74b30"
  end

  head "https://github.com/official-stockfish/Stockfish.git", branch: "master"

  livecheck do
    url :stable
    regex(/^sf[._-]v?(\d+(?:\.\d+)*)$/i)
  end


  def install
    # This tap only targets LoongArch. Use Stockfish's portable 64-bit target
    # instead of the upstream formula's non-ARM => x86-64-ssse3 fallback.
    arch = "general-64"

    system "make", "-C", "src", "build", "ARCH=#{arch}"
    bin.install "src/stockfish"
  end

  test do
    system bin/"stockfish", "go", "depth", "20"
  end
end
