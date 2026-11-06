class Liblbfgs < Formula
  desc "C library for limited-memory BFGS optimization algorithm"
  homepage "https://www.chokkan.org/software/liblbfgs"
  url "https://github.com/chokkan/liblbfgs/archive/refs/tags/v1.10.tar.gz"
  sha256 "95c1997e6c215c58738f5f723ca225d64c8070056081a23d636160ff2169bd2f"
  license "MIT"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8be7ace25387be63fdab5cb4f95c711b63b42ab274995fa521de1d1a8e2f524c"
  end


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
    pkgshare.install "sample/sample.c"
  end

  test do
    cp pkgshare/"sample.c", testpath/"sample.c"
    system ENV.cc, "sample.c", "-I#{include}", "-L#{lib}", "-llbfgs", "-o", "./test"
    output = shell_output("./test")

    assert_match "L-BFGS optimization terminated with status code = 0", output
    assert_match "fx = 0.000000, x[0] = 1.000000, x[1] = 1.000000", output
  end
end
