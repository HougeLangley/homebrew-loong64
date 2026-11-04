class Libflowmanager < Formula
  desc "Flow-based measurement tasks with packet-based inputs"
  homepage "https://github.com/LibtraceTeam/libflowmanager"
  url "https://github.com/LibtraceTeam/libflowmanager/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "ab60c9c9611488e51c14b6e3870f91a191236dced12f0ed16a58cdd2c08ee74f"
  license "LGPL-3.0-or-later"
  revision 2

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "35ee0b639637f5b0d5f6ecbf3a7375a16709d054e7e910b93edfe439df5aea3d"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libtrace"

  # Fix: tcp_reorder.c:74:30: error: ‘UINT32_MAX’ undeclared (first use in this function)
  # Remove in the next release
  patch do
    url "https://github.com/LibtraceTeam/libflowmanager/commit/a60a04a3b4a12faf48854b34908f9db0c4f080b0.patch?full_index=1"
    sha256 "15d93f863374eff428c69e6e1733bdc861c831714f8d7d7c1323ebf1b9ba9a4c"
    type :backport
  end

  deny_network_access!

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <libtrace.h>
      #include <libflowmanager.h>

      int main() {
        bool opt = true;
        FlowManager *fm = new FlowManager();
        if (fm->setConfigOption(LFM_CONFIG_IGNORE_RFC1918, &opt) == 0) return 1;
        delete fm;
        return 0;
      }
    CPP

    libtrace = Formula["libtrace"]
    system ENV.cxx, "test.cpp", "-I#{include}", "-I#{libtrace.opt_include}",
           "-L#{lib}", "-L#{libtrace.opt_lib}", "-lflowmanager", "-ltrace", "-o", "test"
    system "./test"
  end
end
