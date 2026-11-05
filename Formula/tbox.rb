class Tbox < Formula
  desc "Glib-like multi-platform C library"
  homepage "https://tboox.top"
  url "https://github.com/tboox/tbox/archive/refs/tags/v1.8.2.tar.gz"
  sha256 "8601bd1443ad3e3eb998406a71c3896f8563ed1aeb94a9ccf8c17543742d508e"
  license "Apache-2.0"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "29d8aedb99c467d2a746a683ee7481b3191bdc0ed80a5506ff9eb46c5aa99301"
  end

  head "https://github.com/tboox/tbox.git", branch: "dev"

  livecheck do
    url :stable
    strategy :github_latest
  end



  depends_on "xmake" => :build

  def install
    system "xmake", "config", "--charset=y", "--demo=n", "--small=y", "--xml=y",
           "--cflags=-Wno-error=misleading-indentation"
    system "xmake"
    system "xmake", "install", "-o", prefix
  end

  test do
    (testpath/"test.c").write <<~C
      #include <tbox/tbox.h>
      int main()
      {
        if (tb_init(tb_null, tb_null))
        {
          tb_trace_i("hello tbox!");
          tb_exit();
        }
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-ltbox", "-lm", "-pthread", "-o", "test"
    assert_equal "hello tbox!\n", shell_output("./test")
  end
end
