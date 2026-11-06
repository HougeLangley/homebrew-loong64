class Idutils < Formula
  desc "ID database and query tools"
  homepage "https://www.gnu.org/software/idutils/"
  url "https://ftpmirror.gnu.org/idutils/idutils-4.6.tar.xz"
  mirror "https://ftp.gnu.org/gnu/idutils/idutils-4.6.tar.xz"
  sha256 "8181f43a4fb62f6f0ccf3b84dbe9bec71ecabd6dfdcf49c6b5584521c888aac2"
  license "GPL-3.0-or-later"
  revision 1

  livecheck do
    url :stable
    regex(/href=.*?idutils[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  conflicts_with "coreutils", because: "both install `gid` and `gid.1`"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5c0c08eed7386c4319ca1350f1f8b83a76d0873d51289c03b7c8d44e74404fe1"
  end

  patch :p0 do
    on_macos do
      url "https://raw.githubusercontent.com/macports/macports-ports/b76d1e48dac/editors/nano/files/secure_snprintf.patch"
      sha256 "57f972940a10d448efbd3d5ba46e65979ae4eea93681a85e1d998060b356e0d2"
      type :unofficial
    end
  end

  # Fix build on Linux. Upstream issue:
  # https://savannah.gnu.org/bugs/?57429
  # Patch submitted here:
  # https://savannah.gnu.org/patch/index.php?10240
  patch :DATA

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = ["--disable-silent-rules", "--with-lispdir=#{elisp}"]
    if OS.linux?
      # Help old config scripts identify arm64 linux
      args << "--build=aarch64-unknown-linux-gnu" if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64
      args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64
      # Workaround to use outdated gnulib with glibc 2.28+ based on gnulib fix[^1].
      # Upstream updated to newer gnulib[^2] which should fix issue in next release.
      #
      # [^1]: https://github.com/coreutils/gnulib/commit/4af4a4a71827c0bc5e0ec67af23edef4f15cee8e
      # [^2]: https://git.savannah.gnu.org/cgit/idutils.git/commit/?id=6efa403e105381a468d8b2cb8c254c1c217d1b53
      ENV.append_to_cflags "-D_IO_ftrylockfile -D_IO_IN_BACKUP=0x100"
    end

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"mkid", "#{MacOS.sdk_path if OS.mac?}/usr/include"

    system bin/"lid", "FILE"
  end
end

__END__
diff --git a/lib/stdio.in.h b/lib/stdio.in.h
index 0481930..79720e0 100644
--- a/lib/stdio.in.h
+++ b/lib/stdio.in.h
@@ -715,7 +715,6 @@ _GL_CXXALIASWARN (gets);
 /* It is very rare that the developer ever has full control of stdin,
    so any use of gets warrants an unconditional warning.  Assume it is
    always declared, since it is required by C89.  */
-_GL_WARN_ON_USE (gets, "gets is a security hole - use fgets instead");
 #endif
