class DyldHeaders < Formula
  desc "Header files for the dynamic linker"
  homepage "https://opensource.apple.com/"
  url "https://github.com/apple-oss-distributions/dyld/archive/refs/tags/dyld-1378.tar.gz"
  sha256 "509c8b081153a7b9ff08d6ddf0a681c0ab5190e1e336ef2e9748b801bdb9c59e"
  license "APSL-2.0"


  keg_only :provided_by_macos

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "508ca9be409240808d6b24734039dd863671aacfe9133e018f10fc0f513b2791"
  end

  def install
    include.install Dir["include/*"]
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <mach-o/fixup-chains.h>

      int main(void) {
        struct dyld_chained_fixups_header header = { .fixups_version = 0, .imports_format = DYLD_CHAINED_IMPORT };
        printf("%zu %u %d\\n", sizeof(header), header.imports_format, DYLD_CHAINED_PTR_ARM64E);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-o", "test"
    assert_equal "28 1 1", shell_output("./test").strip
  end
end
