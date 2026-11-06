class Libdvbpsi < Formula
  desc "Library to decode/generate MPEG TS and DVB PSI tables"
  homepage "https://www.videolan.org/developers/libdvbpsi.html"
  url "https://get.videolan.org/libdvbpsi/1.3.3/libdvbpsi-1.3.3.tar.bz2"
  mirror "https://download.videolan.org/pub/libdvbpsi/1.3.3/libdvbpsi-1.3.3.tar.bz2"
  sha256 "02b5998bcf289cdfbd8757bedd5987e681309b0a25b3ffe6cebae599f7a00112"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "256f244e3d4269d86aede274c6f5731299c5f15362bca13745229a4e66e8b5e7"
  end

  livecheck do
    url "https://download.videolan.org/pub/libdvbpsi/"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end


  head do
    url "https://code.videolan.org/videolan/libdvbpsi.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  resource "homebrew-sample-ts", :test do
    url "https://filesamples.com/samples/video/ts/sample_640x360.ts"
    sha256 "64804df9d209528587e44d6ea49b72f74577fbe64334829de4e22f1f45c5074c"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking", "--enable-release"
    system "make", "install"
    pkgshare.install "examples/dump_pids.c"
  end

  test do
    # Adjust headers to allow the test to build without the upstream source tree
    cp pkgshare/"dump_pids.c", testpath/"test.c"
    inreplace "test.c",
              "#include \"config.h\"\n",
              "#include <inttypes.h>\n"

    system ENV.cc, testpath/"test.c", "-I#{include}", "-L#{lib}", "-ldvbpsi", "-o", "test"

    resource("homebrew-sample-ts").stage do
      output = shell_output("#{testpath}/test sample_640x360.ts")

      assert_equal 3440, output.lines.length
      output.lines.each do |line|
        assert_match(/^packet \d+, pid \d+ \(0x\d+\), cc \d+$/, line)
      end
    end
  end
end
