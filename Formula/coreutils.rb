class Coreutils < Formula
  desc "GNU File, Shell, and Text utilities"
  homepage "https://www.gnu.org/software/coreutils/"
  url "https://ftp.gnu.org/gnu/coreutils/coreutils-9.6.tar.xz"
  sha256 "7a8d9ee03334ee53c0e4659b4e4ebcb3eb9564855e9b8f4e2db5f55d4c24bb32"
  license "GPL-3.0-or-later"

  def install
    args = %W[
      --prefix=#{prefix}
      --program-prefix=g
      --without-gmp
    ]
    
    system "./configure", *args
    system "make", "install"
    
    # Create symlinks without g prefix
    coreutils_filenames(bin).each do |cmd|
      (libexec/"gnubin").install_symlink bin/"g#{cmd}" => cmd
      (libexec/"gnuman/man1").install_symlink man1/"g#{cmd}.1" => "#{cmd}.1"
    end
    libexec.install_symlink "gnuman" => "man"
  end

  def coreutils_filenames(dir)
    filenames = []
    dir.find do |path|
      next if path.directory? || path.basename.to_s == ".DS_Store"
      filenames << path.basename.to_s.sub(/^g/, "")
    end
    filenames.sort
  end

  test do
    system bin/"gls", "--version"
  end
end
