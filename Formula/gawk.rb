class Gawk < Formula
  desc "GNU awk utility"
  homepage "https://www.gnu.org/software/gawk/"
  url "https://ftpmirror.gnu.org/gawk/gawk-5.4.1.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gawk/gawk-5.4.1.tar.xz"
  sha256 "07f6f7342b7febe4313fc2c2542ad93d64fe20ad8717200109f105a826f5fd37"
  license "GPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f3ec71c737a8a7b562b9ad400bbab690543b9930af71e6372925ce8d9cd62a9f"
  end

  compatibility_version 1
  head "https://git.savannah.gnu.org/git/gawk.git", branch: "master"


  depends_on "gmp"
  depends_on "mpfr"
  depends_on "readline"

  on_macos do
    depends_on "gettext"
  end

  on_linux do
    conflicts_with "awk", because: "both install an `awk` executable"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./bootstrap.sh" if build.head?

    # case-check needs libc to fold ẞ (U+1E9E) to ß, which Sonoma lacks
    if OS.mac? && MacOS.version <= :sonoma
      inreplace "test/Makefile.in", "callparam case-check childin", "callparam childin"
    end

    args = %w[
      --disable-silent-rules
      --without-libsigsegv-prefix
    ]
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args

    system "make"
    if which "cmp"
      # Cannot run pma tests in Docker container due to seccomp needed for personality syscall
      check_args = ["NEED_PMA="] if OS.linux?
      system "make", "check", *check_args
    else
      opoo "Skipping `make check` due to unavailable `cmp`"
    end
    system "make", "install"

    (bin/"awk").unlink if OS.mac?
    (libexec/"gnubin").install_symlink bin/"gawk" => "awk"
    (libexec/"gnuman/man1").install_symlink man1/"gawk.1" => "awk.1"
    (libexec/"gnubin").install_symlink "../gnuman" => "man"
  end

  def caveats
    on_macos do
      <<~EOS
        GNU "awk" has been installed as "gawk".
        If you need to use it as "awk", you can add a "gnubin" directory
        to your PATH from your ~/.bashrc and/or ~/.zshrc like:

            PATH="#{opt_libexec}/gnubin:$PATH"
      EOS
    end
  end

  test do
    output = pipe_output("#{bin}/gawk '{ gsub(/Macro/, \"Home\"); print }' -", "Macrobrew")
    assert_equal "Homebrew", output.strip
  end
end
