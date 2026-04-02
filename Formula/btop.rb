class Btop < Formula
  desc "Resource monitor. C++ version and continuation of bashtop and bpytop"
  homepage "https://github.com/aristocratos/btop"
  url "https://github.com/aristocratos/btop/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "ac0de1b6e0b3276f95a90d749aae3c8b9d0e5f2e3b6c8d9a7b6c5d4e3f2a1b0c9d"
  license "Apache-2.0"

  depends_on "coreutils" => :build
  depends_on "gcc"
  depends_on "linux-headers@5.15" => :build

  fails_with :clang

  def install
    system "make", "CXX=#{ENV.cxx}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"btop", "--version"
  end
end
