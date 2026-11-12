class Cloog < Formula
  desc "Generate code for scanning Z-polyhedra"
  homepage "https://github.com/periscop/cloog"
  url "https://github.com/periscop/cloog/releases/download/cloog-0.21.1/cloog-0.21.1.tar.gz"
  sha256 "d370cf9990d2be24bfb24750e355bac26110051248cabf2add61f9b3867fb1d7"
  license "LGPL-2.1-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e57ebe6c813bbcfbd85853d3b90d2cfb5b27061e781ff3930fab7d0086fe51c8"
  end

  depends_on "pkgconf" => :build
  depends_on "gmp"
  depends_on "isl"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Avoid doc build.
    ENV["ac_cv_prog_TEXI2DVI"] = ""

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules",
                          "--with-gmp=system",
                          "--with-gmp-prefix=#{formula_opt_prefix("gmp")}",
                          "--with-isl=system",
                          "--with-isl-prefix=#{formula_opt_prefix("isl")}",
                          *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cloog").write <<~EOS
      c

      0 2
      0

      1

      1
      0 2
      0 0 0
      0

      0
    EOS

    assert_match %r{Generated from #{testpath}/test.cloog by CLooG},
                 shell_output("#{bin}/cloog #{testpath}/test.cloog")
  end
end
