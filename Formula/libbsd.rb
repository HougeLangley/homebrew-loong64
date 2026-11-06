class Libbsd < Formula
  desc "Utility functions from BSD systems"
  homepage "https://libbsd.freedesktop.org/"
  url "https://libbsd.freedesktop.org/releases/libbsd-0.12.2.tar.xz"
  sha256 "b88cc9163d0c652aaf39a99991d974ddba1c3a9711db8f1b5838af2a14731014"
  license all_of: [
    "BSD-3-Clause",
    "BSD-2-Clause",
    "Beerware",
    "ISC",
    "libutil-David-Nugent",
    "MIT",
    :public_domain,
  ]

  livecheck do
    url "https://libbsd.freedesktop.org/releases/"
    regex(/href=.*?libbsd[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "84f9686416a6d0d368cbd3921b028f7706c872b98f723e14ba05dcf12f5d4e66"
  end

  head do
    url "https://gitlab.freedesktop.org/libbsd/libbsd.git", branch: "main"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  on_linux do
    depends_on "libmd"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./autogen" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <bsd/stdlib.h>

      int main(void) {
        const char *q;
        long long val = strtonum("1", 0, 10, &q);
        if (q != NULL) {
          printf("%s", q);
          return 1;
        }
        return 0;
      }
    C
    system ENV.cc, "test.c", "-o", "test", lib/shared_library("libbsd", version.major.to_s)
    system "./test"
  end
end
