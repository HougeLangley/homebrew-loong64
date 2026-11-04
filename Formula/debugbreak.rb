class Debugbreak < Formula
  desc "Break into the debugger programmatically"
  homepage "https://github.com/scottt/debugbreak"
  url "https://github.com/scottt/debugbreak/archive/refs/tags/v1.0.tar.gz"
  sha256 "62089680cc1cd0857519e2865b274ed7534bfa7ddfce19d72ffee41d4921ae2f"
  license "BSD-2-Clause"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0de1f43567c9abfd889ac0e6c31fa515e993890e7c3d7b2abd4c0650adba622f"
  end

  def install
    include.install "debugbreak.h"
    pkgshare.install "debugbreak-gdb.py"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <debugbreak.h>
      int main() {
        debug_break(); /* will break into debugger */
        return 0;
      }
    C
    system ENV.cc, "-I#{include}", "test.c", "-o", "test"
    pid = Process.spawn("./test")
    assert_equal Signal.list.fetch("TRAP"), Process::Status.wait(pid).termsig
  end
end
