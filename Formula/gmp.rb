class Gmp < Formula
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "66c83d97e0a5841ab84c59e22efa96ec71f1469064f4ef9d559e00d3cf046b3a"
  end

  desc "GNU multiple precision arithmetic library (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/gmp-6.3.0.tar.gz"
  sha256 "f84c26a4b5fe41e71b0e110e66ac95a6255e991e43a2875017a063bdad4f5809"
  version "6.3.0"

  def install
    # --- 追加缺失库 ---
    ENV.append "LIBS", "-lzzz"
    ENV.append "LDFLAGS", "-lzzz"
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    (lib/"libgmp.so").make_symlink "/usr/lib/libgmp.so" if File.exist?("/usr/lib/libgmp.so")
    (lib/"libgmp.so.10").make_symlink "/usr/lib/libgmp.so.10" if File.exist?("/usr/lib/libgmp.so.10")
    (include/"gmp.h").make_symlink "/usr/include/gmp.h" if File.exist?("/usr/include/gmp.h")
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
