class Libseccomp < Formula
  desc "Interface to the Linux Kernel's syscall filtering mechanism"
  homepage "https://github.com/seccomp/libseccomp"
  url "https://github.com/seccomp/libseccomp/releases/download/v2.6.1/libseccomp-2.6.1.tar.gz"
  sha256 "501f66c667225d53791b97e1d7cf85ab764c297d04881f60f38f451c4b0ee1be"
  license "LGPL-2.1-only"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "bede49a59fe2c25011edadde0c5e25fd055882918ecf271dcd2ba101c5b2ca23"
  end

  compatibility_version 1

  livecheck do
    url :stable
    strategy :github_latest
  end


  head do
    url "https://github.com/seccomp/libseccomp.git", branch: "main"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "gperf" => :build
  depends_on :linux

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./autogen.sh" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    ver_major, ver_minor, = version.to_s.split(".")

    (testpath/"test.c").write <<~C
      #include <seccomp.h>
      int main(int argc, char *argv[])
      {
        if(SCMP_VER_MAJOR != #{ver_major})
          return 1;
        if(SCMP_VER_MINOR != #{ver_minor})
          return 1;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lseccomp", "-o", "test"
    system "./test"
  end
end
