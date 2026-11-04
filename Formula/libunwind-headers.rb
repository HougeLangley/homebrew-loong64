class LibunwindHeaders < Formula
  desc "C API for determining the call-chain of a program"
  homepage "https://opensource.apple.com/"
  url "https://github.com/apple-oss-distributions/libunwind/archive/refs/tags/libunwind-201.tar.gz"
  sha256 "bbe469bd8778ba5a3e420823b9bf96ae98757a250f198893dee4628e0a432899"
  license "APSL-2.0"


  keg_only :shadowed_by_macos, "macOS provides libunwind.dylib (but nothing else)"

  # Apple stopped using this repository in macOS 12.3.
  # https://github.com/apple-oss-distributions/distribution-macOS/commit/a2a84eee239e63427b9bc7e011eaaba8ab878fd3
  deprecate! date: "2026-05-17", because: :unmaintained
  disable! date: "2027-05-17", because: :unmaintained

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7dfcd95c93c1b19703678ece9ef50470350d8db1e4624e9719e8cd80371e9c2b"
  end

  def install
    cd "libunwind" do
      include.install Dir["include/*"]
      (include/"libunwind").install Dir["src/*.h*"]
    end
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <libunwind.h>
      #include <mach-o/compact_unwind_encoding.h>

      int main(void) {
        printf("0x%08x\\n", (unsigned)UNWIND_ARM64_MODE_FRAME);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-o", "test"
    assert_equal "0x04000000", shell_output("./test").strip
  end
end
