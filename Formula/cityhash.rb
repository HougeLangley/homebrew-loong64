class Cityhash < Formula
  desc "Hash functions for strings"
  homepage "https://github.com/google/cityhash"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/cityhash/cityhash-1.1.1.tar.gz"
  sha256 "76a41e149f6de87156b9a9790c595ef7ad081c321f60780886b520aecb7e3db4"
  license "MIT"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6ca888b5152a8d3a12d1307b2ce9768366c870400eaab4f63b0f9cffb58299f7"
  end


  deprecate! date: "2026-05-13", because: :repo_archived
  disable! date: "2027-05-13", because: :repo_archived

  on_linux do
    on_arm do
      depends_on "autoconf" => :build
      depends_on "automake" => :build
      depends_on "libtool" => :build
    end
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if OS.linux? && Hardware::CPU.arm?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <stdio.h>
      #include <inttypes.h>
      #include <city.h>

      int main() {
        const char* a = "This is my test string";
        uint64_t result = CityHash64(a, sizeof(a));
        printf("%" PRIx64 "\\n", result);
        return 0;
      }
    CPP
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lcityhash", "-o", "test"
    assert_equal "ab7a556ed7598b04", shell_output("./test").chomp
  end
end
