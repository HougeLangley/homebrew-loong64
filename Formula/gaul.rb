class Gaul < Formula
  desc "Genetic Algorithm Utility Library"
  homepage "https://gaul.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/gaul/gaul-devel/0.1850-0/gaul-devel-0.1850-0.tar.gz"
  sha256 "7aabb5c1c218911054164c3fca4f5c5f0b9c8d9bab8b2273f48a3ff573da6570"
  license "GPL-2.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4b5940470e766d4df294f1fc97fb309a013f84f3927bb6cc0332e47b09c0a955"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  resource "gaul-examples", :test do
    url "https://downloads.sourceforge.net/project/gaul/gaul-examples/0.1849/gaul-examples-0.1849-0.tar.bz2"
    sha256 "f4f59a0d676b0d58ba068424dfcb2c1715ff9aeaa940cab2daebff323274594c"
  end

  def install
    # Run autoreconf to regenerate the configure script and update outdated macros.
    # This ensures that the build system is properly configured on both macOS
    # (avoiding issues like flat namespace conflicts) and Linux (where outdated
    # config scripts may fail to detect the correct build type).
    system "autoreconf", "--force", "--verbose", "--install"
    system "./configure", "--disable-g", *std_configure_args
    system "make", "install"
  end

  test do
    testpath.install resource("gaul-examples")

    system ENV.cc, "src/struggle.c", "-o", "test", "-L#{lib}", "-lgaul_util", "-lgaul"
    assert_match "The solution with seed = 49 was:\nWhen w^ yeil^ct%on%this strsggln,", shell_output("./test")
  end
end
