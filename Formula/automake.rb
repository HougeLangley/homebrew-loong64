class Automake < Formula
  desc "Tool for generating GNU Standards-compliant Makefiles"
  homepage "https://www.gnu.org/software/automake/"
  url "https://ftpmirror.gnu.org/automake/automake-1.19.tar.xz"
  mirror "https://ftp.gnu.org/gnu/automake/automake-1.19.tar.xz"
  sha256 "e3e2c2e3abf37898138db5b6c1d1dc35c9160c5978be7947d2c741705251d445"
  license "GPL-2.0-or-later"
  compatibility_version 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b79879b53f98b85e2456a76e6c6458f8e1788c8cdde95b7603850b59098807bd"
  end

  depends_on "autoconf"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV["PERL"] = "/usr/bin/perl" if OS.mac?

    # We specify `HOMEBREW_PREFIX` so that aclocal is compiled with the
    # correct system value for acdir (`HOMEBREW_PREFIX/share/aclocal`)
    # We also patch `configure` so that the normal installation prefix
    # is used when we call `make install`
    inreplace "configure", "${datadir}", "${datarootdir}"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--sysconfdir=#{etc}",
                          "--localstatedir=#{var}",
                          "--datarootdir=#{share}",
                          "--datadir=#{HOMEBREW_PREFIX}/share",
                          *std_configure_args
    system "make", "install"

    # Use dirlist to add common search dirs for aclocal
    (share/"aclocal/dirlist").write <<~EOS
      /usr/share/aclocal
    EOS
  end

  test do
    # Check that the compiled system value for acdir does not use automake's versioned path
    assert_equal "#{HOMEBREW_PREFIX}/share/aclocal", shell_output("#{bin}/aclocal --print-ac-dir").chomp

    (testpath/"test.c").write <<~C
      int main() { return 0; }
    C
    (testpath/"configure.ac").write <<~M4
      AC_INIT(test, 1.0)
      AM_INIT_AUTOMAKE
      AC_PROG_CC
      AC_CONFIG_FILES(Makefile)
      AC_OUTPUT
    M4
    (testpath/"Makefile.am").write <<~MAKE
      bin_PROGRAMS = test
      test_SOURCES = test.c
    MAKE
    system bin/"aclocal"
    system bin/"automake", "--add-missing", "--foreign"
    system "autoconf"
    system "./configure"
    system "make"
    system "./test"
  end
end
