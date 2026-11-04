class LibatomicOps < Formula
  desc "Implementations for atomic memory update operations"
  homepage "https://github.com/bdwgc/libatomic_ops/"
  url "https://github.com/bdwgc/libatomic_ops/releases/download/v7.10.0/libatomic_ops-7.10.0.tar.gz"
  sha256 "0db3ebff755db170f65e74a64ec4511812e9ee3185c232eeffeacd274190dfb0"
  license all_of: [
    "MIT",
    "Boehm-GC",         # include/atomic_ops/sysdeps/gcc/
    "GPL-2.0-or-later", # lib/libatomic_ops_gpl.*
  ]
  head "https://github.com/bdwgc/libatomic_ops.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "df1459757cba61f5908a5ef04357eb140c6b2e032485dd629a5c39a4edf99802"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :test

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DAO_BUILD_SHARED_LIBS=ON",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    "-Dbuild_tests=ON",
                    *std_cmake_args,
                    "-DBUILD_TESTING=ON" # Pass this last to override `std_cmake_args`
    system "cmake", "--build", "build"
    system "ctest", "--test-dir", "build",
                    "--parallel", ENV.make_jobs,
                    "--rerun-failed",
                    "--output-on-failure"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <string.h>
      #include <atomic_ops.h>

      typedef struct {
        AO_uintptr_t next; /* must be first */
        int value;
      } node_t;

      int main(void) {
        volatile AO_t counter = 0;
        AO_t old = AO_fetch_and_add1(&counter);
        AO_fetch_and_add(&counter, 41);
        int swapped = AO_compare_and_swap(&counter, 42, 100);
        int not_swapped = AO_compare_and_swap(&counter, 42, 200);
        printf("counter: %lu old: %lu cas: %d %d\\n", (unsigned long)AO_load(&counter),
               (unsigned long)old, swapped, not_swapped);
        return 0;
      }
    C

    flags = shell_output("pkgconf --cflags --libs atomic_ops").chomp.split
    system ENV.cc, "test.c", *flags, "-o", "test"
    assert_equal <<~EOS, shell_output("./test")
      counter: 100 old: 0 cas: 1 0
    EOS
  end
end
