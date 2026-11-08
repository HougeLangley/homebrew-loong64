class B2sum < Formula
  desc "BLAKE2 b2sum reference binary"
  homepage "https://github.com/BLAKE2/BLAKE2"
  url "https://github.com/BLAKE2/BLAKE2/archive/refs/tags/20190724.tar.gz"
  sha256 "7f2c72859d462d604ab3c9b568c03e97b50a4052092205ad18733d254070ddc2"
  license any_of: ["CC0-1.0", "OpenSSL", "Apache-2.0"]


  conflicts_with "coreutils", because: "both install `b2sum` binaries"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ae83bb5e103c1e197f0352742160caeeebf00bfe3dfd2c9fb789cebcc653ce93"
  end

  def install
    cd "b2sum" do
      if Hardware::CPU.arm?
        inreplace "makefile", "../sse", "../neon"
      elsif !Hardware::CPU.intel?
        # The reference implementation is the upstream portable path; the
        # default sources require x86 SSE2 headers and intrinsics.
        inreplace "makefile", "-I../sse", "-I../ref"
        inreplace "makefile",
                  "FILES=b2sum.c ../sse/blake2b.c ../sse/blake2s.c ../sse/blake2bp.c ../sse/blake2sp.c",
                  "FILES=b2sum.c ../ref/blake2b-ref.c ../ref/blake2s-ref.c ../ref/blake2bp-ref.c ../ref/blake2sp-ref.c"
      end
      system "make", "NO_OPENMP=1"
      system "make", "install", "PREFIX=#{prefix}", "MANDIR=#{man}"
    end
  end

  test do
    checksum = "ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d1" \
               "7d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923  -"
    assert_equal checksum, pipe_output("#{bin}/b2sum -", "abc", 0).chomp
  end
end
