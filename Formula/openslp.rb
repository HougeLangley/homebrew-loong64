class Openslp < Formula
  desc "Implementation of Service Location Protocol"
  homepage "http://www.openslp.org"
  url "https://downloads.sourceforge.net/project/openslp/2.0.0/2.0.0%20Release/openslp-2.0.0.tar.gz"
  sha256 "924337a2a8e5be043ebaea2a78365c7427ac6e9cee24610a0780808b2ba7579b"
  license "BSD-3-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4b87bb2f0f74d454fdf3a75c6e6db3014682e97e454657e59405772ccbccc367"
  end


  # Last release on 2013-06-08 which has CVEs:
  # * CVE-2016-4912
  # * CVE-2016-7567
  # * CVE-2017-17833
  # * CVE-2019-5544
  deprecate! date: "2026-05-09", because: :unmaintained
  disable! date: "2027-05-09", because: :unmaintained

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

    # Workaround for arm64 macOS to use fallback global mutex as USE_APPLE_ATOMICS
    # condition uses deprecated functions and code doesn't compile
    # Issue ref: https://github.com/openslp-org/openslp/issues/19
    inreplace "common/slp_atomic.c", <<~C, "#else\n" if OS.mac? && Hardware::CPU.arm?
      #elif defined(__APPLE__)
      # define USE_APPLE_ATOMICS
      #else
    C

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <slp.h>

      int main(void) {
        SLPHandle hslp;
        SLPError err;
        err = SLPOpen("en", SLP_FALSE, &hslp);
        SLPClose(hslp);
        return err;
      }
    C

    system ENV.cc, "test.c", "-o", "test", "-L#{lib}", "-lslp"
    system "./test"
  end
end
