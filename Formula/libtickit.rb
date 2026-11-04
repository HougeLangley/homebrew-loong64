class Libtickit < Formula
  desc "Library for building interactive full-screen terminal programs"
  homepage "https://www.leonerd.org.uk/code/libtickit/"
  url "https://www.leonerd.org.uk/code/libtickit/libtickit-0.4.6.tar.gz"
  sha256 "4af827ba3aeaf591f4364c20d6e31c608e46fa6ada9ef7389ed5fba597f797b8"
  license "MIT"

  livecheck do
    url :homepage
    regex(/href=.*?libtickit[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6837b1813eb148d15494aebd0f5535a952df1cfc488ae7b9bc7c1eab68ee5971"
  end

  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "libtermkey"
  depends_on "unibilium"

  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test_libtickit.c").write <<~C
      #include <tickit.h>
      #include <stdio.h>
      int main(void) {
        printf("%d.%d.%d", tickit_version_major(), tickit_version_minor(), tickit_version_patch());
        return 0;
      }
    C

    ENV.append "CFLAGS", "-I#{include}"
    ENV.append "LDFLAGS", "-L#{lib}"
    ENV.append "LDLIBS", "-ltickit"
    system "make", "test_libtickit"

    assert_equal version.to_s, shell_output("./test_libtickit")
  end
end
